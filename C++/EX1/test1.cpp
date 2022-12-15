//C++������� ����ʵ��
//ʵ��һ �������Ĳ���ʵ��
//author: ��Ϣ2001 ���

#include <iostream>
#include <string.h>
#include <iomanip>
using namespace std;

//����һ��ѧ����Student
class Student{
    public:
        //���ι��캯��
        Student(int s_id,string s_name,double s_score);
        //�޸ķ����ĳ�Ա����
        void ChangeScore();
        //���ƽ���ֵľ�̬��Ա����
        static void GetAverage();
    private:
        int id;
        string name;
        double score;
        static double total;
        static int count;
};

//��̬��Ա������ʼ��
double Student::total=0;
int Student::count=0;

//��Ա��������
void Student::ChangeScore(){
    total+=score;
    count++;
};

void Student::GetAverage(){
	cout<<setprecision(4);  //�������2λС��
    cout<<"����ƽ����Ϊ:"<<total/count<<"��"<<endl;
};

//���캯����ʼ��
Student::Student(int i,string n,double s):id(i),name(n),score(s){};

int main(){
    int id;
    string name;
    double score;
    int num;
    cout<<"������ѧ������:"<<endl;
    cin>>num;
    cout<<"ѧ������Ϊ"<<num<<"��"<<endl;
    for(int i=0;i<num;i++){
        cout<<"������ѧ��ѧ��,����,����:"<<endl;
        cin>>id>>name>>score;
        Student stu(id,name,score);
        stu.ChangeScore();
        
    }
    Student::GetAverage();
    return 0;
};