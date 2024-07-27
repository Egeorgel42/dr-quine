%assign X 5
%ifdef COMP
 %assign X X-1
%endif
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
	mov rdi, X
	cmp rdi, 0
	jl exit
	mov rdi, -1
	mov rbp, rsp
	sub rsp, len + 1
	call convert_string
end_loop:
	mov BYTE [rsp + rdi], 0x22
	inc rdi
	mov BYTE [rsp + rdi], 0
	mov BYTE [fileName + 6], X + 48
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
	mov rsi, assign_x
	mov BYTE [rsi + 10], X + 48
	mov rdx, assign_x_len
	syscall
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
	mov rax, 57
	syscall
	mov rbx, rax
	cmp rbx, 0
	jl exit
	je nasm_child
	jg nasm_parent
nasm_child:
	mov BYTE [nasm_params_4 + 6], X + 48
	mov rax, 59
	mov rdi, nasm_params_0
	mov rsi, nasm
	mov rdx, 0
	syscall
	jmp exit
nasm_parent:
	mov rax, 61
	mov rdi, rbx
	mov rsi, 0
	mov rdx, 0
	mov rcx, 0
	syscall
	mov rax, 57
	syscall
	mov rbx, rax
	cmp rbx, 0
	jl exit
	je ld_child
	jg ld_parent
ld_child:
	mov BYTE [ld_params_2 + 6], X + 48
	mov BYTE [ld_params_3 + 6], X + 48
	mov rax, 59
	mov rdi, ld_params_0
	mov rsi, ld_
	mov rdx, 0
	syscall
	jmp exit
ld_parent:
	mov rax, 61
	mov rdi, rbx
	mov rsi, 0
	mov rdx, 0
	mov rcx, 0
	syscall
	mov rax, 57
	syscall
	mov rbx, rax
	cmp rbx, 0
	jl exit
	je exec_child
	jg exec_parent
exec_child:
	mov BYTE [exec + 8], X + 48
	mov rax, 59
	mov rdi, exec
	mov rsi, exec_call
	mov rdx, 0
	syscall
	jmp exit
exec_parent:
	mov rax, 61
	mov rdi, rbx
	mov rsi, 0
	mov rdx, 0
	mov rcx, 0
	syscall
	mov rax, 57
	syscall
	mov rbx, rax
	cmp rbx, 0
	jl exit
	je rm_child
	jg rm_parent
rm_child:
	mov BYTE [rm_params_1 + 6], X + 48
	mov rax, 59
	mov rdi, rm_params_0
	mov rsi, rm
	mov rdx, 0
	syscall
	jmp exit
rm_parent:
	mov rax, 61
	mov rdi, rbx
	mov rsi, 0
	mov rdx, 0
	mov rcx, 0
	syscall
exit:
	mov rax, 60
	mov rdi, 0
	syscall
;end_len = len equ $ - string in hex to avoid quotes
section .data
	nasm_params_0 db 0x2f, 0x62, 0x69, 0x6e, 0x2f, 0x6e, 0x61, 0x73, 0x6d, 0x0
	nasm_params_1 db 0x2d, 0x66, 0x0
	nasm_params_2 db 0x65, 0x6c, 0x66, 0x36, 0x34, 0x0
	nasm_params_3 db 0x2d, 0x64, 0x43, 0x4f, 0x4d, 0x50, 0x3d, 0x31, 0x0
	nasm_params_4 db 0x53, 0x75, 0x6c, 0x6c, 0x79, 0x5f, 0x58, 0x2e, 0x73, 0x0
	nasm dq nasm_params_0, nasm_params_1, nasm_params_2, nasm_params_3, nasm_params_4, 0x0
	ld_params_0 db 0x2f, 0x62, 0x69, 0x6e, 0x2f, 0x6c, 0x64, 0x0
	ld_params_1 db 0x2d, 0x6f, 0x0
	ld_params_2 db 0x53, 0x75, 0x6c, 0x6c, 0x79, 0x5f, 0x58, 0x0
	ld_params_3 db 0x53, 0x75, 0x6c, 0x6c, 0x79, 0x5f, 0x58, 0x2e, 0x6f, 0x0
	ld_ dq ld_params_0, ld_params_1, ld_params_2, ld_params_3, 0x0
	rm_params_0 db 0x2f, 0x62, 0x69, 0x6e, 0x2f, 0x72, 0x6d, 0x0
	rm_params_1 db 0x53, 0x75, 0x6c, 0x6c, 0x79, 0x5f, 0x58, 0x2e, 0x6f, 0x0
	rm dq rm_params_0, rm_params_1, 0x0
	assign_x db 0x25, 0x61, 0x73, 0x73, 0x69, 0x67, 0x6e, 0x20, 0x58, 0x20, 0x0, 0xA
	assign_x_len equ $ - assign_x
	fileName db 0x53, 0x75, 0x6c, 0x6c, 0x79, 0x5f, 0x58, 0x2e, 0x73, 0x0
	exec db 0x2e, 0x2f, 0x53, 0x75, 0x6c, 0x6c, 0x79, 0x5f, 0x58, 0x0
	exec_call dq exec, 0x0
	quotes db 0x22, 0xA
	end_len db 0x9, 0x6c, 0x65, 0x6e, 0x20, 0x65, 0x71, 0x75, 0x20, 0x24, 0x20 , 0x2d, 0x20, 0x73, 0x74, 0x72, 0x69, 0x6e, 0x67
	end_len_len equ $ - end_len
	string db "%ifdef COMP~ %assign X X-1~%endif~%define BOOT \~call exec_start~%define write 1~%define open 2~section .text~	global _start~_start:BOOT~convert_string:~loop:~	inc rdi~	mov al, [string + rdi]~	cmp al, 0~	je end_loop~	cmp al, 0x7E~	jne loop_back~	mov al, 0xA~	jmp loop_back~loop_back:~	mov [rsp + rdi], al~	jmp loop~	ret~exec_start:~	mov rdi, X~	cmp rdi, 0~	jl exit~	mov rdi, -1~	mov rbp, rsp~	sub rsp, len + 1~	call convert_string~end_loop:~	mov BYTE [rsp + rdi], 0x22~	inc rdi~	mov BYTE [rsp + rdi], 0~	mov BYTE [fileName + 6], X + 48~	mov rax, open~	mov rdi, fileName~	mov rsi, 1101o~	mov rdx, 666o~	syscall~	cmp rax, 0~	jl exit~	mov rbx, rax~	mov rax, write~	mov rdi, rbx~	mov rsi, assign_x~	mov BYTE [rsi + 10], X + 48~	mov rdx, assign_x_len~	syscall~	mov rax, write~	mov rdi, rbx~	mov rsi, rsp~	mov rdx, len + 1~	syscall~	mov rax, write~	mov rdi, rbx~	mov rsi, string~	mov rdx, len~	syscall~	mov rax, write~	mov rdi, rbx~	mov rsi, quotes~	mov rdx, 2~	syscall~	mov rax, write~	mov rdi, rbx~	mov rsi, end_len~	mov rdx, end_len_len~	syscall~	mov rax, 3~	mov rdi, rbx~	syscall~	mov rax, 57~	syscall~	mov rbx, rax~	cmp rbx, 0~	jl exit~	je nasm_child~	jg nasm_parent~nasm_child:~	mov BYTE [nasm_params_4 + 6], X + 48~	mov rax, 59~	mov rdi, nasm_params_0~	mov rsi, nasm~	mov rdx, 0~	syscall~	jmp exit~nasm_parent:~	mov rax, 61~	mov rdi, rbx~	mov rsi, 0~	mov rdx, 0~	mov rcx, 0~	syscall~	mov rax, 57~	syscall~	mov rbx, rax~	cmp rbx, 0~	jl exit~	je ld_child~	jg ld_parent~ld_child:~	mov BYTE [ld_params_2 + 6], X + 48~	mov BYTE [ld_params_3 + 6], X + 48~	mov rax, 59~	mov rdi, ld_params_0~	mov rsi, ld_~	mov rdx, 0~	syscall~	jmp exit~ld_parent:~	mov rax, 61~	mov rdi, rbx~	mov rsi, 0~	mov rdx, 0~	mov rcx, 0~	syscall~	mov rax, 57~	syscall~	mov rbx, rax~	cmp rbx, 0~	jl exit~	je exec_child~	jg exec_parent~exec_child:~	mov BYTE [exec + 8], X + 48~	mov rax, 59~	mov rdi, exec~	mov rsi, exec_call~	mov rdx, 0~	syscall~	jmp exit~exec_parent:~	mov rax, 61~	mov rdi, rbx~	mov rsi, 0~	mov rdx, 0~	mov rcx, 0~	syscall~	mov rax, 57~	syscall~	mov rbx, rax~	cmp rbx, 0~	jl exit~	je rm_child~	jg rm_parent~rm_child:~	mov BYTE [rm_params_1 + 6], X + 48~	mov rax, 59~	mov rdi, rm_params_0~	mov rsi, rm~	mov rdx, 0~	syscall~	jmp exit~rm_parent:~	mov rax, 61~	mov rdi, rbx~	mov rsi, 0~	mov rdx, 0~	mov rcx, 0~	syscall~exit:~	mov rax, 60~	mov rdi, 0~	syscall~;end_len = len equ $ - string in hex to avoid quotes~section .data~	nasm_params_0 db 0x2f, 0x62, 0x69, 0x6e, 0x2f, 0x6e, 0x61, 0x73, 0x6d, 0x0~	nasm_params_1 db 0x2d, 0x66, 0x0~	nasm_params_2 db 0x65, 0x6c, 0x66, 0x36, 0x34, 0x0~	nasm_params_3 db 0x2d, 0x64, 0x43, 0x4f, 0x4d, 0x50, 0x3d, 0x31, 0x0~	nasm_params_4 db 0x53, 0x75, 0x6c, 0x6c, 0x79, 0x5f, 0x58, 0x2e, 0x73, 0x0~	nasm dq nasm_params_0, nasm_params_1, nasm_params_2, nasm_params_3, nasm_params_4, 0x0~	ld_params_0 db 0x2f, 0x62, 0x69, 0x6e, 0x2f, 0x6c, 0x64, 0x0~	ld_params_1 db 0x2d, 0x6f, 0x0~	ld_params_2 db 0x53, 0x75, 0x6c, 0x6c, 0x79, 0x5f, 0x58, 0x0~	ld_params_3 db 0x53, 0x75, 0x6c, 0x6c, 0x79, 0x5f, 0x58, 0x2e, 0x6f, 0x0~	ld_ dq ld_params_0, ld_params_1, ld_params_2, ld_params_3, 0x0~	rm_params_0 db 0x2f, 0x62, 0x69, 0x6e, 0x2f, 0x72, 0x6d, 0x0~	rm_params_1 db 0x53, 0x75, 0x6c, 0x6c, 0x79, 0x5f, 0x58, 0x2e, 0x6f, 0x0~	rm dq rm_params_0, rm_params_1, 0x0~	assign_x db 0x25, 0x61, 0x73, 0x73, 0x69, 0x67, 0x6e, 0x20, 0x58, 0x20, 0x0, 0xA~	assign_x_len equ $ - assign_x~	fileName db 0x53, 0x75, 0x6c, 0x6c, 0x79, 0x5f, 0x58, 0x2e, 0x73, 0x0~	exec db 0x2e, 0x2f, 0x53, 0x75, 0x6c, 0x6c, 0x79, 0x5f, 0x58, 0x0~	exec_call dq exec, 0x0~	quotes db 0x22, 0xA~	end_len db 0x9, 0x6c, 0x65, 0x6e, 0x20, 0x65, 0x71, 0x75, 0x20, 0x24, 0x20 , 0x2d, 0x20, 0x73, 0x74, 0x72, 0x69, 0x6e, 0x67~	end_len_len equ $ - end_len~	string db "
	len equ $ - string