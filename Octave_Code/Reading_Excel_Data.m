clc
clear all;

ReadXcel = xlsread('csv_matter.xlsx', 'Sheet1','A2:L1001');

A_XOUT_H = ReadXcel(:,1);
A_XOUT_L = ReadXcel(:,2);
A_YOUT_H = ReadXcel(:,3);
A_YOUT_L = ReadXcel(:,4);
A_ZOUT_H = ReadXcel(:,5);
A_ZOUT_L = ReadXcel(:,6);
G_XOUT_H = ReadXcel(:,7);
G_XOUT_L = ReadXcel(:,8);
G_YOUT_H = ReadXcel(:,9);
G_YOUT_L = ReadXcel(:,10);
G_ZOUT_H = ReadXcel(:,11);
G_ZOUT_L = ReadXcel(:,12);

res1 = double(typecast([uint8(A_XOUT_L), uint8(A_XOUT_H)], 'int16'))
res2 = double(typecast([uint8(A_YOUT_L), uint8(A_YOUT_H)], 'int16'))
res3 = double(typecast([uint8(A_ZOUT_L), uint8(A_ZOUT_H)], 'int16'))
res4 = double(typecast([uint8(G_XOUT_L), uint8(G_XOUT_H)], 'int16'))
res5 = double(typecast([uint8(G_YOUT_L), uint8(G_YOUT_H)], 'int16'))
res6 = double(typecast([uint8(G_ZOUT_L), uint8(G_ZOUT_H)], 'int16'))

t=0.01:0.01:10;

RES = [ res1 res2 ]; 

#disp(t)


subplot(1,1,1);
ylabel('A_XOUT');
xlabel('time');
plot(t,res1);
title('A_XOUT vs time');

#{
subplot(3,1,2);
xlabel('A_YOUT');
ylabel('G_YOUT');
plot(res2,res5);
title('A_YOUT vs G_YOUT');

subplot(3,1,3);
xlabel('A_ZOUT');
ylabel('G_ZOUT');
plot(res3,res6);
title('A_ZOUT vs G_ZOUT');
#}