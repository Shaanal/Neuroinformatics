import scipy.io
import numpy as np
from scipy.stats import ttest_rel

data = scipy.io.loadmat('power.mat')
print(data.keys())

power_data = data['Power'] 
succ = power_data[0, :]
fail = power_data[1, :]

t_stat, p = ttest_rel(succ, fail)

print(f'Results:\n t = {t_stat:.4f}, p = {p:.4f}')

if p < 0.05:
    print("Significant difference between successful and unsuccessful conditions.")
else:
    print("No significant difference between successful and unsuccessful conditions.")

#Observations:
# We use a paired t-test because the measurements for "success" and "failure" conditions come from the same trials and are thus related,
# (i.e., paired observations), allowing us to compare the within-subject difference in spectral power.