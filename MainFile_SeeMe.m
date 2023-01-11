% Question 4
% Simple model of standing postural stability, consisting of foot and body segments,
% and two muscles that create moments about the ankles, tibialis anterior and soleus.
clear
clc

% Create the regression model for (1) Force Length and (2) Force Velocity
% Declaring models as global variables so they can be used within the scope
% of other functions
global force_length_regression force_velocity_regression
force_length_regression = get_muscle_force_length_regression();
force_velocity_regression = get_muscle_force_velocity_regression();

T = 0.39;
simulate(T);
