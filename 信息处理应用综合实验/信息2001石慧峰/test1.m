%1. �����źŲɼ��������������¼���ļ���
audioFilePath = 'voice.wav';
[y, fs] = audioread(audioFilePath);
y = y(:,1);
N = length(y);
f = fs/N*(1:round(N/2)-1);
figure
plot(y),;

% 2. Ԥ����
y_preemphasized = filter([1, -0.97], 1, y); % Ԥ����

% ����FFT
y_fre = abs(fft(y));
y_pre_fre = abs(fft(y_preemphasized));

figure;
subplot(121)
plot(f,y_fre(1:round(N/2)-1))
title('ԭʼ����Ƶ��')
subplot(122)
plot(f,y_pre_fre(1:round(N/2)-1))
title('Ԥ��������Ƶ��')

window_size = 0.02; % ���ڴ�С����λ��
window_overlap = 0.5*window_size; % �����ص���С����λ��
frame_length = round(window_size * fs); %֡����

window_hamming = hamming(frame_length, 'periodic');
window_rectwin = rectwin(frame_length);
frame = buffer(y_preemphasized, frame_length, round(window_overlap * fs), 'nodelay');
num_frames = size(frame, 2);%֡��
frames_hamming = frame.*repmat(window_hamming,1,num_frames);
frames_rectwin = frame.*repmat(window_rectwin,1,num_frames);

figure; 
subplot(1,2,1)
nfft = 2^nextpow2(frame_length); % �ص�����
nooverlap = frame_length/2; % �ص�����
[S, F, T, P] = spectrogram(y_preemphasized, window_hamming, nooverlap, nfft, fs); 
imagesc(T, F, log10(abs(S))) % ��ͼ����
colorbar;
set(gca, 'YDir', 'normal') % ����������
xlabel('Time (secs)')
ylabel('Freq (Hz)')
title('����������ͼ')

subplot(1,2,2)
[S, F, T, P] = spectrogram(y_preemphasized, window_rectwin, nooverlap, nfft, fs); 
imagesc(T, F, log10(abs(S))) % ��ͼ����
colorbar;
set(gca, 'YDir', 'normal') % ����������
xlabel('Time (secs)')
ylabel('Freq (Hz)')
title('���δ�����ͼ')



% 3. �����˵���
% ��ƻ��������͹����ʵĶ˵���

energy_threshold_min = 0.00017;
energy_threshold_max = 0.0001;
zero_crossing_threshold = 20;

energy_hamming = sum(frames_hamming.^2);
energy_rectwin = sum(frames_rectwin.^2);

zero_crossings_hamming = sum(abs(diff(sign(frames_hamming))) / 2);
zero_crossings_rectwin = sum(abs(diff(sign(frames_rectwin))) / 2);



endpoints = [];
lastframe = 0;
for i = 1:1:num_frames

    if energy_hamming(1,i)>energy_threshold_min & lastframe==0
        endpoints = [endpoints i];
        lastframe = 1       
    end  
    if energy_hamming(1,i)<energy_threshold_max & lastframe==1
        endpoints = [endpoints i];
        lastframe = 0
        endpoints
    end  
end

figure;
subplot(221)
plot(energy_hamming);
title('��������ʱ����');
subplot(222)
plot(energy_rectwin);
title('���δ���ʱ����');
subplot(223)
plot(zero_crossings_hamming);
title('��������ʱ������');
subplot(224)
plot(zero_crossings_rectwin);
title('���δ���ʱ������');


figure

plot(y_preemphasized);
title('�˵���')


x_positions = endpoints*0.5*frame_length;

hold on; % ����ͼ�δ��ڿ������Ա���ͬһͼ�����������

for i = 1:length(x_positions)
    % ������
    line([x_positions(i), x_positions(i)], ylim, 'Color', 'r', 'LineStyle', '--');
end

hold off;

% �����ʱ����غ���


R_hamming = []
for i = 1:num_frames
    u = frames_hamming(:,i);
    R_hamming = cat(1,R_hamming,xcorr(u));
end

R_rectwin = []
for j = 1:num_frames
    u = frames_rectwin(:,j);
    R_rectwin = cat(1,R_rectwin,xcorr(u));
end
figure;
subplot(121);
plot(R_hamming);
title('֡��50ms,��������ʱ����غ���')
subplot(122);
plot(R_rectwin);
title('֡��50ms,���δ���ʱ����غ���')







