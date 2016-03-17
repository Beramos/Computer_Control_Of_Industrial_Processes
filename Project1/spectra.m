function [S]=spectra(A,B,M)
% SPECTRA calculates the spectra


% Take out mean value
u=A-mean(A);
y=B-mean(B);

% calculate correlation using xcorr
R=xcorr(u,y,'unbiased');  

% Take middle part of correlation vector

R_cut=R(round(M/2):length(R)-round(M/2),1);

% Window with Blackman function

window=blackman(length(R_cut));
R_w=transpose(R_cut.*window);

% Swapping

l=length(R_w);
R_s=[R_w(M:end) R_w(1:M-1)];


% Calculate spectrum using Fast Fourier Transform

S=fft(R_s);

end