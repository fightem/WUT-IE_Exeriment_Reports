#include <iostream>
#include <fstream>
using namespace std;

void insertion_sort(int arr[], int len){    //����������
    int i,j,temp;
    for (i=1;i<len;i++){
            temp = arr[i];
            for (j=i;j>0 && arr[j-1]>temp;j--)
                    arr[j] = arr[j-1];
            arr[j] = temp;}
}
int main(){
    ofstream out("EE-2022-Exercise.txt");   //�½��ļ�
    if(!out){
        cout<<"�޷��򿪸��ļ�\n";
        return 1;
    }
    cout<<"�½��ļ��ɹ�\n";
    int i,k=0;
    int array[174];
    for(i=0;i<174;i++)  //���������,д���ļ�
        array[i]=rand()%100;
    for(i=0;i<174;i++)
        out<<array[i]<<" ";
        cout<<"д���ļ��ɹ�\n";
        out.close();
    //���ļ�
    ifstream in("EE-2022-Exercise.txt");
    if(!in){
        cout<<"�޷����ļ�\n";
        return 1;
    }
    cout<<"���ļ��ɹ�\n";
    cout<<"�ļ���������:"<<endl;
    insertion_sort(array,174);  //���в�����������
    for(i=0;i<174;i++){
        cout<<array[i]<<" ";
        k++;
        if(k%15==0) cout<<endl;
    }
    in.close();
    return 0;
}