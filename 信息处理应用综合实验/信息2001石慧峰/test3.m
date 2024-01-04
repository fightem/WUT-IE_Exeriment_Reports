I = imread('dog.png');
I = rgb2gray(I);
figure;
subplot(221)
imshow(I),title('ԭʼͼ��');
I_noise = imnoise(I,'gaussian');
subplot(222)
imshow(I_noise),title('��˹����ͼ��')

subplot(223)
F = fft2(I);
F = fftshift(F);
F=log(abs(F)+1);
imshow(F,[]),title('ԭʼͼ��Ƶ��');

subplot(224)
F_noise = fft2(I_noise);
F_noise = fftshift(F_noise);
F_noise=log(abs(F_noise)+1);
imshow(F_noise,[]),title('��˹����ͼ��Ƶ��')


figure
I_denoise = medfilt2(I_noise,[3,3]);
subplot(221)
imshow(I_noise),title('��˹����ͼ��')
subplot(222)
imshow(I_denoise),title('��ֵ�˲�ͼ��')
subplot(223)
imshow(F_noise,[]),title('��˹����ͼ��Ƶ��')
subplot(224)
f =log(abs(fftshift(fft2(I_denoise)))+1);
imshow(f,[]),title('��ֵ�˲�ͼ��Ƶ��')

fftImage = F_noise;
% ��˹�˲�
sigma = 1.2; % ��˹�˵ı�׼������˲����Ĺ��
filteredImage = imgaussfilt(I_noise, sigma);
F = fftshift(fft2(filteredImage));



% ��ʾ���
figure;
subplot(2, 2, 1), imshow(I_noise), title('��˹����ͼ��');
subplot(2, 2, 2), imshow(filteredImage), title('��ͨ�˲�������ͼ��');
subplot(2,2,3),imshow(F_noise,[]),title('��˹����ͼ��Ƶ��')
subplot(2,2,4),imshow(log(abs(F)+1),[]),title('��ͨ�˲�Ƶ��')

[c,s]=wavedec2(I_noise,2,'sym5');%ʹ��С��sym5����ͼ����ж���ֽ�
[THR,SORH,KEEPAPP]=ddencmp('den','wv',I_noise);%����ȥ���Ĭ����ֵ��
[X_denoise,CXC,LXC,PERF0,PERFL2]=wdencmp('gbl',c,s,'sym5',2,THR,SORH,KEEPAPP);
subplot(2,2,[3,4]);image(X_denoise);title('ȥ����ͼ��Xnoise');axis square;

