%%%% Advanced Topics in Macro 1
%%%% Assignment 1
%%%% Yingjie Huang (TI)
%%%% Version 1.0, Oct 29, 2021: First try on 1.(a)

clc;
clear;

%%%% Question 1
%% Preliminary: Parameters, Grid
dalpha = 0.1;      % Productivity of capital
dbeta = 0.1;       % Discount factor
depsilon = 0.0001; % Conergence criterion
dk0 = 0.5;        % Initial capital level
dkBar = (dalpha * dbeta)^(1 / (1 - dalpha)); % Steady state capital level

vkGrid = transpose(linspace(0.001, 1, 1000)); % Grid of 1000 k's from 0.001 to 1
vV = zeros(length(vkGrid), 1); % Assign initial value of zero to each k in the grid

mtxUMAT = fUtilityMatrix(dalpha, vkGrid);         % Create utility matrix
mtxV = repmat(transpose(vV), length(vkGrid), 1); % Initialise V matrix
derror = 1; % Initialise error

%% 1.(a) Brute-force grid search
while derror >= depsilon
    [vVnew, vIndex] = max(mtxUMAT + dbeta * mtxV, [], 2);
    derror = max(abs(vVnew - vV));
    vV = vVnew;
    mtxV = repmat(transpose(vVnew), length(vkGrid), 1);
end

vkSol = zeros(100, 1);
vkSol(1) = dk0;

for i = 2:100
    iOriginalIndex = find(vkGrid == vkSol(i - 1));
    iBestIndex = vIndex(iOriginalIndex);
    vkSol(i) = vkGrid(iBestIndex);
end

vkSolForward1 = [vkSol(2:end); vkSol(end)];
vcSol = vkSol.^dalpha - vkSolForward1;
vrSol = dalpha * vkSol.^(dalpha - 1);

%% 1.(b) Exploit monotonicity