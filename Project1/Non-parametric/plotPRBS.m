% plot PRBS

clc; clear all; close all;

u5=importdata('PRBS_05.txt');
u1=importdata('PRBS_01.txt');

figure; plot(0.1:0.1:50,u5);
ylim([6 8])
ylabel('Voltage (V)')
xlabel('time (s)')

figure; plot(0.1:0.1:50,u1);
ylim([6 8])
ylabel('Voltage (V)')
xlabel('Time (s)')