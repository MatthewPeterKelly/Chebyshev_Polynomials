% DEMO  --  Chebyshev Polynomial Interpolation
% UPDATED  --  January 14, 2017
% Written by Matthew Kelly, Cornell University
%
% This script demonstrates how use chebyshev polynomials to compute an a
% approximation of the inverse of a scalar monotonic function.
%

%% General Settings
clear; clc;

%%%%% PLAY WITH THIS SETTING %%%%
%
%What order should the approximation be?
order = 9; %Low = 5, Med = 9, high = 25;
%
%%%

%How many points to use when sampleing data from the test function?
nData = 20;

%What domain should we be looking at?
f_domain = [-1,1];

% Analytic solution for function (f) and inverse (g)
f_soln = @(x) ( exp(x) );
g_soln = @(y) ( log(y) );
g_domain = f_soln(f_domain);

% Compute knot points on solution:
input.userFunc = f_soln;
input.domain = f_domain;
[f_knot,~,~] = chebyshevFit(input, order);
input.userFunc = g_soln;
input.domain = g_domain;
[g_knot,~,~] = chebyshevFit(input, order);

% Interpolate solutions:
n_time = 100;
f_time = linspace(f_domain(1), f_domain(2), n_time);
f_val = chebyshevInterpolate(f_knot, f_time, f_domain);
g_time = linspace(g_domain(1), g_domain(2), n_time);
g_val = chebyshevInterpolate(g_knot, g_time, g_domain);

% Check the fitting error by functions:
err_fun = mean(checkInverseFunc(f_soln,g_soln,f_time));

% Check the fitting error by chebyshev knots:
[err_cheb, f_grid, g_grid] = checkInverseCheb(g_knot, f_knot, f_domain, f_time);

% Display error in analytic solution:
fprintf('Analytic MSE: %6.6e\n',err_fun);
fprintf('Chebyshev MSE: %6.6e\n',sum(err_cheb));

% Compute the solution numerically:
[err_fit, g_knot_fit, g_grid_fit] = chebyshevInverse(f_knot, f_domain, f_time);
g_val_fit = chebyshevInterpolate(g_knot_fit, g_time, g_grid_fit([1,end]));
fprintf('Cheb. Inv. Fit MSE: %6.6e\n',sum(err_fit));

% Plot the solution and fitting points:
figure(550); clf; hold on;
plot(f_time, f_val, 'r-','LineWidth',2);
plot(g_time, g_val, 'g-','LineWidth',2);
plot(g_time, g_val_fit, 'k--','LineWidth',3)
plot(f_grid, f_knot, 'ro');
plot(g_grid, g_knot, 'go');
plot(g_grid_fit, g_knot_fit, 'kx','MarkerSize',12)
axis('equal');
legend('f - function','g - analytic','g - best fit')
title('Chebyshev function approximation and inverse')
