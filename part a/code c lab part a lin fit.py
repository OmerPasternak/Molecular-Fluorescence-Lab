import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import linregress

# File path (replace with your actual file path)
filename = 'C:/Users/USER/OneDrive - mail.tau.ac.il/שנה ג סמסטר ב/מעבדה ג/matlab files/new_results_plot - Copy.xlsx'

# Read Excel file with multiple sheets
xls = pd.ExcelFile(filename)

# Initialize lists to store results
p_values = []
chi_squared_values = []

# Loop through each sheet in the Excel file
for sheet_name in xls.sheet_names:
    # Read data from the sheet
    data = pd.read_excel(filename, sheet_name=sheet_name)

    # Extract data columns
    Concentration = data['Concentration']
    Integral = data['Integral']
    Error = data['error']

    # Perform linear regression
    slope, intercept, r_value, p_value, std_err = linregress(Concentration, Integral)

    # Calculate chi-squared
    fitted_values = slope * Concentration + intercept
    residuals = Integral - fitted_values
    chi_squared = np.sum((residuals / Error) ** 2)

    # Append p-value and chi-squared to lists
    p_values.append(p_value)
    chi_squared_values.append(chi_squared)

    # Plot data with error bars
    plt.errorbar(Concentration, Integral, yerr=Error, fmt='o', label=f'{sheet_name} Data')

    # Plot linear fit line
    plt.plot(Concentration, fitted_values, '-', label=f'{sheet_name}')

    # Print fit information
    print(f'Sheet: {sheet_name}')
    print(f'  Linear Fit: y = {slope:.2f}x + {intercept:.2f}')
    print(f'  p-value: {p_value:.4f}, Chi-squared: {chi_squared:.4f}')
    print()

# Set labels
plt.xlabel('Concentration [mM]')
plt.ylabel('log(Normalised Intensity)')

# Adjust legend location outside the plot
plt.legend(loc='center left', bbox_to_anchor=(1, 0.5), fontsize='small')

# Show plot
plt.grid(True)
plt.tight_layout()  # Ensures all elements fit within the figure area
plt.show()

# Print overall results
print('Overall Results:')
for i, sheet_name in enumerate(xls.sheet_names):
    print(f'Sheet: {sheet_name}')
    print(f'  p-value: {p_values[i]:.4f}, Chi-squared: {chi_squared_values[i]:.4f}')
    print()
