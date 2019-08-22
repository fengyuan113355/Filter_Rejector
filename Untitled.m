%均值滤波

clc,clear;

f=imread('lena.jpg');

subplot(121),imshow(f),title('原图');

f1=imnoise(f,'gaussian',0.002,0.0008);

%subplot(222),imshow(f1),title('添加高斯噪声图');

k1=floor(3/2)+1;

k2=floor(3/2)+1;

X=f1;

[M,N]=size(X);

uint8 Y=zeros(M,N);

funBox=zeros(3,3);

for i=1:M-3    

    for j=1:N-3        

        funBox=X(i:i+3,j:j+3);        

        s=sum(funBox(:));

        h=s/9;   

        Y(i+k1,j+k2)=h;    

    end;

end;

Y=Y/255;

subplot(122),imshow(Y),title('均值滤波');