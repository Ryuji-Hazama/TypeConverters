extern ascii_to_int	; Pull in the functions from type_converter.asm
extern int_to_ascii

section .date
	input_str db "456", 0Ah		; Test string

section .text
	global _start

_start:

	; Pass the string pointer in RSI
	mov rsi, input_str
	call ascii_to_int	; Returns result in RAX

	call int_to_ascii	; Convert integer to string

	; Print the result
	mov rax, 1		; System call 1 = sys_write
	mov rdi, 1		; File descriptor 1 = stdout
	syscall			; Pointer and length shoud be set in the function

	; Exit
	xor rdi, rdi		; Return code 0
	mov rax, 60		; sys_exit
	syscall
