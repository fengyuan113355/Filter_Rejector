[y, Fs] = audioread('D:\laboration-files\music\go_home.wav');
%Fs�ǲ���Ƶ��---(ÿ����ź�����ȡ��ĸ���)
%�����������ź���FFTʱ��������ȡ���ٵ㣬�������Ƶ�ʷ�Χ����0~Fs
%sound(y,Fs);
y1=fft(y,1024);%1024---y�̲�0��1024������ضϳ�1024---yΪһ��������
f=Fs*(0:511)/1024;%Ϊ��ʹfft��ͼʱ������ĵ�λ��Hz(�漰����������)
figure(1);
plot(y)
title('ԭʼ�����ź�');xlabel('ʱ��t');ylabel('����n');
figure(2);
subplot(2,1,1);plot(f,abs(y(1:512)));
title('ԭʼ�����ź�Ƶ��'); xlabel('Ƶ��');ylabel('����');
subplot(2,1,2);plot(abs(y1(1:512)))
title('ԭʼ�����ź�FFTƵ��'); xlabel('Ƶ��');ylabel('����(+)'); 
figure(3);
freqz(y);
title('Ƶ����Ӧͼ'); 
%���������
L = length(y);
noise = 0.1*randn(L,1);
y_new = y + noise;
figure(4);
plot(y_new)
title('���������ź�');xlabel('ʱ��t');ylabel('����n');

window_length = 100;
new_wav = zeros(size(y));
%��ֵ�˲���
for index = 1:size(y)-window_length+1
    winsum = 0;
    for single = 0:window_length-1
        winsum = winsum+y(index+single);
    end
    new_wav(index) = winsum/window_length;
end
figure(5);
plot(new_wav)
title('��ֵȥ�������ź�');xlabel('ʱ��t');ylabel('����n');
%��λ���˲���
for index = 1:size(y)-window_length+1
    winsum = 0;
    vol = zeros(window_length,1);
    for single = 0:window_length-1
        vol(single+1) = y(index+single);
    end
    media_vol = median(vol);
    new_wav(index) = media_vol(1);
end
figure(6);
plot(new_wav)
title('��λ��ȥ�������ź�');xlabel('ʱ��t');ylabel('����n');
sound(new_wav,Fs);











