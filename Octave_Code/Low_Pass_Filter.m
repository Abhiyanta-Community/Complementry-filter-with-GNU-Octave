clc
clear all;

#Reading Excelsheet Data
ReadXcel = xlsread('csv_matter.xlsx', 'Sheet1','A2:L1001');
A_XOUT_H = ReadXcel(:,1);
A_XOUT_L = ReadXcel(:,2);
A_YOUT_H = ReadXcel(:,3);
A_YOUT_L = ReadXcel(:,4);
A_ZOUT_H = ReadXcel(:,5);
A_ZOUT_L = ReadXcel(:,6);

#convert 2 8bit data of accelerometer into 16bit data
res1 = double(typecast([uint8(A_XOUT_L), uint8(A_XOUT_H)], 'int16'))
res2 = double(typecast([uint8(A_YOUT_L), uint8(A_YOUT_H)], 'int16'))
res3 = double(typecast([uint8(A_ZOUT_L), uint8(A_ZOUT_H)], 'int16'))

#set cuttoff frequency and controlling factor alpha
fc = 100;
RC = 1/(2*pi*fc) ;
alpha =  0.01 / (RC+0.01);
pkg load signal

#part for unmapping of data scale range +/-2g
Part = 39.2/65535;

for i=1:((length(res1)))
  if res1(i)<0
    acc1(i)=-19.8+(-res1(i)*0.0006);
  endif
  if res1(i)>0
    acc1(i)=19.8-(res1(i)*0.0006);
  endif
endfor

t=0:0.01:9.99;
subplot(3,1,1);
plot(t,acc1);

#filtering unmaped data of accx using low pass filter equation and plotting graph
fil1(1)=acc1(1)
for i=1:((length(acc1))-1)  
  fil1(i+1)=(alpha*acc1(i+1))+(fil1(i)*(1-alpha))
endfor

t=0:0.01:9.99;
subplot(3,2,1);
plot(t,fil1)

for i=1:((length(res2)))
  if res1(i)<0
    acc2(i)=-19.8+(-res2(i)*0.0006);
  endif
  if res2(i)>0
    acc2(i)=19.8-(res2(i)*0.0006);
  endif
endfor

t=0:0.01:9.99;
subplot(6,1,2);
plot(t,acc2);

fil2(1)=acc2(1)
for i=1:((length(acc2))-1)  
  fil2(i+1)=(alpha*acc2(i+1))+(fil2(i)*(1-alpha))
endfor

t=0:0.01:9.99;
subplot(6,2,2);
plot(t,fil2)

for i=1:((length(res3)))
  if res3(i)<0
    acc3(i)=-19.8+(-res3(i)*0.0006);
  endif
  if res3(i)>0
    acc3(i)=19.8-(res3(i)*0.0006);
  endif
endfor

t=0:0.01:9.99;
subplot(6,1,3);
plot(t,acc3);


fil3(1)=acc3(1)
for i=1:((length(acc3))-1)  
  fil3(i+1)=(alpha*acc3(i+1))+(fil3(i)*(1-alpha))
endfor

t=0:0.01:9.99;
subplot(6,2,3);
plot(t,fil3)

