use16

_main:
	mov ah, 00h ; int 10h set video mode
	mov al, 03h ; video mode text mode 16 colors 80x25
	int 10h ; int 10h
	
	
	call _term
	
	;jmp $


_term:
	mov [si], byte '*'
	mov [si+1], byte '('
	mov [si+2], byte ''
	call escribir
	
	_readkeyb:
		mov ah, 00h
		int 16h
		
		cmp ah, 0Eh
		je _enterKey
		
		_enterKey:
			mov bh, [textCursorYPos]
			inc bh
			mov [textCursorYPos], bh
			
			
			
		mov bh, [textCursorXPos]
		cmp bh, 20
		jge _readkeyb
		
		mov [si+0], al
		mov [si+1], byte ''
		call escribir
		jmp _readkeyb
		.done:
			ret
	
	
	
include 'stdio.asm'

textCursorXPos db 00h
textCursorYPos db 00h
kernelMsg db "hello", 0
