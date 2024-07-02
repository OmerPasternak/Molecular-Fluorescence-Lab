%%
% Clear workspace, close all figures, and clear command window
clear;
close all;
clc;

% File path (replace with your actual file path)
filename = 'C:\Users\USER\OneDrive - mail.tau.ac.il\שנה ג סמסטר ב\מעבדה ג\פלורסנציה מולקולרית\מדידות\מדידות ריכוז.xls';

% Get sheet names
[~, sheets] = xlsfinfo(filename);

% Loop through sheets 1 to 10
for i = 21:30
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
    X = data{:, 1};  % First column
    Y = data{:, 2};  % Second column
    
    % Filter data within the range 480 to 744.5
    rangeFilter = (X >= 480) & (X <= 744.5);
    X_filtered = X(rangeFilter);
    Y_filtered = Y(rangeFilter);
    
    % Check if filtered data is non-empty
    if isempty(X_filtered) || isempty(Y_filtered)
        warning('No data in the specified range [480, 744.5] in sheet %s.', sheets{i});
        continue;
    end
    
    % Apply averaging over 10 points
    numPoints = length(X_filtered);
    averaged_X = zeros(1, ceil(numPoints/10));
    averaged_Y = zeros(1, ceil(numPoints/10));
    
    for j = 1:10:numPoints
        segment_X = X_filtered(j:min(j+9, numPoints));
        segment_Y = Y_filtered(j:min(j+9, numPoints));
        avg_X = mean(segment_X);
        avg_Y = mean(segment_Y);
        averaged_X(ceil(j/10)) = avg_X;
        averaged_Y(ceil(j/10)) = avg_Y;
    end
    
    % Remove trailing zeros from averaging (if any)
    averaged_X = nonzeros(averaged_X)';
    averaged_Y = nonzeros(averaged_Y)';
    
    % Apply LOWESS smoothing to averaged data
    smoothed_Y = smoothdata(averaged_Y, 'lowess',30);  % Smoothing span of 15%
    
    % Create a new figure for each sheet
    figure('Name', ['Averaged Data with LOWESS Smoothing for Sheet ', num2str(i)]);
    hold on;
    
    % Plot original averaged data
    plot(averaged_X, averaged_Y, 'o-', 'DisplayName', 'Averaged Data');
    
    % Plot smoothed data
    plot(averaged_X, smoothed_Y, '-', 'DisplayName', 'Smoothed Data');
    
    % Add labels and legend for the figure
    xlabel('Wavelength [nm]');
    ylabel('Intensity');
    title(['Sheet ', num2str(i), ' - Averaged Data with LOWESS Smoothing']);
    legend;
    
    hold off;
end


%%