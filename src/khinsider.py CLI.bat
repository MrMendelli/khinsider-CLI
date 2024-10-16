@echo off

title khinsider.py CLI

:khinsiderCheck
if exist ".\khinsider.py" goto :MainMenu
cls & color 0c & echo.
set /p choice="khinsider.py not found! Download now? "
if /i "%choice%" equ "Y" goto :Download
if /i "%choice%" equ "N" exit/b
cls
echo You must enter 'y' or 'n' to proceed... & pause > nul
goto :khinsiderCheck

:Download
cls & color 0e & echo.
echo Download and extract khinsider.py contents to the same directory as this script.
start /wait https://github.com/obskyr/khinsider
pause
goto :khinsiderCheck

:MainMenu
set "MenuChoice="
cls & color 6f & mode con cols=58 lines=13
echo     __________________________________________________
echo    /                                                  \
echo    ^|                     Main Menu                    ^|
echo    ^|--------------------------------------------------^|
echo    ^| Download ..................................... 1 ^|
echo    ^| Search ....................................... 2 ^|
echo    ^| Setup ........................................ 3 ^|
echo    ^| Run .......................................... 4 ^|
echo    ^| Help ......................................... 5 ^|
echo    \__________________________________________________/
echo.
set /p "MenuChoice=Enter option: "
if /i "%MenuChoice%" equ "1" goto :DownloadAlbum
if /i "%MenuChoice%" equ "2" goto :SearchKeyword
if /i "%MenuChoice%" equ "3" goto :SetupScript
if /i "%MenuChoice%" equ "4" goto :RunProgram
if /i "%MenuChoice%" equ "5" goto :PrintHelp
cls & color 0c & echo.
echo You must enter an option to proceeed! & pause > nul
goto :MainMenu

:DownloadAlbum
cls & color 0e
set "AlbumID="
echo ^*Enter -r to return to previous menu.
echo.
set /p AlbumID="Soundtrack URL or name: "
if /i "%AlbumID%" equ "-r" goto :MainMenu
if /i "%AlbumID%" neq "" goto :StartDownload
cls & color 0c & echo.
echo You must enter a URL or soundtrack ID to proceeed! & pause > nul
goto :DownloadAlbum

:StartDownload
cls & color 0a & mode con cols=140 lines=30 & echo.
del "%temp%\khinsider Search.txt" /s /q > nul 2>&1
echo Downloading %AlbumID%...
echo.
".\khinsider.py" -f flac,mp3 %AlbumID% "%userprofile%\Music\khinsider\%AlbumID%"
if %errorlevel% equ 0 (cls & echo Downloading completed. & pause > nul & start "" explorer "%userprofile%\Music\khinsider\%AlbumID%") else (echo. & pause)
goto :MainMenu

:SearchKeyword
cls & color 0e & mode con cols=58 lines=5 & echo.
set "SearchTerm="
echo ^*Enter -r to return to previous menu.
echo.
set /p SearchTerm="Search term: "
if /i "%SearchTerm%" equ "-r" goto :MainMenu
if /i "%SearchTerm%" neq "" goto :Search
cls & color 0c & echo.
echo You must enter a search term to proceeed! & pause > nul
goto :SearchKeyword

:Search
cls & color 0e & mode con cols=140 lines=30 & echo.
echo Searching for %SearchTerm%...
echo.
".\khinsider.py" -s %SearchTerm%>"%temp%\khinsider Search.txt"
if %errorlevel% equ 0 (start "" notepad "%temp%\khinsider Search.txt") else (echo. & pause)
goto :MainMenu

:SetupScript
cls & color 0e & echo.
echo Running setup...
echo.
py ".\khinsider.py"
echo.
color 0a
echo Setup completed. Press any key to return.
pause > nul
goto :MainMenu

:RunProgram
cls
start "" cmd /k
goto :MainMenu

:PrintHelp
cls & color 0e & echo.
echo Printing help...
echo.
py ".\khinsider.py" -h>".\help.txt"
if %errorlevel% equ 0 (start "" notepad "help.txt") else (echo. & pause)
goto :MainMenu
