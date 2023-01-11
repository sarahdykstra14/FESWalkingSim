function [t_ta] = tibialis_force(frequency, amplitude, pulse_width, tibialis_f0m)
%Input Parameters
%frequency: frequency of FES signal in Hz
%amplitude: amplitude of FES signal in V
%pulse_width: width of FES signal pulses in seconds

%Output
%torque produced by tibialis
    a = 2.014;
    b = 0.02107;
    c = -1.06;
    f0m = tibialis_f0m;
    rms_calc = amplitude*sqrt(frequency*pulse_width);
    beta = a/(1+exp(-b*frequency)) + c;
    rms_max = 0.7;
    rms_norm = rms_calc/rms_max;
    t_ta = beta*rms_norm*f0m;
end