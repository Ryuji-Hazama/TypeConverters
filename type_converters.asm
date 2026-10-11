section .text
	global ascii_to_int	; Make this function visible

ascii_to_int:
	xor rax, rax	; Clear accumulator
	xor rcx, rcx	; Clear RCX to use as a temporary byte holder

.loop:
	mov cl, byte [rsi]	; Load the current character
	cmp cl, 0		; Check for null terminator (EOS)
	je .done
	cmp cl, 0Ah		; Check for newline character (\n)
	je .done

	sub rcx, '0'		; Convert ASCII character to actual number
	imul rax, rax, 10	; Multiply current total by 10
	add rax, rcx		; Add new digit

	inc rsi			; Move to the next character pointer
	jmp .loop

.done:
	ret		; Return to caller
