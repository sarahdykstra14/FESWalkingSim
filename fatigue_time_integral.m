function [muscle_fatigue] = fatigue_time_integral(T,muscle_force, max_force)
%Input Parameters
%T: time in seconds
%muscle force: force of muscle in N
%max force: maximum force of muscle

%Output
%fatigue time integral
muscle_fatigue = (muscle_force * T) /max_force;
end

