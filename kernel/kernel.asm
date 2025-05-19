[ORG 0x1000]

start:
    CALL clear_screen

main_loop:
    MOV SI, prompt
    CALL print_string
    
    MOV DI, input_buffer
    CALL read_input

; ===== Functions =====
read_input:
    XOR CX, CX

.read_input_loop:
    MOV AH, 0x00
    INT 0x16

    CMP AL, 13
    JE .done

    CMP Al, 8
    JE .backspace

    STOSB
    INC CX

    MOV AH, 0x0E
    INT 0x10
    JMP .read_input_loop

.backspace:
    CMP CX, 0
    JE .read_input_loop

    DEC DI
    DEC CX

    MOV AL, 8
    MOV AH, 0x0E
    INT 0x10

    MOV AL, ' '
    INT 0x10

    MOV AL, 8
    INT 0x10

    JMP .read_input_loop
.done:
    MOV AL, 0
    STOSB
    CALL new_line
    RET

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

; ===== Variables =====
prompt      db "user@os: ", 0
help_cmd    db "help", 0
clear_cmd   db "clear", 0
help_msg    db "Commands: help, clear", 0
unknown_cmd db "Invalid command", 0

input_buffer TIMES 128 db 0

