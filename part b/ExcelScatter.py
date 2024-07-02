import os
import pandas as pd
import matplotlib.pyplot as plt

# Load the Excel file
file_path = r"C:\Users\omerp\Documents\לימודים\שנה ג\מעבדה ג\פלורסנציה מולקולרית\טבלאות חלק ב.xlsx"  # Replace with your file path
xls = pd.ExcelFile(file_path)

# Define colors for each sheet
colors = ['blue', 'green', 'red']  # Adjust as needed based on the number of sheets

# Create a folder for saving images if it doesn't exist
target_folder = r"C:\Users\omerp\Documents\לימודים\שנה ג\מעבדה ג\פלורסנציה מולקולרית\תמונוץ\חלק ב גרפים סופי"  # Replace with your target folder name
os.makedirs(target_folder, exist_ok=True)

# Iterate through each sheet and plot separately
for i, sheet_name in enumerate(xls.sheet_names):
    # Load the sheet into a DataFrame
    df = pd.read_excel(file_path, sheet_name=sheet_name)

    # Extract Concentration and Slope columns
    x = df['Concentration']
    y = df['Slope']

    # Plot the data points
    plt.figure()  # Create a new figure for each sheet
    plt.scatter(x, y, label='Data', color=colors[i], s=20)  # Adjust 's' parameter for smaller or larger points

    # Customize plot
    plt.xlabel('Concentration [mM]')
    plt.ylabel('Fit Slope')
    plt.title(sheet_name)
    plt.grid(True)

    # Save plot as JPEG in the target folder
    file_name = os.path.join(target_folder, f'{sheet_name}.jpeg')
    plt.savefig(file_name, format='jpeg', dpi=300)

    # Close plot to free up memory
    plt.close()

print("Plots saved successfully.")
