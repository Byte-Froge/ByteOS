[BITS 16]
[ORG 0x0000]

start:
    ; segmenty
    mov ax, cs
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    ; czyszczenie ekranu
    mov ax, 0x0600
    mov bh, 0x07
    mov cx, 0x0000
    mov dx, 0x184F
    int 0x10

    ; kursor (0,0)
    mov ah, 0x02
    mov bh, 0
    mov dh, 0
    mov dl, 0
    int 0x10

    ; tytuł
    mov si, title
    call print_string

    ; nowa linia
    mov al, 13
    call putchar
    mov al, 10
    call putchar

    mov si, prompt
    call print_string

keyboard_loop:
    ; sprawdź status
    in al, 0x64
    test al, 1
    jz keyboard_loop

    ; scancode
    in al, 0x60

    ; ignoruj puszczenie
    test al, 0x80
    jnz keyboard_loop

    ; mapowanie
    mov bx, keymap
    xor ah, ah
    xlat

    test al, al
    jz keyboard_loop

    call putchar
    jmp keyboard_loop

putchar:
    mov ah, 0x0E
    mov bh, 0
    mov bl, 0x0F
    int 0x10
    ret

print_string:
.next:
    lodsb
    test al, al
    jz .done
    call putchar
    jmp .next
.done:
    ret

title  db "ByteOS",0
prompt db "> ",0

keymap:
    db 0
    db 27
    db '1','2','3','4','5','6','7','8','9','0','-','='
    db 8
    db 9
    db 'q','w','e','r','t','y','u','i','o','p','[',']'
    db 13
    db 0
    db 'a','s','d','f','g','h','j','k','l',';','''
    db '`'
    db 0
    db '\'
    db 'z','x','c','v','b','n','m',',','.','/'
    times 128-($-keymap) db 0

; padding do 512 bajtów
times 512-($-$$) db 0
