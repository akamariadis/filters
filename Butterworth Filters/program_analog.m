% Analog Butterworth filters -> Magnitude, Phase, Group Delay and Pole - Zero Map

clear;
close all;
clc;

n = 4;
wc = 2*pi*1000;
w = logspace(1, 5, 2000);

[num_lp, den_lp] = butter(n, wc, 's');
H_lp = freqs(num_lp, den_lp, w);

[num_hp, den_hp] = butter(n, wc, 'high', 's');
H_hp = freqs(num_hp, den_hp, w);

w1 = 2*pi*500; 
w2 = 2*pi*2000;
[num_bp, den_bp] = butter(n, [w1 w2], 'bandpass', 's');
H_bp = freqs(num_bp, den_bp, w);

[num_bs, den_bs] = butter(n, [w1 w2], 'stop', 's');
H_bs = freqs(num_bs, den_bs, w);

figure('Name','Analog Butterworth Filters','Position',[100 100 1200 800]);

subplot(3,2,1);
semilogx(w/(2*pi), 20*log10(abs(H_lp)),'b','LineWidth',1.3); grid on;
title('Low-pass Magnitude Response');
xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)');

subplot(3,2,2);
semilogx(w/(2*pi), 20*log10(abs(H_hp)),'r','LineWidth',1.3); grid on;
title('High-pass Magnitude Response');
xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)');

subplot(3,2,3);
semilogx(w/(2*pi), 20*log10(abs(H_bp)),'g','LineWidth',1.3); grid on;
title('Band-pass Magnitude Response');
xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)');

subplot(3,2,4);
semilogx(w/(2*pi), 20*log10(abs(H_bs)),'m','LineWidth',1.3); grid on;
title('Band-stop Magnitude Response');
xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)');

subplot(3,2,[5 6]);
semilogx(w/(2*pi), unwrap(angle(H_lp))*180/pi,'b','LineWidth',1.2); hold on;
semilogx(w/(2*pi), unwrap(angle(H_hp))*180/pi,'r','LineWidth',1.2);
semilogx(w/(2*pi), unwrap(angle(H_bp))*180/pi,'g','LineWidth',1.2);
semilogx(w/(2*pi), unwrap(angle(H_bs))*180/pi,'m','LineWidth',1.2);
grid on;
title('Phase Response Comparison');
xlabel('Frequency (Hz)'); ylabel('Phase (degrees)');
legend('LPF','HPF','BPF','BSF','Location','best');

phi_lp = unwrap(angle(H_lp));    gd_lp = -diff(phi_lp)./diff(w);
phi_hp = unwrap(angle(H_hp));    gd_hp = -diff(phi_hp)./diff(w);
phi_bp = unwrap(angle(H_bp));    gd_bp = -diff(phi_bp)./diff(w);
phi_bs = unwrap(angle(H_bs));    gd_bs = -diff(phi_bs)./diff(w);

figure('Name','Group Delay (Analog Butterworth)','Position',[100 100 900 500]);
semilogx(w(1:end-1)/(2*pi), gd_lp,'b','LineWidth',1.3); hold on;
semilogx(w(1:end-1)/(2*pi), gd_hp,'r','LineWidth',1.3);
semilogx(w(1:end-1)/(2*pi), gd_bp,'g','LineWidth',1.3);
semilogx(w(1:end-1)/(2*pi), gd_bs,'m','LineWidth',1.3);
grid on;
title('Group Delay of Analog Butterworth Filters');
xlabel('Frequency (Hz)'); ylabel('Group Delay (s)');
legend('LPF','HPF','BPF','BSF','Location','best');

p = roots(den_lp);
z = roots(num_lp);

figure('Name','Pole–Zero Map (Analog Butterworth)','Position',[200 200 600 500]);
plot(real(p), imag(p), 'x', 'MarkerSize', 10, 'LineWidth', 1.8, 'Color', 'r'); hold on;
plot(real(z), imag(z), 'o', 'MarkerSize', 8, 'LineWidth', 1.8, 'Color', 'b');
grid on; axis equal;
xlabel('Real Axis'); ylabel('Imaginary Axis');
title('Pole–Zero Map: 4th-Order Analog Butterworth L
