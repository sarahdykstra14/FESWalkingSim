function h_l = hamstrings_length(knee)
%hamstrings_length
%   calculates length of hamstrings based on angle of knee
%Input
%  theta: angle between calf and hamstring
%Output:
%  h_l: length of hamstrings in metres
theta = knee-pi;
rotation = [cos(theta) -sin(theta); 
   sin(theta) cos(theta)];

% coordinates in global reference frame
origin = rotation * [0.05 0.4]';
insertion = [0.03, -0.05]';

difference = origin - insertion;
h_l = sqrt(difference(1)^2 + difference(2)^2);
end

