clear
clc

ToDeg = 180/pi;
ToRad = pi/180;

%% model parameters
pa.J = diag([0.13,0.13,0.14]);

%% controller parameters
pa.k_gamma = 9.6;

%% initial state
pa.euler_init = [45;20;0]*ToRad;

%% desired state
pa.euler_r = [20;45;0]*ToRad;