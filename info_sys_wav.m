[y, Fs] = audioread('D:\��Ԫ\����\������\�ź���ϵͳ\laboration-files\music\go_home.wav'); 
t=0:1/22050:(size(x1)-1)/22050;
Au=0.03;
d=[Au*cos(2*pi*5000*t)]';
x2=x1+d;
wp=0.25*pi;
ws=0.3*pi;
Rp=1;
Rs=15;
Ts=1/Fs; 
wp1=2/Ts*tan(wp/2);
ws1=2/Ts*tan(ws/2);
[N,Wn]=buttord(wp1,ws1,Rp,Rs,'s');
[Z,P,K]=buttap(N);
[Bap,Aap]=zp2tf(Z,P,K);
[b,a]=lp2lp(Bap,Aap,Wn); 
[bz,az]=bilinear(b,a,Fs); 
[H,W]=freqz(bz,az);
figure(1);
plot(W*Fs/(2*pi),abs(H));
grid
xlabel('Ƶ�ʣ�Hz');
ylabel('Ƶ����Ӧ����');
title('Butterworth')
f1=filter(bz,az,x2);
figure(2);
subplot(2,1,1);
plot(t,x2);
title('�˲�ǰ��ʱ����');
subplot(2,1,2);
plot(t,f1);
title('�˲����ʱ����');
sound(f1,22050);
F0=fft(f1,1024);
f=fs*(0:511)/1024;
figure(3)
y2=fft(x2,1024);
subplot(2,1,1);
plot(f,abs(y2(1:512)));
title('�˲�ǰ��Ƶ��');
xlabel('Hz');
ylabel('fuzhi');
subplot(2,1,2);
F1=plot(f,abs(F0(1:512)));
title('�˲����Ƶ��');
xlabel('Hz');
ylabel('fuzhi');









