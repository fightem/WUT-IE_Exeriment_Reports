DATAS SEGMENT
	string_5 DB ' ','$'
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
    
    ; ����CX��SI��ֵ
    PUSH CX
    PUSH SI

    ; �������������
    MOV CX, n               ; ��Ԫ�ظ�������CX
    MOV SI, 0               ; ����ѭ��������

output_loop:
    PUSH CX
    MOV AX, ary[SI]
    
    CALL WriteDec           ; ����޷�����
    MOV DL, ' '
    CALL SPACE          ; ����ո�
    POP CX
    INC SI
    CMP SI, n               ; ����Ƿ����������Ԫ��
    JB output_loop
    
    ; �ָ�CX��SI��ֵ
    POP SI
    POP CX

    CALL CRLF               ; ����

    ; �˳�����
    MOV AH, 4CH
    INT 21H

CRLF PROC Near
  push AX
  push DX
  MOV DL, 0ah
  MOV AH, 2
  INT 21H
  pop DX
  pop AX
  RET
  CRLF ENDP
  

SPACE PROC Near
  push AX
  push DX
  MOV DX, OFFSET string_5 ;' '
  MOV AH, 9
  INT 21H
  pop DX
  pop AX
  RET 
  SPACE ENDP
  
WriteDec PROC NEAR
  PUSH AX
  PUSH BX
  PUSH CX
  PUSH DX

  XOR BX, BX  ; ���ڴ洢����������
  MOV CX, 10  ; ����

  ; ��AX��ֵ���浽DX:BX�У����ڳ�������
  MOV DX, 0
  MOV BX, AX

  ; �ж��Ƿ�Ϊ0�����Ϊ0��ֱ�����'0'
  CMP AX, 0
  JNZ not_zero
  MOV DL, '0'
  MOV AH, 2
  INT 21H
  JMP end_proc

not_zero:
  ; ѭ��������������ÿһλ�����ִ洢��ջ��
  convert_loop:
    XOR DX, DX  ; ���DX��ֵ

    DIV CX  ; AX = BX / CX��DX = BX % CX���̱�����AX������������DX

    ADD DL, '0'  ; ������ת��Ϊ�ַ�

    ; ��ת������ַ����
    MOV AH, 2
    INT 21H

    ; �ж����Ƿ�Ϊ0�����Ϊ0������ѭ��
    CMP AX, 0
    JNZ convert_loop

  end_proc:
    POP DX
    POP CX
    POP BX
    POP AX
    RET
WriteDec ENDP

CODES ENDS
    END START

