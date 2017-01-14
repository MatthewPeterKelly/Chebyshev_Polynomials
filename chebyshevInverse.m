function [err, g_knot, g_grid] = chebyshevInverse(f_knot, f_domain, f_time)
% [err, g_knot, g_grid] = chebyshevInverse(f_knot, f_domain, f_time)
%
% Compute the chebyshev polynomial approximation of the inverse of f(t)
%
% INPUTS:
%  f_knot = value of the function of interest at the chebyshev points
%  f_domain = domain of the function of interest
%  f_time = vector of times to evaluate inverse fitting quality
%
% OUTPUTS:
%  err = error in the inverse at all points in f_time
%  g_knot = value of the inverse at all knot points
%  g_grid = chebyshev grid for the inverse
%

f_grid = chebyshevPoints(length(f_knot),f_domain);
g_domain = chebyshevInterpolate(f_knot,f_domain,f_domain);
  
f_eval = chebyshevInterpolate(f_knot,f_time,f_domain);

data.input = f_eval;
data.output = f_time;
g_guess = chebyshevFit(data, length(f_knot)-1);
  
objFun = @(gg)( sum(checkInverseCheb(gg, f_knot, f_domain, f_time)) );

g_knot = fminsearch(objFun,g_guess);
g_grid = chebyshevPoints(length(g_knot),g_domain);
err = checkInverseCheb(g_knot, f_knot, f_domain, f_time);

end