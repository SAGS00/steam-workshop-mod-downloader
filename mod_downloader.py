import tkinter as tk
from tkinter import messagebox, filedialog
import subprocess
import os
import threading

# Function to handle the download process
def download_mods():
    app_id = app_id_entry.get()
    mod_ids = text_entry.get("1.0", "end-1c").splitlines()
    download_folder = folder_entry.get()  # Get the custom download folder from user input

    if not app_id:
        messagebox.showerror("Input Error", "Please enter the AppID.")
        return
    if not mod_ids:
        messagebox.showerror("Input Error", "Please enter at least one mod ID.")
        return
    if not download_folder:
        messagebox.showerror("Input Error", "Please enter a valid download folder.")
        return
    
    text_entry.delete("1.0","end-1c")
    download_button.config(state="disabled")
    
    # Ensure the folder exists, or create it
    if not os.path.exists(download_folder):
        os.makedirs(download_folder)

    # Get the current working directory (Python script folder)
    current_directory = os.getcwd()
    batch_file_path = os.path.join(current_directory, "download_mods.bat")

    # Path to your steamcmd.exe (replace this with the actual path where steamcmd is installed)
    steamcmd_path = r"..\.\steamcmd\steamcmd.exe"  # Modify this path accordingly

    # Debug: Print paths for verification
    print(f"Using SteamCMD path: {steamcmd_path}")
    print(f"Using download folder: {download_folder}")

    # Create the batch script (now in a one-liner format)
    batch_script = f'@echo off & setlocal enabledelayedexpansion & "{steamcmd_path}" +force_install_dir "{download_folder}" +login anonymous'

    for mod_id in mod_ids:
        batch_script += f' +workshop_download_item {app_id} {mod_id}'

    batch_script += f' +quit'

    # Write the batch file to the Python folder
    with open(batch_file_path, "w") as f:
        f.write(batch_script)

    # Debug: Print the batch file content for verification
    print("Batch File Content:\n", batch_script)

    # Start the download process in a separate thread
    threading.Thread(target=run_batch_file, args=(batch_file_path,)).start()

# Function to run the batch file in a separate thread
def run_batch_file(batch_file_path):
    try:
        # Explicitly run the batch file using cmd.exe
        # result = subprocess.run(["cmd.exe", "/c", batch_file_path], capture_output=True, text=True, check=True)
        # subprocess.Popen([batch_file_path], shell=True, creationflags=subprocess.CREATE_NEW_CONSOLE)
        # subprocess.Popen(f'cmd.exe /k "{batch_file_path}"', shell=True)
        # subprocess.call(f'cmd.exe /k "{batch_file_path}"', shell=True)
        # subprocess.Popen([r"cmd.exe", "/K", batch_file_path], shell=True)
        subprocess.Popen(f'cmd.exe /C start {batch_file_path}', shell=True)
        
        download_button.config(state="normal")
        
        # Print the standard output and error (if any)
        # print("Standard Output:", result.stdout)
        # print("Standard Error:", result.stderr)
        
        # If the process ran successfully, show the success message
        # messagebox.showinfo("Success", "Mods are being downloaded.")

        # Once the download is finished, enable the buttons and inputs

    except subprocess.CalledProcessError as e:
        # If there was an error, show the error message and print details
        # Once the download is finished, enable the buttons and inputs
        messagebox.showerror("Download Error", f"Error during download: {e}")
        print(f"Error Output: {e.stderr}")
        print(f"Return Code: {e.returncode}")

        # More detailed error info for debugging
        if e.stderr:
            print(f"Standard Error: {e.stderr}")
        if e.stdout:
            print(f"Standard Output: {e.stdout}")      

# Function to allow the user to browse and select a folder
def browse_folder():
    folder_selected = filedialog.askdirectory()  # Opens a folder selection dialog
    if folder_selected:  # If a folder is selected, set the folder entry to the selected path
        folder_entry.delete(0, tk.END)
        folder_entry.insert(0, folder_selected)

# Create the main window
root = tk.Tk()
root.title("Steam Workshop Mod Downloader")
root.geometry("450x600")


# Label for AppID
label_appid = tk.Label(root, text="Enter the AppID of the game:")
label_appid.pack(pady=10)

# Entry for AppID
app_id_entry = tk.Entry(root, width=40)
app_id_entry.pack(pady=5)

# Label for Mod IDs
label_modids = tk.Label(root, text="Enter Steam Workshop Mod IDs (one per line):")
label_modids.pack(pady=10)

# Text area for mod IDs
text_entry = tk.Text(root, height=10, width=40)
text_entry.pack(pady=10)

# Label for download folder
label_folder = tk.Label(root, text="Select the download folder:")
label_folder.pack(pady=10)

# Entry for download folder
folder_entry = tk.Entry(root, width=40)
folder_entry.pack(pady=5)

# Button to browse for folder
browse_button = tk.Button(root, text="Browse", command=browse_folder)
browse_button.pack(pady=5)

# Download button
download_button = tk.Button(root, text="Download Mods", command=download_mods)
download_button.pack(pady=20)

# Run the Tkinter event loop
root.mainloop()
