%define BOOT \
call exec_start
%define write 1
%define open 2
section .text
	global _start
_start:BOOT
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
exec_start:
	mov rdi, -1
	mov rbp, rsp
	sub rsp, len + 1
	call convert_string
end_loop:
	mov BYTE [rsp + rdi], 0x22
	inc rdi
	mov BYTE [rsp + rdi], 0
	mov rax, open
	mov rdi, fileName
	mov rsi, 1101o
	mov rdx, 666o
	syscall
	cmp rax, 0
	jl exit
	mov rbx, rax
	mov rax, write
	mov rdi, rbx
	mov rsi, rsp
	mov rdx, len + 1
	syscall
	mov rax, write
	mov rdi, rbx
	mov rsi, string
	mov rdx, len
	syscall
	mov rax, write
	mov rdi, rbx
	mov rsi, quotes
	mov rdx, 2
	syscall
	mov rax, write
	mov rdi, rbx
	mov rsi, end_len
	mov rdx, end_len_len
	syscall
	mov rax, 3
	mov rdi, rbx
	syscall
exit:
	mov rax, 60
	mov rdi, 0
	syscall
;end_len = len equ $ - string in hex to avoid quotes
section .data
	fileName db 0x47, 0x72, 0x61, 0x63, 0x65, 0x5f, 0x6b, 0x69, 0x64, 0x2e, 0x73, 0x0
	quotes db 0x22, 0xA
	end_len db 0x9, 0x6c, 0x65, 0x6e, 0x20, 0x65, 0x71, 0x75, 0x20, 0x24, 0x20 , 0x2d, 0x20, 0x73, 0x74, 0x72, 0x69, 0x6e, 0x67
	end_len_len equ $ - end_len
	string db "%define BOOT \~call exec_start~%define write 1~%define open 2~section .text~	global _start~_start:BOOT~convert_string:~loop:~	inc rdi~	mov al, [string + rdi]~	cmp al, 0~	je end_loop~	cmp al, 0x7E~	jne loop_back~	mov al, 0xA~	jmp loop_back~loop_back:~	mov [rsp + rdi], al~	jmp loop~	ret~exec_start:~	mov rdi, -1~	mov rbp, rsp~	sub rsp, len + 1~	call convert_string~end_loop:~	mov BYTE [rsp + rdi], 0x22~	inc rdi~	mov BYTE [rsp + rdi], 0~	mov rax, open~	mov rdi, fileName~	mov rsi, 1101o~	mov rdx, 666o~	syscall~	cmp rax, 0~	jl exit~	mov rbx, rax~	mov rax, write~	mov rdi, rbx~	mov rsi, rsp~	mov rdx, len + 1~	syscall~	mov rax, write~	mov rdi, rbx~	mov rsi, string~	mov rdx, len~	syscall~	mov rax, write~	mov rdi, rbx~	mov rsi, quotes~	mov rdx, 2~	syscall~	mov rax, write~	mov rdi, rbx~	mov rsi, end_len~	mov rdx, end_len_len~	syscall~	mov rax, 3~	mov rdi, rbx~	syscall~exit:~	mov rax, 60~	mov rdi, 0~	syscall~;end_len = len equ $ - string in hex to avoid quotes~section .data~	fileName db 0x47, 0x72, 0x61, 0x63, 0x65, 0x5f, 0x6b, 0x69, 0x64, 0x2e, 0x73, 0x0~	quotes db 0x22, 0xA~	end_len db 0x9, 0x6c, 0x65, 0x6e, 0x20, 0x65, 0x71, 0x75, 0x20, 0x24, 0x20 , 0x2d, 0x20, 0x73, 0x74, 0x72, 0x69, 0x6e, 0x67~	end_len_len equ $ - end_len~	string db "
	len equ $ - string