#ifndef _LED_BUZZER_H
#define _LED_BUZZER_H

struct sLedBuff {  //LED��ʾ�������ṹ
    uint8 array[8];   //���󻺳���
    uint8 number[6];  //����ܻ�����
    uint8 alone;      //����LED������
};

#ifndef _LED_BUZZER_C
extern bit staBuzzer;
extern struct sLedBuff ledBuff;
#endif

void InitLed();
void FlowingLight();
void ShowLedNumber(uint8 index, uint8 num, uint8 point);
void ShowLedArray(uint8 *ptr);

#endif
