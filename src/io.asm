
%define KEY_BACKSPACE 0x0E
%define KEY_ENTER 0x1C


SCREEN_COLOR: db 0x07


set_color:
  mov byte [SCREEN_COLOR], bl
  ret

clr_screen:
  
  mov ah, 0x06
  
  mov al, 0x00
  
  mov bh, [SCREEN_COLOR]
  
  mov cx, 0x0000
  mov dx, 0x184F
  int 0x10

  
  mov dx, 0x0000
  call move_cursor

  ret

move_cursor:
  
  mov ah, 0x02
  
  mov bh, 0x00
  int 0x10
  ret


readln:
  
  mov dh, dl

.loop:
  ; Read key press
  mov ah, 0x00
  int 0x16

  cmp ah, KEY_BACKSPACE
  je .backspace

  cmp ah, KEY_ENTER
  je .end

  cmp dl, 1
  je .loop

  
  stosb
  call printchar

  sub dl, 1
  jmp .loop

.backspace:
  
  cmp dh, dl
  je .loop

  
  mov al, `\b`
  call printchar
  mov al, ' '
  call printchar
  mov al, `\b`
  call printchar
  add dl, 1
  sub di, 1
  jmp .loop

.end:
  mov al, 0
  stosb
  ret
