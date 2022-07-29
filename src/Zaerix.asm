[bits 16]
[org 0x7C00]

%define INPUT_BUFFER_LEN 128

start:
  
  cld

  ; Set DS and ES to 0
  xor ax, ax
  mov ds, ax
  mov es, ax

  mov bx, 0x8000
  cli
  mov ss, bx
  mov sp, ax
  sti

  
reset_floppy:
  mov dl, 0x00
  
  mov ah, 0x00
  int 0x13
  
  jnc read_snd_stage
  
  mov si, RESET_FLOPPY_ERROR
  call os_println
  jmp reset_floppy

read_snd_stage:
  
  mov bx, 0x7E00
  mov cx, 0x0002 
  mov dx, 0x0000 
  mov ax, 0x0201 
  int 0x13
  jnc execute_snd_stage 

read_snd_stage_err:
  mov si, READ_SND_STAGE_ERROR
  call os_println
  jmp read_snd_stage

execute_snd_stage:
  cmp al, 0x01 
  jne read_snd_stage_err
  jmp 0x0000:0x7E00

; // Includes //
%include "print.asm"

; // Strings //
RESET_FLOPPY_ERROR: db "Failed to reset the floppy drive. Trying again...", 0
READ_SND_STAGE_ERROR: db "Failed to read the second stage from the floppy drive. Trying again...", 0

times 510-($-$$) db 0x00
dw 0xAA55

main:
  call clr_screen

  mov si, WELCOME_MSG
  call os_println

input_loop:
  mov si, PROMPT
  call os_print

  mov di, INPUT_BUFFER
  mov dl, INPUT_BUFFER_LEN
  call readln

  mov si, EMPTY
  call os_println

  mov si, INPUT_BUFFER
  mov di, HELP_CMD_NAME
  call strcmp
  cmp ax, 0
  je help_command

  mov si, INPUT_BUFFER
  mov di, CLR_CMD_NAME
  call strcmp
  cmp ax, 0
  je clr_command

  mov si, INPUT_BUFFER
  mov di, HOMESCRN_CMD
  call strcmp
  cmp ax, 0
  je home_command  

  mov si, UNKNOWN_CMD
  call os_println

  jmp input_loop

help_command:
  mov si, HELP_CMD
  call os_println
  jmp input_loop

clr_command:
  call clr_screen
  jmp input_loop

home_command:
  call clr_screen
  mov si, WELCOME_MSG
  call os_println
  jmp input_loop

; // Includes //
%include "io.asm"
%include "string.asm"

; // Strings //
WELCOME_MSG: db "Welcome to ZaerixOS!!!!", 0
PROMPT: db "#~/ ", 0
INPUT_BUFFER: times INPUT_BUFFER_LEN db 0x00
EMPTY: db 0

HELP_CMD_NAME: db "help", 0
HELP_CMD: db "Commands: help, clr and homescrn.", 0
HOMESCRN_CMD: db "homescrn", 0
CLR_CMD_NAME: db "clr", 0
UNKNOWN_CMD: db "No such command.", 0

%assign SizeOfOS $ - $$
%warning Size of the OS: SizeOfOS bytes	