clear; clc; close all;

x = readmatrix("Example.txt");
f_s = 1000;

[X_n, phase, freq, N, f_0, x_out, t] = Harmonics(x, f_s);