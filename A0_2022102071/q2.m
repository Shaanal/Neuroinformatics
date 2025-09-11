n = 1000;
t = 0:1/n:4;

f1 = 2;
f2 = 8;
f3 = 12;
f4 = 25;

A1 = 25;
A2 = 12;
A3 = 8;
A4 = 2;

p1 = A1*sin(2*pi*f1*t - 2*pi/7);
p2 = A2*sin(2*pi*f2*t + 2*pi/3);
p3 = A3*sin(2*pi*f3*t - 2*pi/5);
p4 = A4*sin(2*pi*f4*t + 2*pi/3);

p_avg = (p1 + p2 + p3 + p4)/4;

figure;
subplot(5, 1, 1);
plot(t, p1);
grid on

subplot(5, 1, 2);
plot(t, p2);
grid on

subplot(5, 1, 3);
plot(t, p3);
grid on

subplot(5, 1, 4);
plot(t, p4);
grid on

subplot(5, 1, 5);
plot(t, p_avg);
grid on

% To Recover--------------------------- %
% from the plot we can deduce clearly that there is a 2Hz frequency, but
% the rest are not easily recognizable. Thus we'll be using fourier
% transform to recover all the frequencies.

N = length(p_avg);
fp = fft(p_avg);
p_freq = (0:N-1)*(n/N);
p_mag = abs(fp)/N;

figure;
plot(p_freq(1:N/2), p_mag(1:N/2)*2);
grid on
xlim([0 35]);
