use16 ; use 16bit asm
org 0x7C00 ; start boot program from address 0x7C00


_start:
	
	jmp _loadkernel
	
	
	
;jmp _start
_loadkernel:
	mov ah, 02h
	mov al, 01h ; number of sectors to read
	mov dl, 00h ; select drive number
	mov dh, 00h ; select head number
	mov ch, 00h ; cylinder number
	mov bx, 100h ; data buffer
	mov es, bx
	mov bx, 00h
	
	int 13h
	
	jc _loadkernel ; if carry flag = 1, cs
	
	;move all to position where kernel loads (100h)
	
	mov ax, 100h
	mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    
    jmp 100h:00h
	


;bootMsg db "Hello to bootloader", 0 ; variable


times 510-($-$$) db 0  ; define start
dw 0xAA55 ; variable
