escribir:
	push si	; saves to stack
	.next:
		mov dl, [textCursorXPos]
		mov dh, [textCursorYPos]
		mov bh, 00h
		mov ah, 02h
		int 10h
		
		mov al, [si] ; mov to al content of address si
		cmp al, 00h ; compare
		je .done ; if equal jump
		mov ah, 0eh ; teletype
		mov cx, 01h
		mov bx, 01h
		int 10h ; int
		
		inc si ; increment + 1 si
		mov bh, [textCursorXPos]
		inc bh
		mov [textCursorXPos], bh
		 
		jmp .next ; inconditional jump
	.done:
		pop si ; gets from stack
		ret

borrar:
	push si	; saves to stack
	.next:
		mov dl, [textCursorXPos]
		mov dh, [textCursorYPos]
		dec dl
		mov [textCursorXPos], dl
		
		mov bh, 00h
		mov ah, 02h
		int 10h
		
		mov al, 00h
		mov bh, 00h
		mov cx, 01h
		mov ah, 0Ah
		int 10h ; int
		
		 
		jmp .done ; inconditional jump
	.done:
		pop si ; gets from stack
		ret

		
