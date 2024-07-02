% Clear workspace, close all figures, and clear command window
clear;
close all;
clc;

% Define file paths
file_E_PU = "C:\Users\USER\OneDrive - mail.tau.ac.il\שנה ג סמסטר ב\מעבדה ג\פלורסנציה מולקולרית\מדידות\data with errors E_UP.xlsx";
file_E_PL = "C:\Users\USER\OneDrive - mail.tau.ac.il\שנה ג סמסטר ב\מעבדה ג\פלורסנציה מולקולרית\מדידות\E_UL updated for plotting.xlsx";

% Load data from Excel files
data_E_PU = readtable(file_E_PU);
data_E_PL = readtable(file_E_PL);

% Extract data from tables
k_E_PU = data_E_PU.kx_up;
E_PU = data_E_PU.E_up;
deltaE_PU = data_E_PU.deltaE_u;

k_E_PL = data_E_PL.kx_lp;
E_PL = data_E_PL.E_lp;
deltaE_PL = data_E_PL.deltaE_lp;

% Define fitting functions for E_PU and E_PL
E_fun_lp_PU = @(k, a1, a2, a3, a4, a5) 1/2 * (a1 + a2 * sqrt((k - a3).^2 + a4.^2) + sqrt(a5.^2 + a1 - a2 * sqrt((k - a3).^2 + a4.^2)));
E_fun_lp_PL = @(k, a1, a2, a3, a4, a5) 1/2 * (a1 + a2 * sqrt((k - a3).^2 + a4.^2) - sqrt(a5.^2 + a1 - a2 * sqrt((k - a3).^2 + a4.^2)));

% Define parameters for E_PU and E_PL
params_E_PU = [1.3882, 0.1281, -0.2093, 19.4430, 1.2931]; % Parameters for E_PU
params_E_PL = [6.35387849, 0.041216433, -0.3506335, 17.96524179, 1.4178938]; % Parameters for E_PL

% Plot E_PU and E_PL data and fits on the same axis
figure;
errorbar(k_E_PU, E_PU, deltaE_PU, 'Marker', 'o', 'MarkerSize', 5, 'MarkerEdgeColor', [0.5, 0.5, 0.5], 'MarkerFaceColor', [1,0, 0], 'LineStyle', 'none');
hold on;
errorbar(k_E_PL, E_PL, deltaE_PL, 'Marker', 'o', 'MarkerSize', 5, 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'c', 'LineStyle', 'none');
k_fit_PU = linspace(min(k_E_PU), max(k_E_PU), 100);
plot(k_fit_PU, E_fun_lp_PU(k_fit_PU, params_E_PU(1), params_E_PU(2), params_E_PU(3), params_E_PU(4), params_E_PU(5)), 'k-', 'LineWidth', 2);
k_fit_PL = linspace(min(k_E_PL), max(k_E_PL), 100);
plot(k_fit_PL, E_fun_lp_PL(k_fit_PL, params_E_PL(1), params_E_PL(2), params_E_PL(3), params_E_PL(4), params_E_PL(5)), 'b-', 'LineWidth', 2);
xlabel('k');
ylabel('E');
title('Comparison of E_PU and E_PL Data and Fits');
legend('E_PU Data with Error Bars', 'E_PL Data with Error Bars', 'E_PU Fit', 'E_PL Fit', 'Location', 'Best');
grid on;
hold off;

%%