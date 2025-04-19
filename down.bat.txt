@echo off
setlocal enabledelayedexpansion

:: Set the full path to steamcmd.exe
set steamcmd_path=C:\Users\CHRNFRD\GAMES\steamcmd\steamcmd.exe

:: Specify the download directory
set download_dir=C:/Users/CHRNFRD/OneDrive/Desktop/steam_mod_downloader/my_mods_folder

:: Specify AppID (for example, Project Zomboid: 108600)
set app_id=108600

:: Specify Mod IDs
set mod_id1=2823166698
set mod_id2=3457064550

:: Start SteamCMD and download mods
"%steamcmd_path%" +force_install_dir "%download_dir%" +login anonymous +workshop_download_item %app_id% %mod_id1%
"%steamcmd_path%" +workshop_download_item %app_id% %mod_id2%
"%steamcmd_path%" +quit
