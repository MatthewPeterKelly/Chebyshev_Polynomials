function err = checkInverseFunc(f,g,t)
% err = checkInverseFunc(f,g,t)
%
% Compute the error between a function and an approximation of its inverse.
%
% INPUTS:
%   f = x(t) = function of interest
%   g = t(x) = approximation of the function iverse
%   t = [1, nSample] = vector of test points on f
%
% OUTPUTS:
%   err = [1, nSample] = squared deviation from a true inverse
%       = (t - g(f(t))).^2
%

err = (t - g(f(t))).^2;

end