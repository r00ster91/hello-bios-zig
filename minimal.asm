; For reference

bits 16
org 0x7C00

mov ah, 0xE
mov al, 'x'
int 0x10

times 510 - ($-$$) db 0
dw 0xAA55
