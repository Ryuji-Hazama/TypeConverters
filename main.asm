extern ascii_to_int	; Pull in the function from type_converter.asm

section .date
	input_str db "456", 0Ah		; Test string

section .text
	global _start

_start:

	; Pass the string pointer in RSI
	mov rsi, input_str
	call ascii_to_int	; Returns result in RAX

	; Exit with converted integer
	mov rdi, rax		; Move converted integer
	mov rax, 60		; sys_exit
	syscall
