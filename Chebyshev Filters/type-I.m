% Chebyshev Type I Low-Pass Filter Design
clear;
clc;
close all;

N  = 5;
Rp = 0.5;
Wp = 0.4;

[b, a] = cheby1(N, Rp, Wp, 'low');

[H, w] = freqz(b, a, 1024);

figure;
plot(w/pi, 20*log10(abs(H)), 'b', 'LineWidth', 1.5);
grid on;
xlabel('Normalized Frequency (\times \pi rad/sample)');
ylabel('Magnitude (dB)');
title(['Chebyshev Type I Low-pass Filter, N=' num2str(N)]);

figure;
zplane(b,a);
title('Pole-Zero Plot of Chebyshev Filter');

figure;
impz(b,a);
title('Impulse Response of Chebyshev Filter');
