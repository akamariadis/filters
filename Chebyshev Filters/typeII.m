% Chebyshev Type II Low-Pass Filter Design
clear; clc; close all;

N  = 5;
Rs = 40;
Wp = 0.4;

[b, a] = cheby2(N, Rs, Wp, 'low');

[H, w] = freqz(b, a, 1024);

figure;
plot(w/pi, 20*log10(abs(H)), 'b', 'LineWidth', 1.5);
grid on;
xlabel('Normalized Frequency (\times \pi rad/sample)');
ylabel('Magnitude (dB)');
title(['Chebyshev Type II Low-pass Filter, N=' num2str(N) ', Rs=' num2str(Rs) ' dB']);

figure;
zplane(b,a);
title('Pole-Zero Plot of Chebyshev Type II Filter');

figure;
impz(b,a);
title('Impulse Response of Chebyshev Type II Filter');
