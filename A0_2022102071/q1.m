load('power.mat');

succ = Power(:,1);
fail = Power(:,2);

d = succ - fail;
n = length(d);

mean_d = mean(d);
std_d = std(d);

t = mean_d/(std_d/sqrt(n));
df = n - 1;

p = 2*(1-tcdf(abs(t), df));
fprintf("t = %.4f, df = %d, p = %.4f\n", t, df, p);

if p < 0.05
    fprintf('Yes, difference found: p = %.4f\n', p);
else
    fprintf('No, difference found: p = %.4f\n', p);
end


