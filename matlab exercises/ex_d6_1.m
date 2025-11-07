% Exact inverted U kernel (parabola)
N = 51;                          % number of points in kernel (odd is best)
x = linspace(-1,1,N);            % normalized axis from -1 to 1
k_invertedU = 1 - x.^2;          % parabola opening downwards (∩ shape)
k_invertedU = k_invertedU / sum(k_invertedU);   % normalize

% Decay kernel (causal exponential)
M = 51;                          % number of points
tau = 10;                        % decay constant (adjust as needed)
n = 0:M-1;
k_decay = exp(-n/tau);
k_decay = k_decay / sum(k_decay);

% Plot
figure;
subplot(1,2,1);
plot(x, k_invertedU, 'LineWidth', 2);
title('Inverted U kernel (parabola ∩)');
grid on;

subplot(1,2,2);
plot(n, k_decay, 'LineWidth', 2);
title('Decay kernel (exponential)');
grid on;
