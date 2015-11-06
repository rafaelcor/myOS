escribir:
	push si	; saves to stack
	.next:
		mov al, [si] ; mov to al content of address si
		cmp al, 00h ; compare
		je .done ; if equal jump
		mov ah, 0Eh ; teletype
		int 10h ; int
		inc si ; increment + 1 si
		inc [textCursorPos]
		 
		jmp .next ; inconditional jump
	.done:
		pop si ; gets from stack
		ret

		
