DATA   SEGMENT
 X     DB 2
 Y     DB -8
 A     DB ?
DATA   ENDS
CODE  SEGMENT
      ASSUME CS:CODE,DS:DATA
START: MOV  AX,DATA                     
      MOV  DS,AX
      CMP  X,0     ;x��0���бȽ�
      JS   L1      ;x<0תL1
      CMP  Y,0    
      JL   L2      ;y<0תL2
      MOV  A,1     ;1��A
      JMP EXIT
L1:   CMP  Y,0
      JGE  L2      ;y>=0תL2
      MOV  A,-1   
      JMP EXIT
L2:   MOV  A,0     ;x��y���ʱ��0��A         
EXIT: mov dl,A
      add dl,30h
      mov ah,02h   
      int 21h      ;�ַ���ʾ
      MOV AH,4CH
      INT 21H        
CODE  ENDS
END START

