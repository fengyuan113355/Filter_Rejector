fs=32768;
[x1, ~] = audioread('D:\冯元\大三\大三上\信号与系统\laboration-files\music\go_home.wav');
t=0:1/32768:(size(x1)-1)/32768;
Au=0.03;
d=[Au*cos(2*pi*10000*t)]';
x2=x1+d;
wp=0.25*pi;
ws=0.3*pi;
Rp=1;
Rs=15;
Fs=32768;
Ts=1/Fs;
wp1=2/Ts*tan(wp/2);             %将模拟指标转换成数字指标
ws1=2/Ts*tan(ws/2); 
[N,Wn]=buttord(wp1,ws1,Rp,Rs,'s');%选择滤波器的最小阶数
[Z,P,K]=buttap(N);                 %创建butterworth模拟滤波器
[Bap,Aap]=zp2tf(Z,P,K);
[b,a]=lp2lp(Bap,Aap,Wn);   
[bz,az]=bilinear(b,a,Fs);          %用双线性变换法实现模拟滤波器到数字滤波器的转换
[H,W]=freqz(bz,az);                %绘制频率响应曲线
figure(1)
plot(W*Fs/(2*pi),abs(H))
grid
xlabel('频率／Hz')
ylabel('频率响应幅度')
title('Butterworth')
f1=filter(bz,az,x2);
figure(2)
subplot(2,1,1)
plot(t,x2)                %画出滤波前的时域图
title('滤波前的时域波形');
subplot(2,1,2)
plot(t,f1);               %画出滤波后的时域图
title('滤波后的时域波形');
sound(f1,32768);        %播放滤波后的信号
F0=fft(f1,1024);
f=fs*(0:511)/1024;
figure(3)
y2=fft(x2,1024);
subplot(2,1,1);
plot(f,abs(y2(1:512)));          %画出滤波前的频谱图
title('滤波前的频谱')
xlabel('Hz');
ylabel('fuzhi');
subplot(2,1,2)
F1=plot(f,abs(F0(1:512)));     %画出滤波后的频谱图
title('滤波后的频谱')
xlabel('Hz');
ylabel('fuzhi');