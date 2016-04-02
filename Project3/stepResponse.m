% This script plots the step responses of the MIMO system to a [0;1] and
% [1;0] input step.

close all; clear all; clc;

simulationTime=800;

% [1;0] step response
u1_fin=1;
u2_fin=0;

sim('stepResponseModel')

figure; plot(t,y1,t,y2)
legend('y1','y2')
xlabel('time [s]')
ylabel('liquid height [cm]')

% [0;1] step response
u1_fin=0;
u2_fin=1;

sim('stepResponseModel')

figure; plot(t,y1,t,y2)
legend('y1','y2')
xlabel('time [s]')
ylabel('liquid height [cm]')