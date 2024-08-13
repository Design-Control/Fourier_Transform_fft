clear; clc; close all;

x = readmatrix("Example.txt");
T = 1;

[X_n, phase, freg, N, f_0, x_out, t] = Harmonics(x, T);