[ORG 0x1000]

start:
    MOV SI, msg 
.print:
    LODSB
    OR AL, AL
    JZ .done
    MOV ah, 0x0E
    INT 0x10
    JMP .print

.done:
    CLI
    HLT

msg db "Hello from the Kernel", 0
