print:
    push ax
    push si
    mov ah, 0x0e

.loop:
    lodsb
    test al, al
    jz .done
    int 0x10
    jmp .loop

.done:
    pop si
    pop ax
    ret

newline:
    push ax
    mov ah, 0x0e

    mov al, 0x0D
    int 0x10
    mov al, 0x0A
    int 0x10

    pop ax

    ret