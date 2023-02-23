#include<reg52.h>
#define uchar unsigned char
#define uint  unsigned int
uchar buf;

sbit ADDR0=P1^0;	//λ��ַ����
sbit ADDR1=P1^1;
sbit ADDR2=P1^2;
sbit ADDR3=P1^3;
sbit ENLED=P1^4;

void main(void)
{
	ENLED=0;	//74HC138ʹ��
	ADDR3=1;
	
	ADDR2=1;	//74HC138����A2A1A0
	ADDR1=1;
	ADDR0=0;
	
	SCON=0x50;//�趨���ڹ�����ʽ0101 0000
	PCON=0x00;
	TMOD=0x20;
	EA=1;
	ES=1;
	TL1=0xfd;//������9600
	TH1=0xfd;
	TR1=1;
	while(1);
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