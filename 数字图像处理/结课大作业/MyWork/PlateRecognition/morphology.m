function picture_6 = morphology(picture_1)
threshold = 50;
picture_2 = im2bw(picture_1,graythresh(picture_1)); 
%�����䷽� ��һ�ֻ���ȫ�ֵĶ�ֵ���㷨�����Ǹ���ͼ��ĻҶ�����,��ͼ���Ϊǰ���ͱ�����������
%���Ҷ�ͼ�� I ת��Ϊ��ֵͼ�� BW�������ǽ�����ͼ�������ȴ��� level �����������滻Ϊֵ 1����ɫ�������������������滻Ϊֵ 0����ɫ����

figure('Name','���ƶ�ֵ��'),imshow(picture_2);
title('��ֵ��');

%�Զ�ֵͼ�����̬ѧ���� �Ƴ�H��ͨ������ inf��ָ�ظ�����ָ��ͼ���ٱ仯
picture_3 = bwmorph(picture_2,'hbreak',inf); 
%ɾ����ɢ����
picture_4 = bwmorph(picture_3,'spur',inf);
%ִ����̬ѧ�����㣨�ȸ�ʴ�����ͣ��������ܹ���ȥ������С�㣬ë�̺�С�ţ����ܵ�λ�ú���״����
picture_5 = bwmorph(picture_4,'open',inf);
% bwareaopen(BW,P) �Ӷ�ֵͼ�� BW ��ɾ������ P �����ص�������ͨ���������󣩣���������һ����ֵͼ�� BW2���������Ϊ��������㡣
picture_6 = bwareaopen(picture_5,threshold);

picture_6 = ~picture_6; %��ת

figure('Name','��̬ѧ����'),imshow(picture_6);
title('��̬ѧ����'); 