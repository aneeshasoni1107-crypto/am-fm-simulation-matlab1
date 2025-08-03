clc;
clear all;
close all;

%% Time settings
Fs = 10000;             % Sampling frequency
t = 0:1/Fs:0.05;        % Time vector

%% Signal settings
Am = 1;                 % Message amplitude
Ac = 1;                 % Carrier amplitude
fm = 100;               % Message frequency
fc = 1000;              % Carrier frequency
kf = 100;               % Frequency sensitivity (for FM)

%% Message signal
mt = Am * sin(2*pi*fm*t);         % Message signal

%% Carrier signal
ct = Ac * sin(2*pi*fc*t);         % Carrier signal

%% AM Modulation
AM = (1 + mt) .* ct;

%% FM Modulation
int_mt = cumsum(mt)/Fs;           % Integral of message signal
FM = Ac * cos(2*pi*fc*t + 2*pi*kf*int_mt);

%% Plotting Time Domain Signals
figure('Name','Time Domain Signals');

subplot(3,1,1);
plot(t, mt, 'b');
title('Message Signal (m(t))');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3,1,2);
plot(t, AM, 'r');
title('AM Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3,1,3);
plot(t, FM, 'g');
title('FM Signal');
xlabel('Time (s)');
ylabel('Amplitude');

%% Frequency Domain using FFT
n = length(t);
f = (-n/2:n/2-1)*(Fs/n);   % Frequency axis

AM_FFT = fftshift(abs(fft(AM)));
FM_FFT = fftshift(abs(fft(FM)));

figure('Name','Frequency Domain Signals');

subplot(2,1,1);
plot(f, AM_FFT);
title('AM Signal - Frequency Domain');
xlabel('Frequency (Hz)');
ylabel('|Amplitude|');

subplot(2,1,2);
plot(f, FM_FFT);
title('FM Signal - Frequency Domain');
xlabel('Frequency (Hz)');
ylabel('|Amplitude|');