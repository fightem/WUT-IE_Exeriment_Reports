function bw = image_clip(picture_6) %�ü�ͼƬ�ĺ���
threshold =30 ;
picture_7=touying(picture_6);
picture_8=~picture_7;
picture_9 = bwareaopen(picture_8, threshold);%ɾ����ֵͼ��BW�����С��P�Ķ��������ֵ��50
picture_10=~picture_9;
[~,~]=size(picture_10);%�Գ������¸�ֵ %1Ϊ��ɫ
bw = picture_10;
[~,x] = size(bw);
dd = fix(x/40);
ddd = fix(x/30);
dd = x - dd;
bw = bw(:,ddd:dd);
figure('Name','�߿�ȥ��'),imshow(bw),title('�߿�ȥ��');  