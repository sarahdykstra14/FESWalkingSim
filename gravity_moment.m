function [moment] = gravity_moment(theta)

% Inputs
% theta: angle of body segment (up from prone)

% Output
% moment about ankle due to force of gravity on body

mass = 75; % body mass (kg; excluding feet)
centre_of_mass_distance = 1; % distance from ankle to body segment centre of mass (m)
g = 9.81; % acceleration of gravity
moment = mass * g * centre_of_mass_distance * sin(theta - pi/2);
end
