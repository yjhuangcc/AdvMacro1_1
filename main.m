%%%% Advanced Topics in Macro 1
%%%% Assignment 1
%%%% Yingjie Huang (TI)
%%%% Version 1.0, Oct 29, 2021: First try on 1.(a)
%%%% Version 2.0, Oct 31, 2021: Change 1.(a); Now no use of matrices
%%%% Version 3.0, Oct 31, 2021: Complete 1.(b)

clc;
clear;

%%%% Question 1
%% Preliminary: Parameters, Grid
dalpha = 0.1;      % Productivity of capital
dbeta = 0.1;       % Discount factor
depsilon = 0.0001; % Conergence criterion
dk0 = 0.5;         % Initial capital level
dkBar = (dalpha * dbeta)^(1 / (1 - dalpha)); % Steady state capital level

vkGrid = transpose(linspace(0.001, 1, 1000)); % Grid of 1000 k's from 0.001 to 1
vV = zeros(length(vkGrid), 1); % Assign initial value of zero to each k in the grid

derror = 1; % Initialise error

%% 1.(a) Brute-force grid search
q1a;

%% 1.(b) Exploit monotonicity
q1b;

%% 1.(c) Exploit concavity
q1c;

%% 1.(d) Howard's policy iteration
q1d;