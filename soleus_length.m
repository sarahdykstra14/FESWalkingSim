function [soleus_length] = soleus_length(ankle)

% Inputs
% theta: body angle (up from prone horizontal)

% Output
% soleus length

% define rotation matrix
theta = pi/2-ankle;
rotation = [cos(theta), -sin(theta); 
   sin(theta), cos(theta)];

% coordinates in global reference frame
origin = rotation * [0.03, 0.3]';
insertion = [0.02, -0.05]';

difference = origin - insertion;
soleus_length = sqrt(difference(1)^2 + difference(2)^2);

end
