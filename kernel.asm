use16

_main:
	mov ah, 00h ; int 10h set video mode
	mov al, 03h ; video mode text mode 16 colors 80x25
	int 10h ; int 10h
	
	mov sp, stack_start ; Set stack pointer (Let's avoid errors!)
	mov bp, stack_start ; Set stack bottom
	
	mov ah, 03h
	mov al, 05h
	mov ch, 00h
	mov cl, 00h
	mov dl, 80h
	mov dh, 01h
	
	;b4 0e b0 66 cd 10 c3
	mov si, 00h
	mov [si], byte 0b4h
	mov [si+1], byte 0eh
	mov [si+2], byte 0b0h
	mov [si+3], byte 066h
	mov [si+4], byte 0cdh
	mov [si+5], byte 010h
	mov [si+6], byte 0c3h
	
	mov cx, 00h
	mov es, cx
	mov bx, cx
	
	int 13h
	
	MOV AH,02h
	MOV AL,01h ;10 sectores a leer
	MOV CH,00h ;Cilindro 2
	MOV CL,00h ;Empezamos desde el primer sector
	MOV DH,01 ;Cabeza 1
	MOV DL,80h ;Primera disquetera
	MOV BX,00h ;ES:BX - 0000:0800
	INT 13h
	call 0000h:7e00h ;Saltamos a la direccion que acaba de leer
	
	
	
	call _term
	
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
		
		cmp ah, 0Eh
		je _backSpaceKey
			
		mov bh, [textCursorXPos]
		cmp bh, 20
		jge _readkeyb
		
		mov [si+0], al
		mov [si+1], byte ''
		call escribir
		jmp _readkeyb
		
		_backSpaceKey:
			mov bh, [textCursorXPos]
			cmp bh, 03h
			call borrar
				
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

stack_end:
    times 4096 db 0 ; 4KB stack
stack_start:
