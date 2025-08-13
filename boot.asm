[bits 16]
[org 0x7C00]

start:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    mov si, hello
    call print
    call newline

    mov si, next
    call print
    call newline

    mov ah, 0x00
    int 0x16
    call newline

    mov [BOOT_DRIVE], dl

    mov ax, 0x0800
    mov es, ax
    mov bx, 0x0000      ; ES:BX = 0x0800:0x0000 (물리 주소 0x8000)

    mov ah, 0x02        ; 섹터 읽기
    mov al, 4           ; 1개의 섹터
    mov ch, 0           ; 실린더 0
    mov cl, 2           ; 섹터 2
    mov dh, 0           ; 헤드 0
    mov dl, [BOOT_DRIVE]

    int 0x13

    jc disk_error

    jmp 0x0800:0x0000

    jmp $

disk_error:
    mov si, error_message
    call print
    jmp $

%include "print.asm"

hello db 'Welcome to ZeroRing-OS!', 0
next db 'Press any key to boot...', 0
error_message db 'Disk read error!', 0

BOOT_DRIVE db 0

times 510-($-$$) db 0
dw 0xAA55  