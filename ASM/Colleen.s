section .text
	global _start
convert_string:
loop:
	inc rdi
	mov al, [string + rdi]
	cmp al, 0
	je end_loop
	cmp al, 0x7E
	jne loop_back
	mov al, 0xA
	jmp loop_back
loop_back:
	mov [rsp + rdi], al
	jmp loop
	ret
_start:
	mov rdi, -1
	mov rbp, rsp
	sub rsp, len + 1
	call convert_string
end_loop:
	mov BYTE [rsp + rdi], 0x22; quotes
	inc rdi
	mov BYTE [rsp + rdi], 0
	mov rax, 1
	mov rdi, 1
	mov rsi, rsp
	mov rdx, len + 1
	syscall
	mov rax, 1
	mov rdi, 1
	mov rsi, string
	mov rdx, len
	syscall
	mov rax, 1
	mov rdi, 1
	mov rsi, quotes
	mov rdx, 2
	syscall
	mov rax, 1
	mov rdi, 1
	mov rsi, end_len
	mov rdx, end_len_len
	syscall
	mov rax, 60
	mov rdi, 0
	syscall
;end_len = len equ $ - string in hex to avoid quotes
section .data
	quotes db 0x22, 0xA
	end_len db 0x9, 0x6c, 0x65, 0x6e, 0x20, 0x65, 0x71, 0x75, 0x20, 0x24, 0x20 , 0x2d, 0x20, 0x73, 0x74, 0x72, 0x69, 0x6e, 0x67
	end_len_len equ $ - end_len
	string db "section .text~	global _start~convert_string:~loop:~	inc rdi~	mov al, [string + rdi]~	cmp al, 0~	je end_loop~	cmp al, 0x7E~	jne loop_back~	mov al, 0xA~	jmp loop_back~loop_back:~	mov [rsp + rdi], al~	jmp loop~	ret~_start:~	mov rdi, -1~	mov rbp, rsp~	sub rsp, len + 1~	call convert_string~end_loop:~	mov BYTE [rsp + rdi], 0x22; quotes~	inc rdi~	mov BYTE [rsp + rdi], 0~	mov rax, 1~	mov rdi, 1~	mov rsi, rsp~	mov rdx, len + 1~	syscall~	mov rax, 1~	mov rdi, 1~	mov rsi, string~	mov rdx, len~	syscall~	mov rax, 1~	mov rdi, 1~	mov rsi, quotes~	mov rdx, 2~	syscall~	mov rax, 1~	mov rdi, 1~	mov rsi, end_len~	mov rdx, end_len_len~	syscall~	mov rax, 60~	mov rdi, 0~	syscall~;end_len = len equ $ - string in hex to avoid quotes~section .data~	quotes db 0x22, 0xA~	end_len db 0x9, 0x6c, 0x65, 0x6e, 0x20, 0x65, 0x71, 0x75, 0x20, 0x24, 0x20 , 0x2d, 0x20, 0x73, 0x74, 0x72, 0x69, 0x6e, 0x67~	end_len_len equ $ - end_len~	string db "
	len equ $ - string