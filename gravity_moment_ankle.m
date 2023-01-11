function [gravity_moment_ankle] = gravity_moment_ankle(ankle,knee)
%gravity_moment_ankle
%   calculates moment about the ankle produced by gravity
%Inputs
%  ankle: angle between top of foot and shin
%  knee: angle between calf and hamstrings
%Output
% gravity_moment_ankle: moment about ankle due to gravity
shin_angle = pi/2 - knee;
foot_angle = shin_angle + ankle;
foot_mass = 1.05;
com_distance = 0.06;
g = 9.81;
gravity_moment_ankle = com_distance*g*foot_mass*cos(foot_angle);
end

