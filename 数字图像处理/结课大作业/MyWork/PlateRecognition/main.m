clc;          %���������
%����ͼƬ
[fn,pn,fi] = uigetfile('*.jpg','ѡ��ͼƬ');

I = imread([pn fn]);                %�����ɫͼ��
figure('Name','ԭʼͼ��');
imshow(I);
title('ԭʼͼ��');        %��ʾԭʼͼ��

%ͼ��ָ�(���ƶ�λ)
picture =image_segmentation(I);
threshold=50;

%��бУ��
[picture_1,angle] = rando_bianhuan(picture); 
% picture ����У�����ͼƬ
% angle ������б�Ƕ�

%��̬ѧ����
picture_6 = morphology(picture_1);

%��ͼ���һ���ü�
bw = image_clip(picture_6);

%���ַָ�
image=char_split(bw);

%��ʾ�ַ��ָ���
bb =char_recognition(image);

%��ʾ����ʶ����
imshow(picture_1);
title (['ʶ���ƺ���:', bb],'Color','r');
