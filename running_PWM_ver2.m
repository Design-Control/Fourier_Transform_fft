clear; clc; close all;

Ts = 0.00000005; %sampling time for the simulation
f_s = 1/Ts; %sampling frequency
T_end = 0.1; %ending time for the simulation 

sim("PWM.slx");

PWM = ans.simout;
PWM = gpuArray(PWM); %gpu사용으로 계산가속
%writematrix(PWM, 'PWM.txt');

[X_n, phase, freq, N, f_0, x_out, t] = Harmonics(PWM, f_s);

