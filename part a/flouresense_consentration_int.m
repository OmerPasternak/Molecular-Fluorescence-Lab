% Clear workspace, close all figures, and clear command window
clear;
close all;
clc;

% File path (replace with your actual file path)
filename = 'C:\Users\USER\OneDrive - mail.tau.ac.il\שנה ג סמסטר ב\מעבדה ג\פלורסנציה מולקולרית\מדידות\מדידות ריכוז.xls';

% Get sheet names
[~, sheets] = xlsfinfo(filename);

% Initialize result array
integralValues = zeros(length(sheets), 1);

% Loop through each sheet
for i = 1:length(sheets)
    % Read data from the sheet
    data = readtable(filename, 'Sheet', sheets{i});
    
    % Display the headers of the table for debugging purposes
    disp(['Sheet: ', sheets{i}]);
    disp('Table Headers:');
    disp(data.Properties.VariableNames);
    
    % Check if the table has at least two columns
    if width(data) < 2
        error('Sheet %s does not have at least two columns.', sheets{i});
    end
    
    % Assume the first column is X and the second column is Y
    try
        X = data{:, 1};  % First column
        Y = data{:, 2};  % Second column
    catch
        error('Error accessing the columns in sheet %s. Check the column indices.', sheets{i});
    end
    
    % Filter data within the range 480 to 744.5
    rangeFilter = (X >= 480) & (X <= 744.5);
    X_filtered = X(rangeFilter);
    Y_filtered = Y(rangeFilter);
    
    % Check if filtered data is non-empty
    if isempty(X_filtered) || isempty(Y_filtered)
        warning('No data in the specified range [480, 744.5] in sheet %s.', sheets{i});
        integralValues(i) = NaN;  % Mark as NaN if no data is in the range
    else
        % Calculate the integral using the trapz function
        integralValues(i) = trapz(X_filtered, Y_filtered);
    end
end

% Display the results
disp('Integral results for each sheet:');
for i = 1:length(sheets)
    fprintf('Sheet %s: %f\n', sheets{i}, integralValues(i));
end

% Optionally, write the results to a new Excel file
resultTable = table(sheets', integralValues, 'VariableNames', {'Sheet', 'Integral'});
writetable(resultTable, 'integral_results.xlsx');

% Divide the integral results into three groups of 10 points each
if length(integralValues) >= 30
    % Assign group names and integral values
    RhodamineB_integrals = integralValues(1:10);
    Rhodamine6G_integrals = integralValues(11:20);
    Fluoresceine_integrals = integralValues(21:30);
    
    % X values for all the plots (specific values provided)
    X_values = [0.0001, 0.0004, 0.0008, 0.001, 0.0025, 0.005, 0.01, 0.025, 0.05, 0.1];
    
    % Create a single figure
    figure;
    
    % Plot Rhodamine B (Sheets 1-10)
    plot(X_values, log10(RhodamineB_integrals), 'o-', 'DisplayName', 'Rhodamine B');
    hold on;
    
    % Plot Rhodamine 6G (Sheets 11-20)
    plot(X_values, log10(Rhodamine6G_integrals), 's-', 'DisplayName', 'Rhodamine 6G)');
    
    % Plot Fluoresceine (Sheets 21-30)
    plot(X_values, log10(Fluoresceine_integrals), 'd-', 'DisplayName', 'Fluoresceine ');
    
    % Add labels
    xlabel('Concentration [mM]');
    ylabel('ln(Normalized Intensity)');
    
    % Set the X-axis scale to linear
    set(gca, 'XScale', 'linear');
    
    % Add legend
    legend;
    
    % Release hold
    hold off;
else
    error('There are not enough sheets to divide into three groups of 10.');
end
