% This script determines the SVD of G
close all; clear all; clc;

G=[0.604 0.625; 0.596 0.620];  % G for s = 0.079 

[U,S,V] = svd(G);

% plotting the step response for the NMP input direction

simulationTime=250;

% [1;0] step response
u1_fin=U(1,2);
u2_fin=U(2,2);

sim('stepResponseModel')

figure; plot(t,y1,t,y2)
legend('y1','y2')
xlabel('time [s]')
ylabel('liquid height [cm]')


