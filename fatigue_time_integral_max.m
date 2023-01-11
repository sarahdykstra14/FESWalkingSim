function [muscle_fatigue_max] = fatigue_time_integral_max(amplitude, frequency, pulse_width)
%Input Parameters
%T: time in seconds
%muscle force: force of muscle in N
%max force: maximum force of muscle

%Output
%fatigue time integral
tibialis_f0m = 2000;
time = 0.39; %fatigue at end of swing

tibialis_f = tibialis_force(frequency, amplitude, pulse_width, tibialis_f0m);
muscle_fatigue_max = fatigue_time_integral(time, tibialis_f, tibialis_f0m);
end

