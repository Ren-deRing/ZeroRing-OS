print_string:
    mov ah, 0x0E
.loop:
    lodsb
    cmp al, 0
    je .done
    int 0x10
    jmp .loop
.done:
    ret

print_char:
    push ax
    mov ah, 0x0e
    int 0x10
    pop ax
    ret

; 줄바꿈 처리 / 스크롤 확인
print_newline:
    ; 행++
    inc byte [current_row]

    ; 행 > 25?
    cmp byte [current_row], 25
    jne .no_scroll              ; 스크롤 필요 X

    call scroll_screen

    ; 행--
    dec byte [current_row]

.no_scroll:
    mov ah, 0x02
    mov bh, 0
    mov dh, [current_row] 
    mov dl, 0
    int 0x10
    ret

scroll_screen:
    mov ah, 0x06                ; 스크롤 업
    mov al, 1                   ; 한 줄 스크롤
    mov bh, 0x07                ; 속성
    mov ch, 0                   ; 시작 행 0
    mov cl, 0                   ; 시작 열 0
    mov dh, 24                  ; 끝 행 24
    mov dl, 79                  ; 끝 열 79
    int 0x10
    ret

clear_screen:
    mov ah, 0x02
    mov bh, 0
    mov dh, 0
    mov dl, 0
    int 0x10
    mov [current_row], byte 0

    mov ah, 0x06
    mov al, 0                   ; AL=0 영역 전체
    mov bh, 0x07                ; 속성
    mov ch, 0
    mov cl, 0
    mov dh, 24
    mov dl, 79
    int 0x10
    ret