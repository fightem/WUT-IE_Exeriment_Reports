#ifndef _MAIN_H
#define _MAIN_H

enum eStaSystem {  //ϵͳ����״̬ö��
    E_NORMAL, E_SET_TIME, E_SET_ALARM
};

#ifndef _MAIN_C
extern enum eStaSystem staSystem;
#endif

void RefreshTemp(uint8 ops);
void ConfigTimer0(uint16 ms);

#endif
