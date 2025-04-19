# Steam Workshop Mod Downloader

This is a Windows application that allows users to download Steam Workshop mods directly to their local machine using SteamCMD.

### Features
- Download Steam Workshop mods for any supported game.
- Simple graphical user interface built with `Tkinter`.
- Runs in the background while displaying progress via `cmd.exe`.

### Requirements
- **Windows OS**
- **SteamCMD**: Bundled with the project (no installation required)
- **No Python installation needed**: The application is packaged as a standalone `.exe`.

### Installation

1. **Download the repository**:
    - Clone this repository or download the ZIP file.

2. **Download the precompiled `.exe`**:
    If you don't want to compile the project yourself, you can simply download the precompiled `.exe` file from the [releases section](https://github.com/yourusername/SteamModDownloader/releases).

3. **SteamCMD**:
    - SteamCMD is bundled with the project. You do not need to install SteamCMD separately. It is located in the `steamcmd/` folder inside the project directory.

4. **Running the Application**:
    - Once you've downloaded the `.exe` file, simply run it to start the application.

    No need to install Python or any dependencies. The `.exe` is a standalone application.

### How to Use

1. Open the app.
2. Enter the **AppID** of the game you're downloading mods for.
3. Enter the **Mod IDs** (one per line) of the mods you wish to download.
4. Select a **download folder** where the mods will be saved.
5. Press the **Download Mods** button to start downloading the mods.

The application will use SteamCMD to download the mods, and you can track the progress in the command prompt.

### License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

### Acknowledgments
- [SteamCMD](https://developer.valvesoftware.com/wiki/SteamCMD)
- [Tkinter](https://wiki.python.org/moin/TkInter)

