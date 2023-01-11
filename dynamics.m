function [x_dot] = dynamics(x, soleus, gastrocnemius, quadriceps, hamstrings, tibialis_force)

% Inputs
%  x: state vector (ankle angle, angular velocity, soleus normalized CE length, TA normalized CE length)
% soleus: soleus muscle (HillTypeModel)
% tibialis: tibialis anterior muscle (HillTypeModel)
% gastrocnemius: gastrocnemius muscle (HillTypeModel)
% quadriceps: quadriceps muscle (HillTypeModel)
% hamstrings: hamstrings muscle (HillTypeModel)

% Output
% x_dot: derivative of state vector

soleus_activation = 0;
gastrocnemius_activation = 0;
quadriceps_activation = 0.05;
hamstrings_activation = 0;
ankle_inertia = 0.0170;
%amplitude = 0.06;
%pulse_width = 0.0002;
%frequency = 20;
knee_inertia = 0.1167 + 0.0170 + 0.168;

soleus_f0m = 16000; %maximum isometric forces

gastrocnemius_f0m = 3000;
quadriceps_f0m = 3200;
hamstrings_f0m = 2000;

soleus_moment_arm = 0.05; %moment arms
tibialis_moment_arm = 0.03;
quadriceps_moment_arm = 0.04;
hamstrings_moment_arm = 0.025;
gastrocnemius_moment_arm_knee = 0.05;
gastrocnemius_moment_arm_ankle = 0.025;

%tibialis_f = tibialis_force(frequency, amplitude, pulse_width, tibialis_f0m);

x_dot1 = x(2); %derivative of theta (rotational velocity)
x_dot3 = x(4);

ankle = x(1);
knee = x(3);


soleus_tendon_length = soleus.norm_tendon_length(soleus_length(ankle), x(5)); %calculate length of soleus tendon
gastrocnemius_tendon_length = gastrocnemius.norm_tendon_length(gastrocnemius_length(ankle, knee), x(6));
quadriceps_tendon_length = quadriceps.norm_tendon_length(quadriceps_length(knee), x(7));
hamstrings_tendon_length = hamstrings.norm_tendon_length(hamstrings_length(knee), x(8));

ts = soleus_f0m*force_length_tendon(soleus_tendon_length)*soleus_moment_arm; %torque caused by soleus
tta = tibialis_force*tibialis_moment_arm; %torque caused by tibialis
tgc_a = gastrocnemius_f0m*force_length_tendon(gastrocnemius_tendon_length)*gastrocnemius_moment_arm_ankle;
tgc_k = gastrocnemius_f0m*force_length_tendon(gastrocnemius_tendon_length)*gastrocnemius_moment_arm_knee;
tq = quadriceps_f0m*force_length_tendon(quadriceps_tendon_length)*quadriceps_moment_arm;
th = hamstrings_f0m*force_length_tendon(hamstrings_tendon_length)*hamstrings_moment_arm;

x_dot2 = (ts + tgc_a - tta + gravity_moment_ankle(ankle, knee))/ankle_inertia; %total torque
x_dot4 = (tq - tgc_k - th + gravity_moment_knee(knee))/knee_inertia;

x_dot5 = get_velocity(soleus_activation, x(5), soleus_tendon_length); %normalized muscle velocities
x_dot6 = get_velocity(gastrocnemius_activation, x(6), gastrocnemius_tendon_length);
x_dot7 = get_velocity(quadriceps_activation, x(7), quadriceps_tendon_length);
x_dot8 = get_velocity(hamstrings_activation, x(8), hamstrings_tendon_length);

x_dot = [x_dot1; x_dot2; x_dot3; x_dot4; x_dot5; x_dot6; x_dot7; x_dot8]; %combine into column vector
end