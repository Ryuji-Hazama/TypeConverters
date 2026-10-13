DEFAULT REL

	; - - - - - - - - - - - - - - - - - - - - ;
	; Test script for int<->string conversion ;
	; - - - - - - - - - - - - - - - - - - - - ;

extern ascii_to_int	; Pull functions
extern int_to_ascii
extern std_in
extern std_out

section .bss
	buffer resb 64		; Reserve 64 bytes for input string
	calc_result resd 1	; Reserve 1 doubleword (4 bytes) for result

section .date
	input_msg db "Input your number: ", 0		; Input message
	input_msg_len equ $ - input_msg
	output_msg db "Doubled your number is: ", 0	; Output message
	output_msg_len equ $ - output_msg

section .text
	global _start

_start:

	; Pass the string pointer in RSI
	mov rsi, input_msg
	mov rdx, input_msg_len
	call std_out		; Output input request string

	mov rsi, buffer		; Memory address to store the input
	call std_in		; Receive input

	mov rsi, buffer		; Set pointer to buffer
	call ascii_to_int	; Returns result in RAX
	
	add rax, rax		; Double the input
	mov [calc_result], rax	; Save result to memory

	mov rsi, output_msg	; Output message pointer
	mov rdx, output_msg_len
	call std_out

	mov rax, [calc_result]	; Move back the calculated result to RAX
	call int_to_ascii	; Convert integer to string
	call std_out		; Print the result

	; Exit
	xor rdi, rdi		; Return code 0
	mov rax, 60		; sys_exit
	syscall
