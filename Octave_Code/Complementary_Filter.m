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

res1 = double(typecast([uint8(A_XOUT_L), uint8(A_XOUT_H)], 'int16'));
res2 = double(typecast([uint8(A_YOUT_L), uint8(A_YOUT_H)], 'int16'));
res3 = double(typecast([uint8(A_ZOUT_L), uint8(A_ZOUT_H)], 'int16'));
res4 = double(typecast([uint8(G_XOUT_L), uint8(G_XOUT_H)], 'int16'));
res5 = double(typecast([uint8(G_YOUT_L), uint8(G_YOUT_H)], 'int16'));
res6 = double(typecast([uint8(G_ZOUT_L), uint8(G_ZOUT_H)], 'int16'));

ts = 0.01;
T = 0:0.01:9.99;

for i=1:((length(res1)))
  if res1(i)<0
    acc1(i,:)=-19.8+(-res1(i,:)*0.0006);
  endif
  if res1(i)>0
    acc1(i,:)=19.8-(res1(i,:)*0.0006);
  endif
  if res2(i)<0
    acc2(i,:)=-19.8+(-res2(i,:)*0.0006);
  endif
  if res2(i)>0
    acc2(i,:)=19.8-(res2(i,:)*0.0006);
  endif
  if res3(i)<0
    acc3(i,:)=-19.8+(-res3(i,:)*0.0006);
  endif
  if res3(i)>0
    acc3(i,:)=19.8-(res3(i,:)*0.0006);
  endif
endfor

gyr2=zeros(1000,1);
gyr3=zeros(1000,1);

for i=1:((length(res4)))
  if res4(i,:)<0
    gyr1(i,:)=-250+(-res4(i,:)*0.0076);
  endif
  if res4(i,:)>0
    gyr1(i,:)=250-(res4(i,:)*0.0076);
  endif  
  if res5(i,:)<0
    gyr2(i,:)=-250+(-res5(i,:)*0.0076);
  endif
  if res5(i,:)>0
    gyr2(i,:)=250-(res5(i,:)*0.0076);
  endif
  if res6(i,:)<0
    gyr3(i,:)=-250+(-res6(i,:)*0.0076);
  endif
  if res6(i,:)>0
    gyr3(i,:)=250-(res6(i,:)*0.0076);
  endif
endfor

#calculate mean bias value
#mean_gyrx = sum(gyr1(1:100))/100;
#mean_gyry = sum(gyr2(1:100))/100;
#mean_gyrz = sum(gyr3(1:100))/100;

#gyr3=gyr3-mean_gyry;

angacc(1,:)=atan2(acc1(1,:),sqrt((acc2(1,:)*acc2(1,:)) + (acc3(1,:)*acc3(1,:))))*(180/pi);
anggyr(1,:)=angacc(1,:);
#anggyr2(1,:)=angacc(1,:);
angcffilt(1,:)=angacc(1,:);
#angcffilt2(1,:)=angacc(1,:);
hp(1,:) = angacc(1,:);
lp(1,:)=angacc(1,:);

for i=2:length(acc1)
angacc(i,:) = (atan2(acc1(i,:),sqrt((acc2(i,:)*acc2(i,:)) + (acc3(i,:)*acc3(i,:)))))*(180/pi);
anggyr(i,:)= ((angcffilt(i-1,:)+(gyr2(i,:)*ts)));
#anggyr2(i,:)= angcffilt2(i-1,:)+(gyr2(i,:)*ts);

alpha=0.7;
beta = 1-alpha;

lp(i,:) = ((1-alpha) * lp(i-1,:)) + (alpha * (angacc(i,:)));
hp(i,:) = ((1-alpha)* hp(i-1,:)) + ((1-alpha)*(anggyr(i,:) - anggyr(i-1,:)));

angcffilt(i,:) = (lp(i,:) + hp(i,:)) ; 

endfor

#subplot(3,1,1);
plot(T,angacc);
#subplot(3,1,2);
hold on;
plot(T,anggyr,'r');
#hold on;
#plot(T,lp,'g');
#hold on;
#plot(T,hp,'y')
hold on;
plot(T,angcffilt,'k')

#{
for i=2:length(acc1)
  
  anggyr(i,:) = anggyr(i-1,:) + (gyr2(i,:)*ts);
  angacc(i,:) = atan2(acc1(i,:),sqrt((acc2(i,:)*acc2(i,:)) + (acc3(i,:)*acc3(i,:)))*(180/pi));   

endfor
#}


#{
angacc1=angacc
anggyr1=anggyr

subplot(3,1,1);
plot(T,angacc1);

subplot(3,1,2);
plot(T,anggyr1);

fc = 100;
RC = 1/(2*pi*fc) ;
alplp =  0.01 / (RC+0.01);
alphp =  RC / (RC+0.01);

#xlpfilt(1)=acc1(1);
#ylpfilt(1)=acc2(1);
#zlpfilt(1)=acc3(1);

angacclp(1,:)=angacc1(1,:);
anggyrhp(1,:)=anggyr1(1,:);

for i=2:length(gyr1)
  
  #xlpfil(i)=(1-alplp)*xlpfilt(i-1) + alplp*acc1(i);
  #ylpfil(1)=(1-alplp)*ylpfilt(i-1) + alplp*acc2(i);
  #zlpfil(1)=(1-alplp)*zlpfilt(i-1) + alplp*acc3(i);
  
  angacclp(i,:)=(1-alplp)*angacclp(i-1,:) + alplp*angacc1(i,:);
  
  anggyrhp(i,:) = (alphp*anggyrhp(i-1,:))+ (alphp*(anggyr1(i,:)-anggyr1(i-1,:)))
  
  angcffilt(i,:) = (anggyrhp(i,:)*0.02) + (0.98*angacclp(i,:));
  
endfor

T = 0:0.01:9.99;
subplot(3,1,3);
plot(T,angcffilt);
#}