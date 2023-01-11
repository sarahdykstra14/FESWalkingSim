function [gravity_moment_knee] = gravity_moment_knee(theta)
%gravity_moment_knee
%   Calculates moment about knee due to gravity
%Input: knee angle
%Output: moment about knee due to gravity
mass = 4.35; 
centre_of_mass_distance = 0.2; 
g = 9.81; 
gravity_moment_knee = mass * g * centre_of_mass_distance * cos(pi/2-theta);
end

