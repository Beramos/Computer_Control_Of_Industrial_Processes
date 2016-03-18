function [S]=spectra(A,B,M)
% SPECTRA calculates the spectra


% Take out mean value
u=A-mean(A);
y=B-mean(B);

% calculate correlation using xcorr
R=xcorr(u,y,'unbiased');  

% Take middle part of correlation vector

R_cut=R(round(length(R)/2-M/2):round(length(R)/2+M/2),1);

% Window with Blackman function

window=blackman(length(R_cut));
R_w=transpose(R_cut.*window);

% Swapping

R_s=[R_w(M:end) R_w(1:M-1)];


% Calculate spectrum using Fast Fourier Transform

S=fft(R_s);

end