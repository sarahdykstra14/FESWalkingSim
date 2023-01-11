%% Final Report Simulation
clear
clc
global force_length_regression force_velocity_regression
force_length_regression = get_muscle_force_length_regression();
force_velocity_regression = get_muscle_force_velocity_regression();

rest_length_soleus = soleus_length(pi/2);
rest_length_gastrocnemius = gastrocnemius_length(pi/2, pi);
rest_length_quadriceps = quadriceps_length(pi);
rest_length_hamstrings = hamstrings_length(pi);

tibialis_f0m = 2000;
pulse_width = 0.0002;


soleus = HillTypeMuscle(16000, 0.6*rest_length_soleus, 0.4*rest_length_soleus);
gastrocnemius = HillTypeMuscle(3000, 0.6*rest_length_gastrocnemius, 0.4*rest_length_gastrocnemius);
quadriceps = HillTypeMuscle(3200, 0.6*rest_length_quadriceps, 0.4*rest_length_quadriceps);
hamstrings = HillTypeMuscle(2000, 0.6*rest_length_hamstrings, 0.4*rest_length_hamstrings);

initialCondition = [13*pi/18, 0, 5*pi/6, 0, soleus_length(13*pi/18)/rest_length_soleus, gastrocnemius_length(13*pi/18, 5*pi/6)/rest_length_gastrocnemius, quadriceps_length(5*pi/6)/rest_length_quadriceps, hamstrings_length(5*pi/6)/rest_length_hamstrings];
tspan = [0 0.39];
options = odeset('RelTol', 1e-8, 'AbsTol', 1e-10);
frequency = linspace(10, 50, 30);
amplitude = linspace(0, 120, 30);
knee_height = (0.4*cos(pi-5*pi/6) + 0.2*sin(pi/2-5*pi/6+13*pi/18));
for m = 1:30
    for n = 1:30
        tibialis_f = tibialis_force(frequency(m), amplitude(n), pulse_width, tibialis_f0m);
        f = @(t, x) dynamics(x, soleus, gastrocnemius, quadriceps, hamstrings, tibialis_f);
        [time, y] = ode45(f, tspan, initialCondition, options);
        theta_1 = y(:,1);
        theta_2 = y(:,3);
        for i = 1:length(theta_1)
            height_front(i) = knee_height - (0.4*cos(pi-theta_2(i)) + 0.2*sin(pi/2-theta_2(i)+theta_1(i)));
            height_back(i) = knee_height - (0.4*cos(pi-theta_2(i)) + 0.05*sin(pi/2-theta_2(i)+theta_1(i)));
        end
        min_height_front = min(height_front);
        min_height_back = min(height_back);
        min_height(m,n) = min([min_height_front min_height_back]);
    end
end

LineWidth = 1.5;
FontSize = 12;
surface = mesh(frequency, amplitude, min_height);
minimum_height = 0;
Z = minimum_height.*ones(30, 30);
baseline = mesh(frequency,amplitude,Z);
zdiff = minimum_height - Z;
C = contours (frequency, amplitude, zdiff, [0 0]);
xL = C(1,2:end);
yL = C(2, 2:end);
zL = interp2(frequency, amplitude, min_height, xL, yL);
ylabel('Amplitude')
xlabel('Frequency')
zlabel('Minimum Height of Foot')
surf(frequency, amplitude, min_height); hold on
surf(frequency, amplitude, Z);
line(xL, yL, zL, 'Color', 'k', 'LineWidth', 3);