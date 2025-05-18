[ORG 0x1000]

start:
    CALL clear_screen

main_loop:
    MOV SI, prompt
    CALL print_string

read_keypress:
    MOV AH, 0x00
    INT 0x16

    CMP AL, 13
    JE new_line

    MOV AH, 0x0E
    INT 0x10

    JMP read_keypress

new_line:
    MOV AL, 0x0D
    MOV AH, 0x0E
    INT 0x10

    MOV AL, 0x0A
    MOV AH, 0x0E
    INT 0x10

    JMP main_loop

print_string:
    LODSB
    OR AL, AL
    JZ .done
    MOV AH, 0x0E
    INT 0x10
    JMP print_string
.done:
    RET

clear_screen:
    MOV AH, 0x06
    MOV AL, 0
    MOV BH, 0x07
    MOV CX, 0x0000
    MOV DX, 0x184F
    INT 0x10
    RET

prompt db "user@os: ", 0
