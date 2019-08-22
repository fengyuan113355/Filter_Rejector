[y, Fs] = audioread('D:\laboration-files\music\go_home.wav');
%Fs是采样频率---(每秒从信号中提取点的个数)
%采样定理：对信号做FFT时，无论你取多少点，其分析的频率范围就是0~Fs
%sound(y,Fs);
y1=fft(y,1024);%1024---y短补0至1024，长则截断成1024---y为一个横向量
f=Fs*(0:511)/1024;%为了使fft画图时横坐标的单位是Hz(涉及到采样定理)
figure(1);
plot(y)
title('原始语音信号');xlabel('时间t');ylabel('幅度n');
figure(2);
subplot(2,1,1);plot(f,abs(y(1:512)));
title('原始语音信号频谱'); xlabel('频率');ylabel('幅度');
subplot(2,1,2);plot(abs(y1(1:512)))
title('原始语音信号FFT频谱'); xlabel('频率');ylabel('幅度(+)'); 
figure(3);
freqz(y);
title('频率响应图'); 
%下面加噪声
L = length(y);
noise = 0.1*randn(L,1);
y_new = y + noise;
figure(4);
plot(y_new)
title('加噪语音信号');xlabel('时间t');ylabel('幅度n');

window_length = 100;
new_wav = zeros(size(y));
%均值滤波器
for index = 1:size(y)-window_length+1
    winsum = 0;
    for single = 0:window_length-1
        winsum = winsum+y(index+single);
    end
    new_wav(index) = winsum/window_length;
end
figure(5);
plot(new_wav)
title('均值去噪语音信号');xlabel('时间t');ylabel('幅度n');
%中位数滤波器
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
title('中位数去噪语音信号');xlabel('时间t');ylabel('幅度n');
sound(new_wav,Fs);











