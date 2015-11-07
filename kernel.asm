use16

_main:
	mov ah, 00h ; int 10h set video mode
	mov al, 03h ; video mode text mode 16 colors 80x25
	int 10h ; int 10h
	
	call _term
	;call _gui
	
	jmp $


_gui:
	mov ah, 00h
	mov al, 0Dh
	int 10h
	
	mov ah, 0Eh
	mov al, 1Eh
	mov bl, 5h
	int 10h
	
	
	
	jmp _mousem
	_mousem:
		mov ax, 03h
		int 33h
		
		mov ah, 02h
		mov bh, 01h
		mov dl, ch
		mov dh, dh
		int 10h
		
		mov ah, 0Eh
		mov al, 1Eh
		mov bl, 5h
		int 10h
		jmp _mousem
	
	jmp $

_term:
	mov [si], byte '*'
	mov [si+1], byte '('
	mov [si+2], byte ''
	call escribir
	
	_readkeyb:
		mov ah, 00h
		int 16h
		
		cmp ah, 1Ch
		je _enterKey
			
		mov bh, [textCursorXPos]
		cmp bh, 20
		jge _readkeyb
		
		mov [si+0], al
		mov [si+1], byte ''
		call escribir
		jmp _readkeyb
		
		_enterKey:
			mov bh, [textCursorYPos]
			inc bh
			mov [textCursorYPos], bh
			mov [textCursorXPos], 00h
			jmp _term
			
		.done:
			ret
	

		
include 'stdio.asm'

textCursorXPos db 00h
textCursorYPos db 00h
kernelMsg db "hello", 0
