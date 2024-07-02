% Clear workspace, close all figures, and clear command window
clear;
close all;
clc;

% File path (replace with your actual file path)
filename = 'C:\Users\USER\OneDrive - mail.tau.ac.il\שנה ג סמסטר ב\מעבדה ג\פלורסנציה מולקולרית\מדידות\מדידות ריכוז.xls';

% Get sheet names
[~, sheets] = xlsfinfo(filename);

% Generate colors for the plots
colors = lines(3);

% Loop through the specified sheet groups and plot
for n = 1:10
    sheetsToPlot = [n, n+10, n+20];
    plotDataForSheets(sheetsToPlot, filename, colors);
end

% Function to plot data for given sheets
function plotDataForSheets(sheetsToPlot, filename, colors)
    [~, sheets] = xlsfinfo(filename); % Retrieve sheet names within the function
    
    % Create Figure 1 for Original Data
    figure('Name', ['Original Data for Sheets ', num2str(sheetsToPlot)]);
    hold on;
    
    % Loop through the specified sheets for Original Data
    for idx = 1:length(sheetsToPlot)
        sheetIdx = sheetsToPlot(idx);
        
        % Read data from the sheet
        data = readtable(filename, 'Sheet', sheets{sheetIdx});
        
        % Check if the table has at least two columns
        if width(data) < 2
            error('Sheet %s does not have at least two columns.', sheets{sheetIdx});
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
            warning('No data in the specified range [480, 744.5] in sheet %s.', sheets{sheetIdx});
            continue;
        end
        
        % Plot original data
        plot(X_filtered, Y_filtered, '-', 'DisplayName', sheets{sheetIdx}, 'Color', colors(idx, :));
    end
    
    % Add labels and legend for Figure 1
    xlabel('Wavelength [nm]');
    ylabel('Intensity');
    title(['Original Data for Sheets ', num2str(sheetsToPlot)]);
    legend('show');
    
    hold off;
    
    % Create Figure 2 for Averaged Data
    figure('Name', ['Averaged Data for Sheets ', num2str(sheetsToPlot)]);
    hold on;
    
    % Loop through the specified sheets for Averaged Data
    for idx = 1:length(sheetsToPlot)
        sheetIdx = sheetsToPlot(idx);
        
        % Read data from the sheet
        data = readtable(filename, 'Sheet', sheets{sheetIdx});
        
        % Check if the table has at least two columns
        if width(data) < 2
            error('Sheet %s does not have at least two columns.', sheets{sheetIdx});
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
            warning('No data in the specified range [480, 744.5] in sheet %s.', sheets{sheetIdx});
            continue;
        end
        
        % Average every 10 points
        numPoints = length(X_filtered);
        averaged_X = [];
        averaged_Y = [];
        
        for j = 1:10:numPoints-9
            segment_X = X_filtered(j:j+9);
            segment_Y = Y_filtered(j:j+9);
            avg_X = mean(segment_X);
            avg_Y = mean(segment_Y);
            averaged_X = [averaged_X; avg_X];
            averaged_Y = [averaged_Y; avg_Y];
        end
        
        % Plot averaged data
        plot(averaged_X, averaged_Y, '-', 'DisplayName', sheets{sheetIdx}, 'Color', colors(idx, :));
    end
    
    % Add labels and legend for Figure 2
    xlabel('Wavelength [nm]');
    ylabel('Intensity');
    title(['Averaged Data for Sheets ', num2str(sheetsToPlot)]);
    legend('show');
    
    hold off;
end

%%