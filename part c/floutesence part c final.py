import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import minimize
from scipy import stats  # Import stats module for chi-square calculation

# Load data from Excel file
filename = r"C:\Users\USER\OneDrive - mail.tau.ac.il\שנה ג סמסטר ב\מעבדה ג\פלורסנציה מולקולרית\מדידות\E_UL updated for plotting.xlsx"
data = pd.read_excel(filename)

# Ensure correct column names
if 'kx_lp ' in data.columns and 'E_lp' in data.columns and 'deltaE_lp' in data.columns:
    k_lp = data['kx_lp '].values
    E_lp = data['E_lp'].values
    deltaE_lp = data['deltaE_lp'].values
else:
    print("Column names 'kx_lp ', 'E_lp ', or 'deltaE_lp ' not found in the Excel file. Please check the column names.")

# Define the function for ELP and residuals
def E_fun_lp(k, a1, a2, a3, a4, a5):
    return 1/2 * (a1 + a2 * np.sqrt((k - a3)**2 + a4**2) - np.sqrt(a5**2 + a1 - a2 * np.sqrt((k - a3)**2 + a4**2)))

def residuals(params, k, E, deltaE):
    a1, a2, a3, a4, a5 = params
    return (E - E_fun_lp(k, a1, a2, a3, a4, a5)) / deltaE

# Initial guesses for parameters [a1, a2, a3, a4, a5]
initial_guess_lp = [6.2, 0.128, -0.3, 19, 1.9]

# Define objective function: sum of squared residuals
def objective(params, k, E, deltaE):
    return np.sum(residuals(params, k, E, deltaE)**2)

# Perform optimization
result = minimize(objective, initial_guess_lp, args=(k_lp, E_lp, deltaE_lp), method='Nelder-Mead')

# Extract optimized parameters and calculate approximate covariance matrix
params_lp = result.x

# Numerically estimate the Jacobian matrix
eps = np.sqrt(np.finfo(float).eps)
J = np.zeros((len(k_lp), len(params_lp)))
for i in range(len(params_lp)):
    params_perturbed = params_lp.copy()
    params_perturbed[i] += eps
    residuals_perturbed = residuals(params_perturbed, k_lp, E_lp, deltaE_lp)
    J[:, i] = (residuals_perturbed - residuals(params_lp, k_lp, E_lp, deltaE_lp)) / eps

# Covariance matrix approximation
cov_matrix = np.linalg.inv(J.T @ J)

# Calculate errors (standard deviations) of the parameters in percent
param_errors_percent = 100 * np.sqrt(np.diag(cov_matrix)) / np.abs(params_lp)

# Calculate residuals
residuals = residuals(params_lp, k_lp, E_lp, deltaE_lp)

# Calculate chi-square
chi_sq = np.sum(residuals**2)

# Calculate degrees of freedom
n = len(E_lp)    # number of data points
p = len(params_lp)   # number of parameters
dof = max(0, n - p)  # degrees of freedom

# Calculate p-value
p_value = 1 - stats.chi2.cdf(chi_sq, dof)

# Display optimized parameters and their uncertainties for ELP
print("Optimized parameters for ELP:", params_lp)
print("Parameter errors (%):", param_errors_percent)
print("Chi-square:", chi_sq)
print("Degrees of freedom:", dof)
print("P-value:", p_value)

# Plot data and fit
plt.figure(figsize=(8, 12))

# Plotting data and fit
plt.subplot(2, 1, 1)
plt.errorbar(k_lp, E_lp, yerr=deltaE_lp, fmt='go', label='Data')
plt.plot(k_lp, E_fun_lp(k_lp, *params_lp), 'r-', label='Fit')
plt.xlabel('k[1/μm]')
plt.ylabel('E [eV]')
plt.legend()
plt.title('Nonlinear Fit of E vs k using scipy.optimize.minimize')

# Plot fit line (dashed)
plt.plot(k_lp, E_fun_lp(k_lp, *params_lp), 'r--')

# Plotting residuals in a new figure
plt.figure(figsize=(8, 6))
plt.errorbar(k_lp, residuals, yerr=deltaE_lp, fmt='bo', label='Residuals')
plt.axhline(y=0, color='r', linestyle='-', label='Zero Residual Line')
plt.xlabel('k[1/μm]')
plt.ylabel('y-y0 [eV]')
plt.legend()
plt.title('Residual Plot')

plt.tight_layout()
plt.show()
