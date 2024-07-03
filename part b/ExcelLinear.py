import pandas as pd
import matplotlib.pyplot as plt
from scipy.stats import linregress
import os


# Function to plot and save the figure
def plot_and_save_figure(x, y, xlabel, ylabel, title, color, save_path, is_rhodamine_b):
    plt.figure()
    plt.scatter(x, y, color=color, label='_nolegend_')  # '_nolegend_' prevents legend entry

    # Perform linear regression
    slope, intercept, r_value, p_value, std_err = linregress(x, y)
    plt.plot(x, intercept + slope * x, color='black', linestyle='--', label=f'Linear Fit (Slope={slope:.4f})')

    plt.xlabel(xlabel)
    plt.ylabel(ylabel)
    plt.title(title)
    plt.grid(True)

    # Format x-axis tick labels without trailing zeros
    if is_rhodamine_b:
        plt.gca().xaxis.set_major_formatter(plt.FuncFormatter(lambda x, _: f'{x:.4f}'.rstrip('0').rstrip('.')))

    else:
        plt.gca().xaxis.set_major_formatter(plt.FuncFormatter(lambda x, _: f'{x:.3f}'.rstrip('0').rstrip('.')))

    # Save figure
    plt.savefig(save_path)
    plt.close()

    # Return coefficients
    return slope, intercept, r_value, p_value, std_err


# Function to process each sheet in the Excel file
def process_excel_file(file_path, target_folder):
    # Define color mappings and ranges
    color_map = {
        'fluorescein': 'green',
        'rhodamine b': 'blue',
        'rhodamine 6g': 'red'
    }
    range_map = {
        'fluorescein': (0.0005, 0.01),
        'rhodamine b': (0.0005, 0.0025),
        'rhodamine 6g': (0.0005, 0.005)
    }

    # Load Excel file
    xls = pd.ExcelFile(file_path)

    # Process each sheet
    for sheet_name in xls.sheet_names:
        df = pd.read_excel(file_path, sheet_name=sheet_name)

        # Extract relevant data
        concentration = df['Concentration']
        slope = df['Slope']

        # Determine color and range based on sheet name
        for key in color_map:
            if key.lower() in sheet_name.lower():
                color = color_map[key]
                data_range = range_map[key]
                break

        # Filter data within specified range
        mask = (concentration >= data_range[0]) & (concentration <= data_range[1])
        concentration = concentration[mask]
        slope = slope[mask]

        # Plot and save figure
        xlabel = 'Concentration [mM]'
        ylabel = 'Slope'
        title = sheet_name  # Use only sheet name as title
        save_path = os.path.join(target_folder, f'{sheet_name}_plot.png')

        # Determine if current plot is for rhodamine b
        is_rhodamine_b = 'rhodamine b' in sheet_name.lower()

        coefficients = plot_and_save_figure(concentration, slope, xlabel, ylabel, title, color, save_path,
                                            is_rhodamine_b)

        # Write coefficients to a text file
        coeffs_file = os.path.join(target_folder, 'coefficients.txt')
        with open(coeffs_file, 'a') as f:
            f.write(f'{sheet_name}\n')
            f.write(f'Slope: {coefficients[0]}\n')
            f.write(f'Intercept: {coefficients[1]}\n')
            f.write(f'R-squared: {coefficients[2] ** 2}\n\n')  # R-squared value

        print(f'Processed {sheet_name}')


# Example usage
if __name__ == "__main__":
    excel_file = r"C:\Users\omerp\Documents\לימודים\שנה ג\מעבדה ג\פלורסנציה מולקולרית\טבלאות חלק ב.xlsx"
    output_folder = r"C:\Users\omerp\Documents\לימודים\שנה ג\מעבדה ג\פלורסנציה מולקולרית\תמונוץ\חלק ב גרפים התאמה"

    if not os.path.exists(output_folder):
        os.makedirs(output_folder)

    process_excel_file(excel_file, output_folder)
