%%
% Path to your Excel file
file_path = 'C:\Users\USER\OneDrive - mail.tau.ac.il\שנה ג סמסטר ב\מעבדה ג\פלורסנציה מולקולרית\מדידות\מדידות חלק ג.ods';

% Directory to save the plots
save_dir = 'C:\Users\USER\OneDrive - mail.tau.ac.il\שנה ג סמסטר ב\מעבדה ג\פלורסנציה מולקולרית\גרפים\חלק ג ספקטרום';

% Ensure the save directory exists
if ~exist(save_dir, 'dir')
    mkdir(save_dir);
end

% Get sheet names
[~, sheets] = xlsfinfo(file_path);

% Loop through each sheet
for i = 1:numel(sheets)
    % Read data from sheet
    data = readtable(file_path, 'Sheet', sheets{i});
    
    % Assuming the first column is wavelength and the second is intensity
    lambda = data{:, 1};
    intensity = data{:, 2};
    
    % Plot data
    fig = figure('Name', sheets{i}, 'NumberTitle', 'off');
    plot(lambda, intensity);
    title(['Sheet: ', sheets{i}]);
    xlabel('Wavelength (nm)');
    ylabel('Normalized Intensity');
    
    % Save plot as .fig file
    save_path = fullfile(save_dir, [sheets{i}, '.fig']);
    savefig(fig, save_path);
end

disp('Plots saved successfully.');

%%