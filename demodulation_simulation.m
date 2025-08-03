clc;
clear all;
close all;

%% Time settings
Fs = 10000;
t = 0:1/Fs:0.05;

%% Signal settings
Am = 1;
Ac = 1;
fm = 100;
fc = 1000;
kf = 100;

%% Message and Carrier
mt = Am * sin(2*pi*fm*t);
ct = Ac * sin(2*pi*fc*t);

%% AM Modulation
AM = (1 + mt) .* ct;

%% FM Modulation
int_mt = cumsum(mt)/Fs;
FM = Ac * cos(2*pi*fc*t + 2*pi*kf*int_mt);

%% ------------------ AM DEMODULATION ------------------
% Envelope detection using absolute value + LPF
AM_env = abs(AM);
[b, a] = butter(5, 2*fm/Fs);  % Butterworth low-pass filter
AM_demod = filter(b, a, AM_env);

%% ------------------ FM DEMODULATION ------------------
% FM demod by differentiating the phase
FM_phase = unwrap(angle(hilbert(FM)));   % Get phase of FM signal
FM_diff = diff(FM_phase);                % Differentiate phase
FM_demod = [FM_diff, FM_diff(end)];      % Pad one sample to match length
FM_demod = FM_demod / (2*pi*kf);         % Scale back to message amplitude

%% ------------------ Plot Results ------------------

figure('Name','Demodulated Signals');

subplot(3,1,1);
plot(t, mt, 'b');
title('Original Message Signal');
xlabel('Time (s)'); ylabel('Amplitude');

subplot(3,1,2);
plot(t, AM_demod, 'r');
title('AM Demodulated Signal');
xlabel('Time (s)'); ylabel('Amplitude');

subplot(3,1,3);
plot(t, FM_demod, 'g');
title('FM Demodulated Signal');
xlabel('Time (s)'); ylabel('Amplitude');





















































































































































































































































