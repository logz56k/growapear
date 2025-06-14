bits 16
org 0x7c00

start:
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7c00

    mov si, ascii_art
.print_loop:
    lodsb
    cmp al, 0
    je done
    mov ah, 0x0E
    mov bh, 0x00
    mov bl, 0x0D
    int 0x10
    jmp .print_loop

done:
    call play_music
    jmp $

ascii_art:
    db 0x0D,0x0A
    db '  ____ _               _   __  __',0x0D,0x0A
    db ' / ___| |__   __ _  __| | |  \\/  | ___ ',0x0D,0x0A
    db '| |   | `_ \\ / _` |/ _` | | |\\/| |/ _ \\',0x0D,0x0A
    db '| |___| | | | (_| | (_| | | |  | |  __/',0x0D,0x0A
    db ' \\____|_| |_|\\__,_|\\__,_| |_|  |_|\\___|',0x0D,0x0A
    db '        charli xcx 4eva',0x0D,0x0A
    db '      Kesha vibes only',0x0D,0x0A,0

; Simple PC speaker music approximating "Grow a Pear"
play_music:
    mov si, notes
.next:
    lodsw           ; get divisor
    cmp ax, 0
    je .done
    mov bx, ax
    lodsw           ; get duration
    mov cx, ax
    call play_note
    jmp .next
.done:
    ret

; BX = PIT divisor, CX = duration loops
play_note:
    push ax
    push bx
    push cx
    push dx

    mov ax, 0xB6
    out 0x43, al
    mov al, bl
    out 0x42, al
    mov al, bh
    out 0x42, al
    in al, 0x61
    or al, 3
    out 0x61, al

.delay_outer:
    mov dx, 0xFFFF
.delay_inner:
    dec dx
    jnz .delay_inner
    loop .delay_outer

    in al, 0x61
    and al, 0xFC
    out 0x61, al

    pop dx
    pop cx
    pop bx
    pop ax
    ret

notes:
    dw 2281, 10
    dw 3043, 10
    dw 2711, 10
    dw 3418, 10
    dw 0,0

times 510-($-$$) db 0
dw 0xAA55
