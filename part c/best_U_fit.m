%%
% Clear workspace, close all figures, and clear command window
clear;
close all;
clc;

% Read data from Excel file
filename = "C:\Users\USER\OneDrive - mail.tau.ac.il\שנה ג סמסטר ב\מעבדה ג\פלורסנציה מולקולרית\מדידות\data with errors E_UP updated.xlsx";
data = readtable(filename);

% Extract data columns
k = data.kx_up;
E = data.E_up;
k_err = data.deltak_u; % Assuming error column for k is named 'deltak_u'
E_err = data.deltaE_u; % Assuming error column for E is named 'deltaE_u'

% Define the function for E
E_fun_lsq = @(a, k) 1/2 * (a(1) + a(2) * sqrt((k - a(3)).^2 + a(4)^2) + sqrt(a(5)^2 + a(1) - a(2) * sqrt((k - a(3)).^2 + a(4)^2)));

% Initial guesses for parameters [a1, a2, a3, a4, a5]
a0_lsq = [1.3865, 0.128247, -0.2156, 19.03, 1.2969];

% Lower and upper bounds for parameters
lb_lsq = [-1, 0, -10, 0, 0];
ub_lsq = [14, 2, 10, 100, 10];

% Perform nonlinear least squares fitting using lsqnonlin
options_lsq = optimoptions('lsqnonlin', 'Algorithm', 'trust-region-reflective', 'Display', 'iter');
[a_opt_lsq, resnorm_lsq, residual_lsq, exitflag_lsq, output_lsq, ~, jacobian_lsq] = lsqnonlin(@(a) E_fun_lsq(a, k) - E, a0_lsq, lb_lsq, ub_lsq, options_lsq);

% Calculate the covariance matrix
cov_matrix_lsq = inv(jacobian_lsq' * jacobian_lsq) * resnorm_lsq / (length(E) - length(a0_lsq));
parameter_errors_lsq = sqrt(diag(cov_matrix_lsq));

% Calculate percentage uncertainties
parameter_errors_percentage_lsq = (parameter_errors_lsq ./ a_opt_lsq') * 100;

% Calculate chi-squared and p-value
chi_squared = sum((residual_lsq.^2) ./ (E_err.^2));
degrees_of_freedom = length(E) - length(a_opt_lsq);
p_value = 1 - gammainc(chi_squared / 2, degrees_of_freedom / 2);

% Display optimized parameters and their uncertainties
disp('Optimized parameters (lsqnonlin):');
disp(a_opt_lsq);
disp('Parameter uncertainties (absolute values) (lsqnonlin):');
disp(parameter_errors_lsq);
disp('Parameter uncertainties (percentage) (lsqnonlin):');
disp(parameter_errors_percentage_lsq);
disp('Residual norm (lsqnonlin):');
disp(resnorm_lsq);
disp('Chi-squared (lsqnonlin):');
disp(chi_squared);
disp('Degrees of freedom (lsqnonlin):');
disp(degrees_of_freedom);
disp('p-value (lsqnonlin):');
disp(p_value);

% Plot data with error bars and best fit
k_fit_lsq = linspace(min(k), max(k), 100);
E_fit_lsq = E_fun_lsq(a_opt_lsq, k_fit_lsq);

figure;
errorbar(k, E, E_err, 'bo', 'DisplayName', 'Data with Error Bars');
hold on;
plot(k_fit_lsq, E_fit_lsq, 'r-', 'DisplayName', 'Best Fit');
xlabel('k');
ylabel('E');
legend;
title('Nonlinear Fit of E vs k with Error Bars (lsqnonlin)');
hold off;

% Plot residuals
figure;
errorbar(k, residual_lsq, E_err, 'bo', 'DisplayName', 'Residuals with Error Bars');
xlabel('k');
ylabel('Residuals');
legend;
title('Residual Plot (lsqnonlin)');

% Calculate and display the p-value
disp('Chi-squared (lsqnonlin):');
disp(chi_squared);
disp('Degrees of freedom (lsqnonlin):');
disp(degrees_of_freedom);
disp('p-value (lsqnonlin):');
disp(p_value);

%%
%%
% Clear workspace, close all figures, and clear command window
clear;
close all;
clc;

% Read data from Excel file
filename = "C:\Users\USER\OneDrive - mail.tau.ac.il\שנה ג סמסטר ב\מעבדה ג\פלורסנציה מולקולרית\מדידות\data with errors E_UP updated.xlsx";
data = readtable(filename);

% Extract data columns
k = data.kx_up;
E = data.E_up;
k_err = data.deltak_u; % Assuming error column for k is named 'deltak_u'
E_err = data.deltaE_u; % Assuming error column for E is named 'deltaE_u'

% Define the function for E
E_fun_lsq = @(a, k) 1/2 * (a(1) + a(2) * sqrt((k - a(3)).^2 + a(4)^2) + sqrt(a(5)^2 + a(1) - a(2) * sqrt((k - a(3)).^2 + a(4)^2)));

% Initial guesses for parameters [a1, a2, a3, a4, a5]
a0_lsq = [1.3865, 0.128247, -0.2156, 19.03, 1.2969];

% Lower and upper bounds for parameters
lb_lsq = [-1, 0, -10, 0, 0];
ub_lsq = [14, 2, 10, 100, 10];

% Perform nonlinear least squares fitting using lsqnonlin
options_lsq = optimoptions('lsqnonlin', 'Algorithm', 'trust-region-reflective', 'Display', 'iter');
[a_opt_lsq, resnorm_lsq, residual_lsq, exitflag_lsq, output_lsq, ~, jacobian_lsq] = lsqnonlin(@(a) E_fun_lsq(a, k) - E, a0_lsq, lb_lsq, ub_lsq, options_lsq);

% Calculate the covariance matrix
cov_matrix_lsq = inv(jacobian_lsq' * jacobian_lsq) * resnorm_lsq / (length(E) - length(a0_lsq));
parameter_errors_lsq = sqrt(diag(cov_matrix_lsq));

% Calculate percentage uncertainties
parameter_errors_percentage_lsq = (parameter_errors_lsq ./ a_opt_lsq') * 100;

% Calculate chi-squared and p-value
chi_squared = sum((residual_lsq.^2) ./ (E_err.^2));
degrees_of_freedom = length(E) - length(a_opt_lsq);
p_value = 1 - gammainc(chi_squared / 2, degrees_of_freedom / 2);

% Display optimized parameters and their uncertainties
disp('Optimized parameters (lsqnonlin):');
disp(a_opt_lsq);
disp('Parameter uncertainties (absolute values) (lsqnonlin):');
disp(parameter_errors_lsq);
disp('Parameter uncertainties (percentage) (lsqnonlin):');
disp(parameter_errors_percentage_lsq);
disp('Residual norm (lsqnonlin):');
disp(resnorm_lsq);
disp('Chi-squared (lsqnonlin):');
disp(chi_squared);
disp('Degrees of freedom (lsqnonlin):');
disp(degrees_of_freedom);
disp('p-value (lsqnonlin):');
disp(p_value);

% Plot data with error bars and best fit
k_fit_lsq = linspace(min(k), max(k), 100);
E_fit_lsq = E_fun_lsq(a_opt_lsq, k_fit_lsq);

figure;
errorbar(k, E, E_err, 'bo', 'DisplayName', 'Data with Error Bars');
hold on;
plot(k_fit_lsq, E_fit_lsq, 'r-', 'DisplayName', 'Best Fit');
xlabel('k');
ylabel('E');
legend;
title('Nonlinear Fit of E vs k with Error Bars (lsqnonlin)');
hold off;

% Plot residuals
figure;
errorbar(k, residual_lsq, E_err, 'bo', 'DisplayName', 'Residuals with Error Bars');
xlabel('k');
ylabel('Residuals');
legend;
title('Residual Plot (lsqnonlin)');

% Calculate and display the p-value
disp('Chi-squared (lsqnonlin):');
disp(chi_squared);
disp('Degrees of freedom (lsqnonlin):');
disp(degrees_of_freedom);
disp('p-value (lsqnonlin):');
disp(p_value);

%%