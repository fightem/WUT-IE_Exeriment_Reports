#include <iostream>
#include <string.h>
using namespace std;


class Date{ //������
    int year;
    int month;
    int day;
    public:
        Date() {} //Ĭ�Ϲ���
        Date(int y, int m, int d){ //���ι���
            year = y;
            month = m;
            day = d;
        }
    void set(){ //�������ݺ���
        cin >> year >> month >> day;
    }
    void show(){ //��ʾ����
        cout << year << " Year " << month << " Month " << day << " Day ";
    }
};
class People{ //��Ա��
    char name[11];
    char number[20];
    char sex;
    Date birthday;  //��������Ƕ�Ӷ���
    char ID[30];
    public:
        People(){}; //Ĭ�Ϲ���
        People(char n[11], char num[7],int y, int m, int d, char id[20], char s = 'm') : birthday(y, m, d){     //��Ĭ��ֵ�Ĵ��ι���
            strcpy(name,n);
            strcpy(number,num);
            sex = s;
            strcpy(ID, id);
        };                
        People(People &p){              //�������캯��
            strcpy(name,p.name);
            strcpy(number,p.number);
            sex = p.sex;
            birthday = p.birthday;
            strcpy(ID, p.ID);
        }
        //������Ա����
        void input(){ //���뺯��
            cout << "Name:";
            cin >> name;
            cout << "Number:";
            cin >> number;
            cout << "Sex(m/f):";
            cin >> sex;
            cout << "Birthday(Year/Month/Day):";
            birthday.set();
            cout << "ID:";
            cin >> ID;
            cout << "--- --- --- --- ---\n";
        };
        void output(){ //�������
            cout << "¼���ѧ����Ϣ:" << endl;
            cout << "Number:" << number << endl;
            cout << "Name:" << name << endl;
            cout << "Sex:" << sex << endl;
            cout << "Birthday:";
            birthday.show();    
            cout << endl;
            cout << "ID:" << ID << endl;
        };
        ~People(){ //��������
            cout << "¼��ɹ�!." << endl;
        }
};

//Part 2
class student : public People{
    char classNO[10];
    public:
        student(){}
        void input(){
            People::input();
            cout << "������༶���:" << endl;
            cin >> classNO;
        }
        void output(){
            People::output();
            cout << "�༶���:" << classNO << endl;
        }
};
class teacher : public People{
    char pship[11], departt[21];
    public:
        teacher(){}
        void input(){
            People::input();
            cout << "������ְ��:" << endl;
            cin >> pship;
            cout << "�����벿��:" << endl;
            cin >> departt;
        }
        void output(){
            People::output();
            cout<<"ְ��: "<<pship<<endl;
            cout<<"����: "<<departt<<endl;
        }
    };

class graduate : public student{
        char subject[21], adviser[21];
        public:
            graduate(){}
            void input(){
                student::input();
                cout << "������רҵ: " << endl;
                cin >> subject;
                cout << "�����뵼ʦ: " << endl;
                cin >> adviser;
            }
            void output(){
                student::output();
                cout << "רҵ: " << subject << endl;
                cout << "��ʦ: " << adviser << endl;
            }
};
class TA: public graduate, teacher{
    public:
        TA(){}
        void input(){
            graduate::input();
            teacher::input();
        }
        void output(){
            graduate::output();
            teacher::output();
        }
};

int main(){
    People p;
    student s;
    teacher t;
    graduate g;
    TA T;

    cout << "��������Ա��Ϣ" << endl;
    p.input();
    cout << "������ѧ����Ϣ" << endl;
    s.input();
    cout << "�������ʦ��Ϣ" << endl;
    t.input();
    cout << "�������о�����Ϣ" << endl;
    g.input();
    cout << "���������̲�ʿ����Ϣ" << endl;
    T.input();
    cout << "��Ա��Ϣ: "<< endl;
    p.output();
    cout << "ѧ����Ϣ:"<< endl;
    s.output();
    cout << "��ʦ��Ϣ: "<< endl;
    t.output();
    cout << "�о�����Ϣ: "<< endl;
    g.output();
    cout << "���̲�ʿ����Ϣ: "<< endl;
    T.output();
    return 0;
}