% Specify the folder containing .fig files
folder = "C:\Users\omerp\Documents\לימודים\שנה ג\מעבדה ג\פלורסנציה מולקולרית\תמונוץ\dummy";  % Replace with your folder path
outputFolder = "C:\Users\omerp\Documents\לימודים\שנה ג\מעבדה ג\פלורסנציה מולקולרית\תמונוץ";  % Replace with your desired output folder path

% Create the output folder if it doesn't exist
if ~exist(outputFolder, 'dir')
    mkdir(outputFolder);
end

% Get a list of all .fig files in the folder
figFiles = dir(fullfile(folder, '*.fig'));

% Iterate through each .fig file
for i = 1:numel(figFiles)
    % Load the figure
    figFileName = fullfile(folder, figFiles(i).name);
    hfig = openfig(figFileName);

    % Construct the output JPEG file name
    [~, baseFileName, ~] = fileparts(figFiles(i).name);
    jpegFileName = fullfile(outputFolder, [baseFileName, '.jpeg']);

    % Check if the JPEG file already exists in the output folder
    if isfile(jpegFileName)
        % Append a number to the filename to avoid overwriting
        count = 1;
        while true
            newBaseFileName = [baseFileName, '_', num2str(count)];
            newJpegFileName = fullfile(outputFolder, [newBaseFileName, '.jpeg']);
            if ~isfile(newJpegFileName)
                jpegFileName = newJpegFileName;
                break;
            end
            count = count + 1;
        end
    end

    % Save the figure as JPEG
    try
        saveas(hfig, jpegFileName, 'jpeg');
    catch ME
        % Display error message if saveas fails
        fprintf('Error saving %s: %s\n', jpegFileName, ME.message);
    end

    % Close the figure to avoid cluttering
    close(hfig);
end
