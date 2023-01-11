frequency = linspace(10,50,200);
amplitude = 98414.*(frequency.^-2.74);
peak_muscle_fatigues = zeros(length(frequency));
pulse_width = 0.0002;
for n = 1:length(frequency)
    peak_muscle_fatigues(n) = fatigue_time_integral_max(amplitude(n), frequency(n), pulse_width);
end

plot3(frequency, amplitude, peak_muscle_fatigues), hold on
plot3(frequency(200), amplitude(200), peak_muscle_fatigues(200), '-o')