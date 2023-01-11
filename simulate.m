function [] = simulate(T)
% Runs a simulation of the model and plots results.

% Inputs
% T: total time to simulate, in seconds

rest_length_soleus = soleus_length(pi/2);
rest_length_gastrocnemius = gastrocnemius_length(pi/2, pi);
rest_length_quadriceps = quadriceps_length(pi);
rest_length_hamstrings = hamstrings_length(pi);

tibialis_f0m = 2000;
pulse_width = 0.0002;
frequency = 50;
amplitude = 2.177;
tibialis_f = tibialis_force(frequency, amplitude, pulse_width, tibialis_f0m);

soleus = HillTypeMuscle(16000, 0.6*rest_length_soleus, 0.4*rest_length_soleus);
gastrocnemius = HillTypeMuscle(3000, 0.6*rest_length_gastrocnemius, 0.4*rest_length_gastrocnemius);
quadriceps = HillTypeMuscle(3200, 0.6*rest_length_quadriceps, 0.4*rest_length_quadriceps);
hamstrings = HillTypeMuscle(2000, 0.6*rest_length_hamstrings, 0.4*rest_length_hamstrings);
f = @(t, x) dynamics(x, soleus, gastrocnemius, quadriceps, hamstrings, tibialis_f);

tspan = [0 T];
initialCondition = [13*pi/18, 0, 5*pi/6, 0, soleus_length(13*pi/18)/rest_length_soleus, gastrocnemius_length(13*pi/18, 5*pi/6)/rest_length_gastrocnemius, quadriceps_length(5*pi/6)/rest_length_quadriceps, hamstrings_length(5*pi/6)/rest_length_hamstrings];
options = odeset('RelTol', 1e-9, 'AbsTol', 1e-12);
[time, y] = ode45(f, tspan, initialCondition, options);

theta_1 = y(:,1);
theta_2 = y(:,3);
soleus_norm_length_muscle = y(:,5);
gastrocnemius_norm_length_muscle = y(:,6);
quadriceps_norm_length_muscle = y(:,7);
hamstrings_norm_length_muscle = y(:,8);

soleus_tension = zeros(size(y,1),1);
gastrocnemius_tension = zeros(size(y,1),1);
quadriceps_tension = zeros(size(y,1),1);
hamstrings_tension = zeros(size(y,1),1);
tibialis_tension = zeros(size(y,1),1);

soleus_moment = zeros(size(y,1),1);
gastrocnemius_moment_ankle = zeros(size(y,1),1);
gastrocnemius_moment_knee = zeros(size(y,1),1);
quadriceps_moment = zeros(size(y,1),1);
hamstrings_moment = zeros(size(y,1),1);
tibialis_moment = zeros(size(y,1),1);

height_front = zeros(size(y,1),1);
height_back = zeros(size(y,1), 1);
gravity_ankle = zeros(size(y,1),1);
gravity_knee = zeros(size(y,1),1);

knee_height = (0.4*cos(pi-5*pi/6) + 0.2*sin(pi/2-5*pi/6+13*pi/18));

for i = 1:size(y,1)
    soleus_tension(i) = soleus.get_force(soleus_length(theta_1(i)), soleus_norm_length_muscle(i));
    gastrocnemius_tension(i) = gastrocnemius.get_force(gastrocnemius_length(theta_1(i), theta_2(i)), gastrocnemius_norm_length_muscle(i));
    quadriceps_tension(i) = quadriceps.get_force(quadriceps_length(theta_2(i)), quadriceps_norm_length_muscle(i));
    hamstrings_tension(i) = hamstrings.get_force(hamstrings_length(theta_2(i)), hamstrings_norm_length_muscle(i));
    tibialis_tension(i) = tibialis_force(frequency, amplitude, 0.0002, 2000);
    
    soleus_moment(i) = soleus_tension(i)*0.05;
    gastrocnemius_moment_ankle(i) = gastrocnemius_tension(i)*0.025;
    gastrocnemius_moment_knee(i) = gastrocnemius_tension(i)*0.05;
    quadriceps_moment(i) = quadriceps_tension(i)*0.04;
    hamstrings_moment(i) = hamstrings_tension(i)*0.025;
    tibialis_moment(i) = tibialis_tension(i)*0.03;

    height_front(i) = knee_height - (0.4*cos(pi-theta_2(i)) + 0.2*sin(pi/2-theta_2(i)+theta_1(i)));
    height_back(i) = knee_height - (0.4*cos(pi-theta_2(i)) - 0.05*sin(pi/2-theta_2(i)+theta_1(i)));

    gravity_ankle(i) = gravity_moment_ankle(theta_1(i), theta_2(i));
    gravity_knee(i) = gravity_moment_knee(theta_2(i));
end

figure()
LineWidth = 1.5;
subplot(3,1,1)
plot(time, theta_1.*180./pi, 'LineWidth', LineWidth), hold on
plot(time, theta_2.*180./pi, 'LineWidth', LineWidth), hold off
legend('Ankle Angle', 'Knee Angle')
ylabel('Body Angles (deg)')

% subplot(4,1,2)
% plot(time, soleus_moment, 'r', 'LineWidth', LineWidth), hold on
% plot(time, tibialis_moment, 'g', 'LineWidth', LineWidth)
% plot(time, gastrocnemius_moment_ankle, 'b', 'LineWidth', LineWidth)
% plot(time, gastrocnemius_moment_knee, 'b--', 'LineWidth', LineWidth)
% plot(time, quadriceps_moment, 'm', 'LineWidth', LineWidth)
% plot(time, hamstrings_moment, 'y', 'LineWidth', LineWidth)
% plot(time, gravity_ankle, 'k', 'LineWidth', LineWidth)
% plot(time, gravity_knee, 'k--', 'LineWidth', LineWidth), hold off
% legend('Soleus', 'Tibialis', 'Gastrocnemius (ankle)', 'Gastrocnemius (knee)', 'Quadriceps', 'Hamstrings', 'Gravity (ankle)', 'Gravity (knee)', 'Location','northeast')
% xlabel('Time (s)')
% ylabel('Moment (Nm)')
%set(gca,'FontSize',6)

subplot(3,1,2)
plot(time, height_front, 'r', 'LineWidth', LineWidth), hold on
plot(time, height_back, 'b', 'LineWidth', LineWidth), hold off
xlabel('Time(s)')
ylabel('Foot height above ground(m)')
legend('Front of foot', 'Back of foot')
%set(gca, 'FontSize', 6)

subplot(3,1,3)
plot(time, soleus_norm_length_muscle, 'r', 'LineWidth', LineWidth), hold on
plot(time, gastrocnemius_norm_length_muscle, 'b', 'LineWidth', LineWidth)
plot(time, quadriceps_norm_length_muscle, 'g', 'LineWidth', LineWidth)
plot(time, hamstrings_norm_length_muscle, 'm', 'LineWidth', LineWidth), hold off
xlabel('Time(s)')
ylabel('Normalized Muscle Length')
legend('Soleus', 'Gastrocnemius', 'Quadriceps', 'Hamstrings')
end