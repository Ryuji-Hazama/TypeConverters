section .text

	; - - - ; Declare Global Function ; - - - ;

	global ascii_to_int	; Make these functions visible
	global int_to_ascii

	; - - - ; Integer <-> String ; - - - ;

ascii_to_int:
	; - - - - - - - - - - - - - - ;
	; Convert string specified by ;
	; the RSI pointer to integer  ;
	; - - - - - - - - - - - - - - ;

	xor eax, eax		; Clear accumulator
	xor ecx, ecx		; Clear RCX to use as a temporary byte holder
	xor r8, r8		; Clear sign flag

	cmp byte [esi], '-'	; Check for the negative simbol
	jne .loop_s2i		; Jump to loop if not
	inc esi			; Skip negative simblol
	mov r8, 1		; Set sign flag

.loop_s2i:
	mov cl, byte [esi]	; Load the current character
	cmp cl, 0		; Check for null terminator (EOS)
	je .convert_to_negative
	cmp cl, 0Ah		; Check for newline character (\n)
	je .convert_to_negative

	sub cl, '0'		; Convert ASCII character to actual number
	imul eax, eax, 10	; Multiply current total by 10
	add eax, ecx		; Add new digit

	inc esi			; Move to the next character pointer
	jmp .loop_s2i

.convert_to_negative:
	cmp r8, 0		; Check for the sign flag
	je .done_s2i
	not eax			; Invert all digits
	inc eax			; Add 1 to RAX

.done_s2i:
	ret			; Return to caller

int_to_ascii:
	; - - - - - - - - - - - - - - - - - - ;
	; Convert integer in RAX to string.   ;
	; Store string pointer into RSI and   ;
	; store result string length into RDX ;
	; - - - - - - - - - - - - - - - - - - ;

section .bss
	buffer resb 12		; Reserve 21 bytes

section .text
	mov r9, 10		; Base 10 devisor
	mov rsi, buffer + 21	; Move pointer to the position 21

	mov byte [rsi], 0	; Null-terminate string
	mov eax, eax		; Clear upper 4 bytes
	xor r8, r8		; Clear sign flag

	cmp eax, 00h		; Check for the negative value
	jge .loop_i2s		; Jump to loop if it is not a negative

	not eax
	inc eax
	mov r8, 1		; Set sign flag

.loop_i2s:
	xor rdx, rdx		; Clear RDX before division
	div r9			; RAX = quotient, RDX = remainder

	add dl, '0'		; Convert number to ASCII
	dec rsi			; Decrement pointer
	mov [rsi], dl		; Store a result to buffer

	cmp eax, 0		; Check if RAX is 0
	jne .loop_i2s		; Jump to loop if not
	cmp r8, 0		; Check for sign
	je .done_i2s		; Jump to ret if not negative

	dec rsi
	mov [rsi], '-'		; Add negative character at the front

.done_i2s:
	mov rax, rsi		; Return the pointer to RAX if RAX is 0
	mov rdx, buffer + 21
	sub rdx, rsi		; Calculate the length of the string
	ret
