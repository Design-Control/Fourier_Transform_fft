clear; clc; close all;
addpath('PWM_simulink\');

Ts = 0.000001; %sampling time for the simulation
fs = 1/Ts; %sampling frequency
T_end = 0.1; %ending time for the simulation 

sim("PWM.slx");

PWM = ans.simout;
writematrix(PWM, 'PWM.txt');

Harmonics(PWM, fs);

