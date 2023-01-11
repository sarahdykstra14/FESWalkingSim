function gc_l = gastrocnemius_length(ankle_angle,knee_angle)
% gastrocnemius_length 
%   calculates total length of gastrocnemius based on ankle and knee angles
% Input:
%  ankle_angle: angle between foot and shin in radians
%  knee_angle: angle between calf and hamstrings in radians
% Output:
%  gc_l: length of gastrocnemius in metres

theta_a = knee_angle-pi;
rotation1 = [cos(theta_a) -sin(theta_a); 
   sin(theta_a) cos(theta_a)];
origin1 = rotation1 * [0.03 0.05]';

origin2 = origin1 + [0 0.4]';

theta_b = pi/2-ankle_angle;
rotation2 = [cos(theta_b) -sin(theta_b);
    sin(theta_b) cos(theta_b)];
origin3 = rotation2*origin2;
insertion = [0.02 -0.05];
difference = origin3 - insertion;
gc_l = sqrt(difference(1)^2 + difference(2)^2);
end

