Part a:

spectrum_for_every_consentration
Reads data: It reads fluorescence data (wavelength and intensity) from an Excel spreadsheet.
Groups and Plots: It iterates through pre-defined sheet groups (potentially representing concentrations). For each group, it plots the original and averaged spectra from those sheets using different colors.
Filtering: It filters the data to focus on a specific wavelength range (480-744.5 nm) relevant to fluorescence analysis.
Averaging: For each sheet group's spectra, it calculates and plots the averaged data alongside the original data.

Smoothing:
Reads Data: It reads data (wavelength and intensity) from each sheet.
Averages: It calculates the average intensity over every 10 data points, potentially creating a smoother representation of the spectrum.
Smoothing: It applies a LOWESS smoothing technique to the averaged data. LOWESS stands for Locally Weighted Scatterplot Smoothing, which helps reduce noise and improve the overall trend in the data.
Visualization: It creates separate figures for each sheet, plotting both the original averaged data and the smoothed data. This allows visual comparison of the smoothing effect.


code c lab part a lin fit (python)
Reads Excel File: It reads the Excel file
Loop and Extract Data: extracts the concentration, integral intensity, and error data columns for each sheet.
Performs Linear Regression: It uses linregress from scipy.stats to calculate the slope, intercept, R-value, p-value, and standard error for the linear fit between concentration and integral intensity.
Calculates Chi-Squared: It calculates the chi-squared statistic to assess the goodness-of-fit of the linear model.
Plots Data and Fit: It creates a scatter plot with error bars for the data points and overlays the linear fit line for each sheet.

The code was used with different data sets to create different fits

flouresense_consentration_int
Load and Prepare Data:
Reads data from each sheet, focusing on a specific wavelength range.
Calculates the integral of the fluorescence intensity curve (intensity vs wavelength) for each sample sheet. This integral, essentially the area under the curve, represents the total amount of fluorescence emitted by that sample across the analyzed wavelengths.
Calculates the logarithm of integral values for each group (each fluorophore).
Visualizes these log-transformed integrals to compare fluorescence intensity trends between different fluorophore groups
Part a:

Fluorescence
This code takes a picture, gives it a color scale, and then after a range was chosen fit a linear fit to the log of the magnitude over the range.
figToJpeg
This code converts .fig files from a specified folder to .jpeg files and puts them in a designate folder.

Part c:

part_C_plotting_and_saving
This code reads fluorescence spectra (wavelength vs intensity) from each sheet in an OpenDocument Spreadsheet (.ods) file. It creates separate plots for each sheet and saves them as .fig files in a designated folder.


floutesence part c final (python)
This was used to fit the E_pl data 
This code analyzes data from an Excel file to fit a model to a relationship between wavenumber (k) and energy (E). It uses scipy.optimize.minimize to find the best-fit parameters for the model function. The code then calculates uncertainties in the fit parameters and the chi-square value to assess the goodness of fit. Finally, it visualizes the data, fit, and residuals.


best_U_fit
This code fits a model to a relationship between wavenumber (k) and energy (E) using data with error bars. It employs lsqnonlin from MATLAB's optimization toolbox. This function minimizes the sum of squared residuals between the model and the data points. The code considers uncertainties in the data by incorporating them into the fitting process. It calculates the chi-square value and p-value to assess the goodness of fit and the statistical significance of the fit parameters. Finally, it visualizes the data, fit, and residuals.

print_Elp_and_Eup
Create a visual representation of the data alongside the corresponding fit curves, using the optimized parameters obtained from previous analysis section
