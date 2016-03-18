% parametric identificiation prediction error model
clear all;
%data
data5=importdata('IDENTIFICATION_PRESSURE_Save_05.txt'); %high SNR
data1=importdata('IDENTIFICATION_PRESSURE_Save_01.txt'); %low SNR

u5=data5(:,1);
y5=data5(:,2);
u1=data1(:,1);
y1=data1(:,2);

Ts=0.1;

%cleaning output signal
transient=75;
stop=475;

u5=u5(transient:stop);
y5=y5(transient:stop);
u1=u1(transient:stop);
y1=y1(transient:stop);

%identification+validation
 u5Validation=u5(201:end); % 200 samples for validation
 y5Validation=y5(201:end);
 u1Validation=u1(201:end);
 y1Validation=y1(201:end);

 u5=u5(1:200);             % 200 samples for identification
 y5=y5(1:200);
 u1=u1(1:200);
 y1=y1(1:200);

%zero-mean values
u5m=u5-mean(u5);
y5m=y5-mean(y5);
u1m=u1-mean(u1);
y1m=y1-mean(y1);

%iddata
id5=iddata(y5m,u5m,Ts);
id1=iddata(y1m,u1m,Ts);

%prediction error method
S5=pem(id5,[0 2 0 0 1 1]); %B/F one pole and two zeros in model
S1=pem(id1,[0 2 0 0 1 1]);

%plots
compare(id5,S5)
compare(id1,S1)
bode(S5,S1)


