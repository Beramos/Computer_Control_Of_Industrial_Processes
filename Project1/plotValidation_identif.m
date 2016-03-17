clear all; clc; close all;

% Importing data
data=importdata('IDENTIFICATION_PRESSURE_Save_05.txt');
u=data(:,1);      % first column is PRBS input signal
y=data(:,2);      % second column is output signal
Ts=0.1;

% cutting data
 u=u(75:end-25);  % cutting transient response + end of experiment
 y=y(75:end-25);
 
 uValidation=u(200:end); % 200 samples for validation
 yValidation=y(200:end);

 u=u(1:200);             % 200 samples for identification
 y=y(1:200);
 
figure; % plot data
subplot(2,1,1); hold on;  plot((0:199)*Ts,u,'k'); plot((200:400)*Ts,uValidation,'r'); hold off;
xlabel('time (s)'); ylabel('input signal (V)')
subplot(2,1,2); hold on;  plot((0:199)*Ts,y,'k'); plot((200:400)*Ts,yValidation,'r'); hold off;
xlabel('time (s)'); ylabel('output signal (mbar)')