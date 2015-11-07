use16 ; use 16bit asm
org 0x7C00 ; start boot program from address 0x7C00


_start:
	
	jmp _loadkernel
	
	
	
;jmp _start
_loadkernel:
	mov dl, 80h ; select drive number
	mov dh, 00h ; select head number
	mov ch, 00h ; cylinder number
	mov cl, 02h ; sector number (bootloader=1, kernel=2)
	mov al, 40h ; sectors qty
	mov bx, 7E0h ; data buffer
	mov es, bx
	mov bx, 00h
	
	mov ah, 02h
	int 13h
	
	jc _loadkernel ; if carry flag = 1, cs
	
	;move all to position where kernel loads (100h)
	
	mov ax, 7E0h
	mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    jmp 7E0h:00h
	


;bootMsg db "Hello to bootloader", 0 ; variable


times 510-($-$$) db 0  ; define start
dw 0xAA55 ; variable
