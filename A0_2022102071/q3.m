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

%% Adding noise
lent = length(t);
pn1 = p1 + 44*randn(1, lent);
pn2 = p2 + 45*randn(1, lent);
pn3 = p3 + 43*randn(1, lent);
pn4 = p4 + 48*randn(1, lent);

pn_avg = (pn1 + pn2 + pn3 + pn4)/4;

figure;
subplot(5, 1, 1);
plot(t, pn1);
grid on

subplot(5, 1, 2);
plot(t, pn2);
grid on

subplot(5, 1, 3);
plot(t, pn3);
grid on

subplot(5, 1, 4);
plot(t, pn4);
grid on

subplot(5, 1, 5);
plot(t, pn_avg);
grid on

% To Recover--------------------------- %
% from the plot we can deduce clearly that there is a 2Hz frequency, but
% the rest are not easily recognizable. Thus we'll be using fourier
% transform to recover all the frequencies.

N = length(pn_avg);
fp = fft(pn_avg);
p_freq = (0:N-1)*(n/N);
p_mag = abs(fp)/N;

figure;
plot(p_freq(1:N/2), p_mag(1:N/2)*2);
grid on
xlim([0 35]);

% We observe that for different amplitudes, either of the noise or the original signal, 
% the recovery of the frequencies changes. The higher the amplitude of the original frequeny signal
% the better it can be recognized. I have used 3 different levels of noise to portray this.
