% Matlab-script for non-parametric identification using correlation
% functions

% clear all;
clc; close all;

% Importing data
data=importdata('IDENTIFICATION_PRESSURE_Save_05.txt');
u=data(:,1);      % first column is PRBS input signal
y=data(:,2);      % second column is output signal

% cutting data
 u=u(75:end-25);  % cutting transient response + end of experiment
 y=y(75:end-25);
 
figure; % plot data
subplot(2,1,1); plot(u)
subplot(2,1,2); plot(y)

% Parameters
Ts=0.1;              % sampling time
N=size(u,1);    % number of samples
M1=N;              % Sample interval length  M=N/p for p=1
M2=floor(N/4);     % Sample interval length for p=4 (integers) 
Be1=1/M1/Ts;           % frequency resolution for p=1  (Hz)
Be2=1/M2/Ts;           % frequency resolution for p=4  (Hz)

% Bodeplot

Suu_M1=spectra(u,u,M1);
Suy_M1=spectra(u,y,M1);

Suu_M2=spectra(u,u,M2); 
Suy_M2=spectra(u,y,M2);

Magnitude_M1=sqrt(real(Suy_M1).^2+imag(Suy_M1).^2)./abs(real(Suu_M1));
Phase_M1=360/(2*pi).*unwrap(atan(imag(Suy_M1)./real(Suy_M1)));
f_M1=2*pi*Be1*linspace(0,M1-1,length(Suu_M1));

Magnitude_M2=sqrt(real(Suy_M2).^2+imag(Suy_M2).^2)./abs(real(Suu_M2));
Phase_M2=360/(2*pi).*unwrap(atan(imag(Suy_M2)./real(Suy_M2)));
f_M2=2*pi*Be2*linspace(0,M2-1,length(Suu_M2));

figure;
subplot(2,1,1)
semilogx(f_M1,20*log10(Magnitude_M1),'b',f_M2,20*log10(Magnitude_M2),'r');
xlabel('Frequency (rad/s)')
ylabel('Magnitude (dB)')
legend('M=400','M=100')

subplot(2,1,2)
semilogx(f_M1,Phase_M1,'b',f_M2,Phase_M2,'r')
xlabel('Frequency (rad/s)')
ylabel('Phase (degrees)')
legend('M=400','M=100')

