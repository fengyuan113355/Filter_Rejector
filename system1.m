noise = wgn(1,101,2);  
for n=1:1:101  
    s(1,n) = 3*sin(0.2*n)+3*sin(0.4*n);  
end  
x = s + noise;  
%ÂË²¨Æ÷  
% y = sgolayfilt(x,3,7);  
h = [-2, 3, 6, 7, 6, 3, -2 ]/21;  
y = zeros(1,101);  
y(1,1:3) = s(1,1:3);  
y(1,99:101) = s(1,99:101);  
for k=4:1:98  
    y(1,k) = x(1,k-3)*h(1)+x(1,k-2)*h(2)+x(1,k-1)*h(3)+x(1,k)*h(4)+...  
             x(1,k+1)*h(5)+x(1,k+2)*h(6)+x(1,k+3)*h(7);  
end  
plot(x,'b');  
hold on  
plot(y,'r');  
hold on  
plot(s,'g');  
hold off  