close all;   %�رյ�ǰ����ͼ�δ���
clear all;    %��������ռ����
clc;            %�������������
[y,fs]=audioread('hushan.wav');%��ȡ����wav�ļ�

% figure;
% plot(x);
window_size = 0.02; % ���ڴ�С����λ��
window_overlap = 0.5*window_size; % �����ص���С����λ��
frame_length = round(window_size * fs); %֡����

N = frame_length;
inc=0.5*N;  %֡��
p = 32;  %÷���˲�������


N2=length(y);  %�����źų���

y_preemphasized = filter([1, -0.9], 1, y); % Ԥ����

% audiowrite('D:\����\t1.wav',y_preemphasized,fs);
figure;
subplot(121)
plot(y),title('ԭʼ����');
subplot(122)
plot(y_preemphasized),title('Ԥ���غ�����');
f = abs(fft(y));
f_pre = abs(fft(y_preemphasized));
figure
subplot(121)
plot(f),title('ԭʼ����Ƶ��');
subplot(122)
plot(f_pre),title('Ԥ��������Ƶ��');

% ���һ����ֵ�˲���
window_size = 20; % ���ô��ڴ�С
b = (1/window_size) * ones(1, window_size);

% Ӧ���˲������н���
denoised_signal = filter(b, 1, y_preemphasized);

figure
subplot(121),plot(f_pre),title('ȥ��ǰ����Ƶ��');
subplot(122),plot(abs(fft(denoised_signal))),title('�˲�������Ƶ��');

S=enframe(y,frame_length,inc);%��֡,�������ź�x���з�֡��
[a,b]=size(S);  %aΪ����������bΪ��������
%��������������C
C=zeros(a,b);
ham=hamming(b);
for i=1:a
    C(i,:)=ham;
end
%��������C��S��˵�SC
SC=S.*C;
figure
subplot(121),plot(S(10,:)),title('�Ӵ�ǰһ֡���ź�');
subplot(122),plot(SC(10,:)),title('�Ӵ���һ֡���ź�');

F=0;N=frame_length;
for i=1:a
    %��SC��N=1024��FFT�任
    D(i,:)=fft(SC(i,:),N);
    %����ѭ��ʵ����ȡ��������
    for j=1:N
        t=abs(D(i,j));
        E(i,j)=(t^2);
    end
end


fl=0;fh=fs/2;%����Ƶ�ʷ�Χ����Ƶ�͸�Ƶ
bl=2595*log10(1+fl/700);%�õ�÷���̶ȵ���Сֵ
bh=2595*log10(1+fh/700);%�õ�÷���̶ȵ����ֵ
%÷�����귶Χ
% p=26;%�˲�������
B=bh-bl;%÷���̶ȳ���
mm=linspace(0,B,p+2);%�滮34����ͬ��÷���̶ȡ���ֻ��32��÷���˲���
fm=700*(10.^(mm/2595)-1);%��MelƵ��ת��ΪƵ��
W2=N/2+1;%fs/2�ڶ�Ӧ��FFT����,1024��Ƶ�ʷ���

k=((N+1)*fm)/fs;%����34����ͬ��kֵ
hm=zeros(p,N);%����hm����
df=fs/N;
freq=(0:N-1)*df;%����Ƶ��ֵ

%����÷���˲���
for i=2:p+1
    %ȡ��
    n0=floor(k(i-1));  %floorΪ����ȡ�������ȡ������ʾ�����˲�����ĸ����ĵ㱻����FFT ���ݶ�Ӧ�ĵĵ�λƵ���ϣ�����Ƶ�����ߵ������ζ���������FFT ���ݵ��ϣ��������˲������ж�����ͬһ�߶ȡ�
    n1=floor(k(i));
    n2=floor(k(i+1));

   
    for j=1:N
       if n0<=j & j<=n1
           hm(i-1,j)=(j-n0)/(n1-n0);
       elseif n1<=j & j<=n2
           hm(i-1,j)=(n2-j)/(n2-n1);
       end
   end
   %�˴���ȡH1(k)������
end

 %÷���˲����˲�
 H=E*hm';
 %��H����Ȼ��������
 %��Ϊ�˶��������������źű���Ĵ�С���ݴη���ϵ������Ҫ�������
 for i=1:a
     for j=1:p
         H(i,j)=log(H(i,j));
     end
 end
 %����ɢ���ұ任 
Fbank = H';

figure;
plot(Fbank);
imagesc(Fbank);
axis xy;   %y���������
colorbar;
xlabel('������֡֡��');
ylabel('fbank����ά��');

Fbank1 = dct(Fbank);
mfcc = Fbank1';
figure;
plot(mfcc);
imagesc(mfcc');
axis xy;   %y���������
colorbar;
xlabel('������֡֡��');
ylabel('mfcc����ά��');
