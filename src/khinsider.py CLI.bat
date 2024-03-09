@echo off

title khinsider.py CLI

:khinsiderCheck
if exist ".\khinsider.py" goto :MainMenu
cls & color 0c & echo.
set /p choice="khinsider.py not found! Download now? "
if /i "%choice%" equ "Y" goto :Download
if /i "%choice%" equ "N" goto :EoF
cls
echo You must enter 'y' or 'n' to proceed... & pause > nul
goto :khinsiderCheck

:Download
cls & color 0e & echo.
echo 1. Download khinsider.py
echo 2. Save to .\
start https://github.com/obskyr/khinsider
pause > nul
goto :khinsiderCheck

:MainMenu
cls & color 0f & echo.
set "MenuChoice="
echo Download .... 1
echo Search ...... 2
echo Setup ....... 3
echo Help ........ 4
echo.
set /p MenuChoice="Enter choice: "
if /i "%MenuChoice%" equ "1" goto :DownloadAlbum
if /i "%MenuChoice%" equ "2" goto :SearchKeyword
if /i "%MenuChoice%" equ "3" goto :SetupScript
if /i "%MenuChoice%" equ "4" goto :PrintHelp
cls & color 0c & echo.
echo You must enter an option to proceeed! & pause > nul
goto :MainMenu

:SetupScript
cls & color 0e & echo.
py ".\khinsider.py"
echo.
echo Setup completed. Press any key to return.
pause > nul
goto :MainMenu

:SearchKeyword
cls & color 0e & echo.
set "SearchKeyword="
echo (-m to retutn to main menu.)
set /p SearchKeyword="Search keyword(s): "
if /i "%SearchKeyword%" equ "-m" goto :MainMenu
if /i "%SearchKeyword%" neq "" goto :Search
cls & color 0c & echo.
echo You must enter a search term to proceeed! & pause > nul
goto :SearchKeyword

:Search
cls & color 0e & echo.
echo Searching for '%SearchKeyword%'...
echo.
".\khinsider.py" -s %SearchKeyword%>"%temp%\Search Results (%SearchKeyword%).txt"
start "" notepad "%temp%\Search Results (%SearchKeyword%).txt"
goto :MainMenu

:DownloadAlbum
cls & color 0e & echo.
set "AlbumID="
echo (-m to retutn to main menu.)
set /p AlbumID="Soundtrack URL or name: "
if /i "%AlbumID%" equ "-m" goto :MainMenu
if /i "%AlbumID%" neq "" goto :StartDownload
cls & color 0c & echo.
echo You must enter a URL or soundtrack ID to proceeed! & pause > nul
goto :DownloadAlbum

:StartDownload
cls & color 0a & echo.
del "%temp%\Search Results (%SearchKeyword%).txt" /s /q > nul 2>&1
echo Downloading %AlbumID%...
echo.
".\khinsider.py" -f flac,mp3 %AlbumID% "%userprofile%\Music\khinsider\%AlbumID%"
start "" explorer "%userprofile%\Music\khinsider\%AlbumID%"
goto :MainMenu

:PrintHelp
cls & color 0e & echo.
py ".\khinsider.py" -h>".\help.txt"
start "" notepad ".\help.txt"
goto :MainMenu
