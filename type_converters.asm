section .text
	global ascii_to_int	; Make these functions visible
	global int_to_ascii

ascii_to_int:
	xor rax, rax	; Clear accumulator
	xor rcx, rcx	; Clear RCX to use as a temporary byte holder

.loop_s2i:
	mov cl, byte [rsi]	; Load the current character
	cmp cl, 0		; Check for null terminator (EOS)
	je .done
	cmp cl, 0Ah		; Check for newline character (\n)
	je .done

	sub cl, '0'		; Convert ASCII character to actual number
	imul rax, rax, 10	; Multiply current total by 10
	add rax, rcx		; Add new digit

	inc rsi			; Move to the next character pointer
	jmp .loop_s2i

.done:
	ret			; Return to caller

int_to_ascii:
section .bss
	buffer resb 21		; Reserve 21 bytes

section .text
	mov r8, 10		; Base 10 devisor
	mov rsi, buffer + 21	; Move pointer to the position 21

	mov byte [rsi], 0	; Null-terminate string

.loop_i2s:
	xor rdx, rdx		; Clear RDX before division
	div r8			; RAX = quotient, RDX = remainder

	add dl, '0'		; Convert number to ASCII
	dec rsi			; Decrement pointer
	mov [rsi], dl		; Store a result to buffer

	cmp rax, 0		; Check if RAX is 0
	jne .loop_i2s		; Jump to loop if not

	mov rax, rsi		; Return the pointer to RAX if RAX is 0
	mov rdx, buffer + 21
	sub rdx, rsi		; Calculate the length of the string
	ret
