% Digital Butterworth filter -> Magnitude, Phase, Group Delay, Pole - Zero Map

clear;
close all;
clc;

fs = 10000;
n = 4;
f = linspace(0, fs/2, 1024);

f_cut = 1000;
[b_lp, a_lp] = butter(n, f_cut/(fs/2), 'low');
H_lp = freqz(b_lp, a_lp, f, fs);

[b_hp, a_hp] = butter(n, f_cut/(fs/2), 'high');
H_hp = freqz(b_hp, a_hp, f, fs);

f1 = 500; f2 = 2000;
[b_bp, a_bp] = butter(n, [f1 f2]/(fs/2), 'bandpass');
H_bp = freqz(b_bp, a_bp, f, fs);

[b_bs, a_bs] = butter(n, [f1 f2]/(fs/2), 'stop');
H_bs = freqz(b_bs, a_bs, f, fs);

figure('Name','Digital Butterworth Filters','Position',[100 100 1200 800]);

subplot(3,2,1);
plot(f, 20*log10(abs(H_lp)),'b','LineWidth',1.3); grid on;
title('Low-pass Magnitude Response'); xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)');

subplot(3,2,2);
plot(f, 20*log10(abs(H_hp)),'r','LineWidth',1.3); grid on;
title('High-pass Magnitude Response'); xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)');

subplot(3,2,3);
plot(f, 20*log10(abs(H_bp)),'g','LineWidth',1.3); grid on;
title('Band-pass Magnitude Response'); xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)');

subplot(3,2,4);
plot(f, 20*log10(abs(H_bs)),'m','LineWidth',1.3); grid on;
title('Band-stop Magnitude Response'); xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)');

subplot(3,2,[5 6]);
plot(f, unwrap(angle(H_lp))*180/pi,'b','LineWidth',1.2); hold on;
plot(f, unwrap(angle(H_hp))*180/pi,'r','LineWidth',1.2);
plot(f, unwrap(angle(H_bp))*180/pi,'g','LineWidth',1.2);
plot(f, unwrap(angle(H_bs))*180/pi,'m','LineWidth',1.2);
grid on;
title('Phase Response Comparison'); xlabel('Frequency (Hz)'); ylabel('Phase (degrees)');
legend('LPF','HPF','BPF','BSF','Location','best');

phi_lp = unwrap(angle(H_lp)); gd_lp = -diff(phi_lp)./diff(2*pi*f);
phi_hp = unwrap(angle(H_hp)); gd_hp = -diff(phi_hp)./diff(2*pi*f);
phi_bp = unwrap(angle(H_bp)); gd_bp = -diff(phi_bp)./diff(2*pi*f);
phi_bs = unwrap(angle(H_bs)); gd_bs = -diff(phi_bs)./diff(2*pi*f);

figure('Name','Group Delay (Digital Butterworth)','Position',[100 100 900 500]);
plot(f(1:end-1), gd_lp,'b','LineWidth',1.3); hold on;
plot(f(1:end-1), gd_hp,'r','LineWidth',1.3);
plot(f(1:end-1), gd_bp,'g','LineWidth',1.3);
plot(f(1:end-1), gd_bs,'m','LineWidth',1.3);
grid on; title('Group Delay of Digital Butterworth Filters');
xlabel('Frequency (Hz)'); ylabel('Group Delay (s)');
legend('LPF','HPF','BPF','BSF','Location','best');

p_lp = roots(a_lp);
z_lp = roots(b_lp);

figure('Name','Pole-Zero Map (Digital Butterworth)','Position',[200 200 600 500]);
plot(real(z_lp), imag(z_lp), 'o', 'MarkerSize', 8, 'LineWidth', 1.8, 'Color', 'b'); hold on;
plot(real(p_lp), imag(p_lp), 'x', 'MarkerSize', 10, 'LineWidth', 1.8, 'Color', 'r');
grid on; axis equal;
xlabel('Real'); ylabel('Imag');
title('Pole-Zero Map: 4th-Order Digital Butterworth Low-pass Filter');
legend('Zeros','Poles','Location','best');
