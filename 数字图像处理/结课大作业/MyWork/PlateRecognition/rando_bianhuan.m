function [picture,angle] = rando_bianhuan(bw) %��бУ��  
% picture ����У�����ͼƬ angle��б�Ƕ�

I=rgb2gray(bw);
%rgb2gray ����ͨ������ɫ���ͱ��Ͷ���Ϣ��ͬʱ�������� ��RGBͼ��ת��Ϊ�Ҷ�ͼ��
I=edge(I); %���ض�ֵͼ�� BW�����е�ֵ 1 ��Ӧ�ڻҶȻ��ֵͼ�� I �к����ҵ���Ե��λ�ã�ֵ 0 ��Ӧ������λ��
theta = 1:180;
[R,~] = radon(I,theta); %���ػ��� theta ��ָ���Ƕȵ� Radon �任��
[~,J] = find(R>=max(max(R)));  %J��¼����б��
angle=90-J;
picture=imrotate(bw,angle,'bilinear','crop'); %������ת���ͼ�����������ʾ��ʱ����ת ������ʾ˳ʱ����ת��
figure('Name','��бУ��ͼ��');
imshow(picture);title('��бУ��');
imwrite(picture,'��бУ������.jpg');