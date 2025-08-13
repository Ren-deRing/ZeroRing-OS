[ORG 0x8000]

start:
    mov [current_row], byte 0
    call clear_screen

    mov si, booted
    call print_string
    call print_newline

print_lines_loop:
    mov ah, 0x00
    int 0x16

    call print_char
    call print_newline          ; 줄바꿈
    
    loop print_lines_loop

    jmp $

%include "printk.asm"

booted db 'OS HAS BEEN BOOTED!', 0

current_row db 0
line_msg    db 'This is a line of text to test scrolling.', 0

times 4096-($-$$) db 0