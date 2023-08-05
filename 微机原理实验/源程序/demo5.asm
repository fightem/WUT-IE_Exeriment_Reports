DATAS SEGMENT
    ary DW 5, 3, 9, 1, 7     ; ʾ����������
    n DW 5                   ; ʾ��Ԫ�ظ���
DATAS ENDS

STACKS SEGMENT
    ;�˴������ջ�δ���
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES, DS:DATAS, SS:STACKS
START:
    MOV AX, DATAS
    MOV DS, AX

    ;�˴��������δ���
    MOV CX, n               ; ��Ԫ�ظ�������CX
    MOV SI, 0               ; �ⲿѭ����������ʼ��Ϊ0

outer_loop:
    MOV DI, SI              ; �ڲ�ѭ����������ʼ��Ϊ�ⲿѭ��������

inner_loop:
    ADD DI, 2               ; DI = SI + 1
    MOV BX, SI              ; BX = �ⲿѭ��������
    MOV AX, ary[BX]         ; AX = �ⲿѭ��Ԫ��

    CMP AX, ary[DI]         ; �Ƚ�����ѭ��Ԫ�ش�С
    JNL next_inner_loop      ; ����ڲ�Ԫ�� >= �ⲿԪ�أ�����������

    ; ��������ѭ��Ԫ��
    MOV DX, ary[DI]
    MOV ary[DI], AX
    MOV ary[BX], DX

next_inner_loop:
    LOOP inner_loop         ; �����ڲ�ѭ��

    INC SI                  ; �����ⲿѭ��������
    CMP SI, n               ; ����Ƿ��������ѭ��
    JB outer_loop

    ; �������������
    MOV CX, n               ; ��Ԫ�ظ�������CX
    MOV SI, 0               ; ����ѭ��������

output_loop:
    PUSH CX
    MOV AX, ary[SI]
    CALL WriteDec           ; ����޷�����
    MOV DL, ' '
    CALL WriteChar          ; ����ո�
    POP CX
    INC SI
    CMP SI, n               ; ����Ƿ����������Ԫ��
    JB output_loop

    CALL Crlf               ; ����

    ; �˳�����
    MOV AH, 4CH
    INT 21H
CODES ENDS
    END START

