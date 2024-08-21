format ELF64
entry _start

section '.data' writable
    prompt db 'Decimal no: ', 0
    prompt_len equ $ - prompt
    newline db 0x0A          ; \n hex
    newline_len equ $ - newline

section '.bss'
    num resb 10              ; I/P Buffer 10 Bits
    result resb 33           ; O/P Buffer 33 Bits(Null pani chha)

section '.text'
_start:
    ; write() supplement
    mov rax, 1              ; sys_write call
    mov rdi, 1              ; Linux fd for stdout is 1
    mov rsi, prompt         ; Message Pointer
    mov rdx, prompt_len     ; len of msg
    syscall

    ; read() supplement
    mov rax, 0              ; sys_read syscall
    mov rdi, 0
    mov rsi, num            ; Buffer pointer
    mov rdx, 10             ; no. of bytes to read
    syscall

    mov rdi, num
    call atoi               ; atoi(), i wish to create new lib for this
    mov rbx, rax

    mov rsi, result
    mov byte [rsi], 0       ; Very essential to null terminate

convert_to_binary:
    mov rax, rbx 
    and rax, 1 
    add al, '0'
    mov [rsi], al
    inc rsi
    shr rbx, 1
    test rbx, rbx
    jnz convert_to_binary

    mov rdi, result
    call reverse_string

    mov rax, 1
    mov rdi, 1
    mov rdx, rsi
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, newline_len
    syscall

    mov rax, 60             ; sys_exit
    xor rdi, rdi            ; exit code 0
    syscall

atoi:
        ; Look at atoi() docs for this, tired of writing shit
    xor rax, rax
    xor rcx, rcx
    mov cl, 10  
atoi_loop:
    movzx rdx, byte [rdi]
    sub rdx, '0'
    imul rax, rcx, rax
    add rax, rdx
    inc rdi
    test byte [rdi], 0
    jnz atoi_loop
    ret

reverse_string:
    mov rdx, rsi
    dec rdx
    mov rcx, rsi
reverse_loop:
    cmp rcx, rdx
    jge reverse_done
    mov al, [rcx]
    mov bl, [rdx]
    mov [rcx], bl
    mov [rdx], al
    inc rcx
    dec rdx
    jmp reverse_loop
reverse_done:
    ret
