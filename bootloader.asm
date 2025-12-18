[BITS 16]
[ORG 0x7C00]

start:
    mov [boot_drive], dl

    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7000

    mov si, boot_msg
.print:
    lodsb
    test al, al
    jz load_kernel
    mov ah, 0x0E
    mov bh, 0
    mov bl, 0x0F
    int 0x10
    jmp .print

load_kernel:
    mov ax, 0x1000
    mov es, ax
    xor bx, bx

    mov ah, 0x02       
    mov al, 1          
    mov ch, 0
    mov cl, 2
    mov dh, 0
    mov dl, [boot_drive]
    int 0x13
    jc disk_error

    jmp 0x1000:0x0000

disk_error:
    mov si, err_msg
.err:
    lodsb
    test al, al
    jz $
    mov ah, 0x0E
    mov bl, 0x0C
    int 0x10
    jmp .err

boot_drive db 0
boot_msg db "ByteOS booting...",13,10,0
err_msg  db "Disk error!",0

times 510-($-$$) db 0
dw 0xAA55
