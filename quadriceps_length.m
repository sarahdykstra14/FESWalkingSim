function q_l = quadriceps_length(knee)
%Quadriceps length
%   Calculates length of quadriceps based on angle of knee
%Input
%  knee: angle between calf and hamstrings
%Output
%  q_l: length of quadriceps in m
theta = knee-pi;
rotation = [cos(theta) -sin(theta); 
   sin(theta) cos(theta)];

% coordinates in global reference frame
origin = rotation * [-0.05 0.4]';
insertion = [-0.03, -0.05]';

difference = origin - insertion;
q_l = sqrt(difference(1)^2 + difference(2)^2);
end

