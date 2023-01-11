function [force_length_scale_factor] = force_length_muscle(lm)

% Input Parameters
% lm: muscle (contracile element) length

% Output
% force-length scale factor

global force_length_regression 
force_length_scale_factor = feval(force_length_regression, lm);
end