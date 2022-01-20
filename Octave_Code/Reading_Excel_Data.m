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

RES = [ res1 res2 res3 res4 res5 res6 ]; 

subplot(6,1,1);
ylabel('A_XOUT');
xlabel('time');
plot(t,res1);
title('A_XOUT vs time');

subplot(6,1,2);
ylabel('A_YOUT');
xlabel('time');
plot(t,res2);
title('A_YOUT vs time');

subplot(6,1,3);
ylabel('A_ZOUT');
xlabel('time');
plot(t,res3);
title('A_ZOUT vs time');

subplot(6,1,4);
ylabel('G_XOUT');
xlabel('time');
plot(t,res4);
title('G_XOUT vs time');

subplot(6,1,5);
ylabel('G_YOUT');
xlabel('time');
plot(t,res5);
title('G_YOUT vs time');

subplot(6,1,6);
ylabel('G_ZOUT');
xlabel('time');
plot(t,res6);
title('G_ZOUT vs time');
