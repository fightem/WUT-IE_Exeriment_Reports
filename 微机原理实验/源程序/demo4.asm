S0  SEGMENT STACK
    DW  20 DUP(?)
TOP LABEL   WORD
S0  ENDS

S1  SEGMENT
TIP DB  "Input ten number and separate the numbers with space:", 0DH, 0AH, 24H
ARY DW  20 DUP(0)
CRLF DB  0DH, 0AH, 24H
N   DW  0
S1  ENDS

S2  SEGMENT
    ASSUME  SS:S0, DS:S1, CS:S2, ES:S1
P   PROC    FAR
    MOV AX, S0
    MOV SS, AX
    LEA SP, TOP

    MOV AX, S1
    MOV DS, AX

    MOV AX, S1
    MOV ES, AX

    LEA DX, TIP
    MOV AH, 9
    INT 21H

    LEA SI, ARY

    XOR DX, DX
    MOV BL, 10
    MOV CX, 10

INPUT:  MOV AH, 1
    INT 21H
    CMP AL, 20H ;�ո�ָ��ַ�
    JE  SAVE
    ;����ʮ����������������SI��Ӧ���ڴ浥Ԫ
    MOV DL, AL 
    MOV AX, [SI]
    MUL BL
    SUB DL, 30H
    ADD AL, DL
    MOV [SI], AX
    JMP INPUT
SAVE:   
    ADD SI, 2 
    LOOP    INPUT
    ;���鱣�����

    LEA SI, ARY

    MOV DI, SI
    ADD DI, 2 ;DIλ������ĵڶ�Ԫ�ص�λ��

    MOV BP, 9 ;SI�ƶ��Ĵ�����ÿһ�αȽϵĴ�������һ��Ϊ9

GO: MOV CX, BP ;ÿһ�αȽϵ�ѭ������
    MOV BX, [SI] ;��һ����
CMPA:   CMP BX, [DI] ;�ȽϺ�������Ƿ�ȵ�ǰ��С
    JBE CON ;���ھͱȽ���һ��
    MOV BX, [DI] ;���Ĵ����е�ֵ�滻Ϊ��С��ֵ
    MOV AX, DI ;AX�����Сֵ��ƫ�Ƶ�ַ
CON:    ADD DI, 2
    LOOP    CMPA

    CMP AX, 0 ;���AXΪ0�����ʾ�����ֵû�бȵ�ǰֵС
    JE  NO ;��ʱSI��һ���ƶ����ڶ�����  ��һ��ѭ���ȽϿ�ʼ
CHANGE: MOV DX, [SI] ;78-83���滻��ǰֵ����Сֵ
    PUSH    DX
    MOV [SI], BX
    POP DX
    MOV DI, AX
    MOV [DI], DX
NO: ADD SI, 2
    MOV DI, SI
    ADD DI, 2
    CALL    PRINT
    DEC BP ;ѭ���Ĵ�����һ
    XOR AX, AX ;���AX�����ݣ��Ա�76���ж�
    CMP BP, 1
    JNE GO

EXIT:   MOV AH, 4CH
    INT 21H

P   ENDP

PRINT   PROC    NEAR
    PUSH    SI
    PUSH    CX
    PUSH    AX
    PUSH    DX
    LEA DX, CRLF
    MOV AH, 9
    INT 21H

    LEA SI, ARY
    MOV CX, 10
L1: MOV AX, [SI]
    MOV N, AX
    CALL    OUTPUT
    ADD SI, 2
    MOV DX, 20H
    MOV AH, 2
    INT 21H
    LOOP    L1
    POP DX
    POP AX
    POP CX
    POP SI
    RET

PRINT   ENDP

OUTPUT  PROC    NEAR
    PUSH    AX
    PUSH    BX
    PUSH    CX
    PUSH    DX

    XOR CX, CX 
    MOV AX, N
    MOV BX, 10
L2: XOR DX, DX
    DIV BX
    PUSH    DX
    INC CX
    CMP AX, 0
    JNE L2

L3: POP DX
    ADD DX, 30H
    MOV AH, 2
    INT 21H
    LOOP    L3

    POP DX
    POP CX
    POP BX
    POP AX
    RET
OUTPUT  ENDP

S2  ENDS
    END P
