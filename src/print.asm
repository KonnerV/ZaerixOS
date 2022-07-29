
printchar:
  pusha
  
  mov ah, 0x0E
  
  mov bh, 0x00
  int 0x10
  popa
  ret

os_print:
  lodsb
  
  cmp al, 0x00
  jz .end
  call printchar
  jmp os_print

.end:
  ret

os_println:
  call os_print

  mov al, `\n`
  call printchar

  mov al, `\r`
  call printchar

  ret

os_printhex:
  mov cx, 4 ; A 16-bit number has 4 hexadecimal digits
  ror bx, 12
.loop:
  cmp cx, 0
  je .end

  mov ax, bx
  and ax, 0x000F

  add ax, `0` 

  cmp ax, `9`
  jle .skip
  add ax, 7
.skip:
  call printchar
  ror bx, 4
  dec cx
  jmp .loop
.end:
  ret
