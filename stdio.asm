escribir:
	push si	; saves to stack
	.next:
		mov dl, [textCursorXPos]
		mov dh, [textCursorYPos]
		mov ah, 02h
		int 10h
		
		mov al, [si] ; mov to al content of address si
		cmp al, 00h ; compare
		je .done ; if equal jump
		mov ah, 0Eh ; teletype
		int 10h ; int
		
		inc si ; increment + 1 si
		mov bh, [textCursorXPos]
		inc bh
		mov [textCursorXPos], bh
		 
		jmp .next ; inconditional jump
	.done:
		pop si ; gets from stack
		ret

		
