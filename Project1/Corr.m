% Matlab-script for non-parametric identification using correlation
% functions

clear all; clc; close all;

% Importing data
data=importdata('IDENTIFICATION_PRESSURE_Save_05.txt');
u=data(:,1);      % first column is PRBS input signal
y=data(:,2);      % second column is output signal

% cutting data
% u=u(75:end-50);  % cutting out bad data
% y=y(75:end-50);

figure; % plot data
subplot(2,1,1); plot(u)
subplot(2,1,2); plot(y)

% Parameters

N=size(u,1);    % number of samples
Be=0.02;           % frequency resolution  (Hz)
M1=N;              % Sample interval length  M=N/p for p=1
M2=floor(N/4);     % Sample interval length for p=4 (integers) 

% Bodeplot

Suu_M1=spectra(u,u,M1);
Suy_M1=spectra(u,y,M1);

% initialisation of Suu and Suy + calculation of the first M-bin
Suu_M2=spectra(u(1:M2),u(1:M2),M2); 
Suy_M2=spectra(u(1:M2),y(1:M2),M2);

for i=2:4
sample_indices=1+(i-1)*M2:i*M2;
Suu_M2=Suu_M2+spectra(u(sample_indices),u(sample_indices),M2);  
Suy_M2=Suy_M2+spectra(u(sample_indices),y(sample_indices),M2);
end

Suu_M2=Suu_M2/4;                       % averaging of the spectra
Suy_M2=Suy_M2/4;                       % averaging of the spectra

Magnitude_M1=sqrt(real(Suy_M1).^2+imag(Suy_M1).^2)./abs(real(Suu_M1));
Phase_M1=360/(2*pi).*(atan(imag(Suy_M1)./real(Suy_M1)));
f_M1=2*pi*Be*linspace(0,N-1,length(Suu_M1));

Magnitude_M2=sqrt(real(Suy_M2).^2+imag(Suy_M2).^2)./abs(real(Suu_M2));
Phase_M2=360/(2*pi).*(atan(imag(Suy_M2)./real(Suy_M2)));
f_M2=2*pi*Be*linspace(0,N-1,length(Suu_M2));

figure;
subplot(2,1,1)
semilogx(f_M1,20*log10(Magnitude_M1),'b',f_M2,20*log10(Magnitude_M2),'r');
xlabel('Frequency (rad/s)')
ylabel('Magnitude (dB)')
legend('M=500','M=125')

subplot(2,1,2)
semilogx(f_M1,Phase_M1,'b',f_M2,Phase_M2,'r')
xlabel('Frequency (rad/s)')
ylabel('Phase (degrees)')
legend('M=500','M=125')

