%����С���ֽ��С����ֵȥ��ʵ��ͼ��ȥ��
close all;   %�رյ�ǰ����ͼ�δ���
clear all;    %��������ռ����
clc;            %�������������

X = imread('dog.png');
X = rgb2gray(X);
XX = imnoise(X,'gaussian');

figure
subplot(121),imshow(X),title('ԭͼ��');
subplot(122),imshow(XX),title('��˹����ͼ��');

figure
[ca1,chd1,cvd1,cdd1] = dwt2(X,'bior3.7');   %���е���С���ֽ�
set(0,'defaultFigurePosition',[100,100,1000,500]); %�޸�ͼ��ͼ��λ�õ�Ĭ������
set(0,'defaultFigureColor',[1 1 1])  
                         
subplot(121); 
imshow(uint8(ca1)); %����ϵ������
title('���Ʒ���')
subplot(1,2,2); 
imshow(chd1);   %ϸ��ϵ����ˮƽ����
title('ϸ��ˮƽ����')
figure
subplot(121);   
imshow(cvd1);   %ϸ��ϵ���Ĵ�ֱ����
title('ϸ�ڴ�ֱ����')
subplot(122); 
imshow(cdd1);    %ϸ��ϵ���ĶԽǷ���
title('ϸ�ڶԽǷ���') 



X = imread('D:\����\dog.png');
XX = imnoise(X,'gaussian');
[c,l]=wavedec2(XX,2,'sym4'); %��ͼ��������봦����sym4С��������x��������ֽ�
a2=wrcoef2('a',c,l,'sym4',2);  %�ع��ڶ���ͼ��Ľ���ϵ��
n=[1,2];                              %���ó߶�����
p=[10.28,24.08];                  %������ֵ����
nc=wthcoef2('t',c,l,n,p,'s');   %�Ը�ƵС��ϵ��������ֵ����
mc=wthcoef2('t',nc,l,n,p,'s');  %�ٴζԸ�ƵС��ϵ��������ֵ����
X2=waverec2(mc,l,'sym4');   %ͼ��Ķ�άС���ع�
set(0,'defaultFigurePosition',[100,100,1000,500]); %�޸�ͼ��ͼ���Ĭ������
set(0,'defaultFigureColor',[1 1 1])    %�޸�ͼ�α�����ɫ������     
figure


subplot(121),image(XX),axis square;   %��ʾ��������ͼ��
title('��������ͼ��')
subplot(122),image(a2),axis square;     %��ʾС���ֽ�ȥ����ͼ��
title('С���ֽ�ȥ��')




