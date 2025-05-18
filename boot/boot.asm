[ORG 0x7C00]

start:
    XOR AX, AX
    MOV DS, AX
    MOV ES, AX

    MOV AH, 0x02
    MOV AL, 1
    MOV CH, 0
    MOV CL, 2
    MOV DH, 0
    MOV DL, 0x00
    MOV BX, 0x0000
    MOV ES, BX
    MOV BX, 0x1000

    INT 0x13
    JC disk_error

    JMP 0x0000:0x1000

disk_error:
    MOV SI, error_msg

.print:
    LODSB
    OR AL, AL
    JZ .hang
    MOV AH, 0x0E
    INT 0x10
    JMP .print

.hang:
    CLI
    HLT

error_msg db "Disk read error!", 0

TIMES 510 - ($ - $$) db 0
DW 0xAA55

