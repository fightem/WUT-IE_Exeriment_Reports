#include <reg51.h>
typedef unsigned char uint8;
typedef unsigned int uint16;

unsigned char buf;

sbit ADDR0=P1^0;	//λ��ַ����
sbit ADDR1=P1^1;
sbit ADDR2=P1^2;
sbit ADDR3=P1^3;
sbit ENLED=P1^4;
 
uint8 Buf[]="hello hushan\n";

void delay(uint16 n)
{
	while (n--);
}
 
//�����жϷ�����
void serial() interrupt 4
	{
	ES=0;		//��ʱ�رմ����ж�
	RI=0;
	buf=SBUF;	//���յ�����Ϣ��SBUF�ŵ�buf�С�
	switch(buf)
	{
	case 0x31: P0=0xfe;break;   //������ 0011 0001  ʮ���� 49 �����ַ� 1  16���� 0X31
	case 0x32: P0=0xfd;break;	 //1111 1101
	case 0x33: P0=0xfb;break;
	case 0x34: P0=0xf7;break;
	case 0x35: P0=0xef;break;   
	case 0x36: P0=0xdf;break;	
	case 0x37: P0=0xbf;break;
	case 0x38: P0=0x7f;break;
	}
	ES=1;		//���¿��������ж�
 
}

/*������Ϊ9600*/
void UART_init(void)
{
    SCON = 0x50;        //���ڷ�ʽ1
 
    TMOD = 0x20;        // ��ʱ��ʹ�÷�ʽ2�Զ�����
    TH1 = 0xFD;         //9600�����ʶ�Ӧ��Ԥ��������ʱ����ʽ2�£�TH1=TL1
    TL1 = 0xFD;
 
    TR1 = 1;						//������ʱ������ʼ����������
}
 
/*����һ���ַ�*/
void UART_send_byte(uint8 dat){
	SBUF = dat;       		//�����ݷŵ�SBUF��
	while (TI == 0);			//δ������Ͼ͵ȴ�
		TI = 0;    					//������Ϻ�Ҫ��TI������0
}
 
/*����һ���ַ���*/
void UART_send_string(uint8 *buf)
{
	while (*buf != '\0')
	{
		UART_send_byte(*buf++);
	}
}
 
main()
{
	UART_init();
	
	while (1)
	{
		//UART_send_byte('1');
		UART_send_string(Buf);
		delay(20000);
	}
}