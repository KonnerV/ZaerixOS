
strcmp:
  
  mov al, [si]
  cmp al, [di]
  jg .gt
  jl .lt

  
  cmp byte [si], 0
  je .end

  
  inc si
  inc di
  jmp strcmp
.gt:
  mov ax, 1
  ret
.lt:
  mov ax, -1
  ret
.end:
  mov ax, 0
  ret
