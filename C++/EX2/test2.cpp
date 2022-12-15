#include<iostream>
using namespace std;

//part 1 ���ⶨ��

class Complex1 {
    public:
        double real;
        double imag;
        Complex1(double r=0,double i=0){
            real= r;
            imag = i;
        }
        void print(){cout<<"total.real="<<real<<endl<<"total.imag="<<imag<<endl;}
};

//��������غ���
Complex1 operator+ (Complex1 c1, Complex1 c2){
    Complex1 temp;  //��ʱ����
    temp.real = c1.real + c2.real;
    temp.imag = c1.imag + c2.imag;
    return temp;
}

//part 2 ��Ԫ

class Complex2 {
    double real;
    double imag;
    public:
        Complex2(double r=0,double i=0){
            real= r;
            imag = i;
        }
        void print(){cout<<"total.real="<<real<<endl<<"total.imag="<<imag<<endl;}
        //������Ԫ
        friend Complex2 operator + (Complex2 c1, Complex2 c2);
};

Complex2 operator + (Complex2 c1, Complex2 c2){
    Complex2 temp;  //��ʱ����
    temp.real = c1.real + c2.real;
    temp.imag = c1.imag + c2.imag;
    return temp;
}

//part 3 ��Ա����

class Complex3 {
    public:
        double real;
        double imag;
        Complex3(double r=0.0,double i=0.0){
            real= r;
            imag= i;
        }
        void print(){cout<<"total.real="<<real<<endl<<"total.imag="<<imag<<endl;}
        Complex3 operator+(Complex3 c);
};

Complex3 Complex3::operator+(Complex3 c){
    Complex3 temp;
    temp.real = real + c.real;
    temp.imag = imag + c.imag;
    return temp;
}

//part 4 �����˷�

class Complex4 {
    public:
        double real;
        double imag;
        Complex4(double r=0.0,double i=0.0){
            real= r;
            imag= i;
        }
        void print();
        friend Complex4 operator *(Complex4 &a,Complex4 &b);
};

Complex4 operator * (Complex4 &a,Complex4 &b){
    Complex4 temp;
    temp.real = a.real*b.real - a.imag*b.imag;
    temp.imag = a.real*b.imag + a.imag*b.real;
    return temp;
}
void Complex4::print(){
    cout<<real;
    if(imag>0){
        cout<<"+";
    }
    if(imag!=0){
        cout<<imag<<"i"<<endl;
    }
}


//������

int main( ){
    double r1,r2,i1,i2;
    cout<<"�������1��������ʵ�����鲿:"<<endl;
    cin>>r1>>i1;
    cout<<"�������2��������ʵ�����鲿:"<<endl;
    cin>>r2>>i2;

    cout<<"ʵ��1:"<<endl;
    Complex1 com1_1(r1,i1), com1_2(r2,i2), total1;
    total1 = com1_1 + com1_2;   //�ȼ�total = operator+ ( com1, com2) ;
    total1.print();

    cout<<"ʵ��2:"<<endl;
    Complex2 com2_1(r1,i1), com2_2(r2,i2), total2;
    total2 = com2_1 + com2_2;   //�ȼ�total = operator+ ( com1, com2) ;
    total2.print();

    cout<<"ʵ��3:"<<endl;
    Complex3 com3_1(r1,i1), com3_2(r2,i2), total3;
    total3 = com3_1+com3_2;      //�ȼ���com1.operator - (com2)
    total3.print();

    cout<<"ʵ��4:"<<endl;
    Complex4 com4_1(r1,i1), com4_2(r2,i2), total4;
    total4 = com4_1*com4_2;
    total4.print();

    return 0;
}
