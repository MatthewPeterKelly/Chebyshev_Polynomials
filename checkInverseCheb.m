function [err, f_grid, g_grid] = checkInverseCheb(g_knot, f_knot, f_domain, f_time)
% err = checkInverseCheb(g_knot, f_knot, f_domain, f_time)
%
% Let f(t) be some function of interest and g(f) be the inverse of f(t)
%
% INPUTS:
%   g_knot = value of g(f) at the chebyshev points
%   f_knot = value of f(t) at the chebyshev points
%   f_domain = domain for f(t)
%   f_time = vector of time samples for function fitting (must be on domain)
%
% OUTPUTS:
%   err = [1, nSample] = squared deviation from a true inverse
%       = (t - g(f(t))).^2
%   f_grid = chebyshev grid for f(t)
%   g_grid = chebyshev grid for g(t)
%

f_grid = chebyshevPoints(length(f_knot),f_domain);
g_domain = chebyshevInterpolate(f_knot,f_domain,f_domain);
g_grid = chebyshevPoints(length(g_knot),g_domain);

f_eval = chebyshevInterpolate(f_knot,f_time,f_domain);
g_eval = chebyshevInterpolate(g_knot,f_eval,g_domain);

err = (f_time - g_eval).^2;

end