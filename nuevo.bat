@echo off

setlocal enabledelayedexpansion

REM The following section reads all variables from settings.ini
for /f "tokens=1,2,3,4,5,6 delims==" %%a in (settings.ini) do (
if %%a==URL set URL=%%b
if %%a==local_dir set local_dir=%%b
if %%a==temp_list set temp_list=%%b
if %%a==edit_script set edit_script=%%b
if %%a==directory set directory=%%b
if %%a==files set files=%%b

)

REM Switching to working folder.
cd /d %local_dir%

REM This section pulls the hosts blocking list from the web and create a copy for each month using a custom filename and a month number prefix.
powershell -NoProfile -ExecutionPolicy Unrestricted -Command "Invoke-WebRequest -Uri '%URL%' -OutFile '%temp_list%'"
for %%i in (01,02,03,04,05,06,07,08,09,10,11,12) do (
powershell -NoProfile -ExecutionPolicy Unrestricted -Command "Copy-Item -Path '%temp_list%' -Destination "'%%i_2024_adb_block_with_login'"
)
del %temp_list%


REM This section rewrite the header on all 12 files using a custom string for personalization.
powershell -NoProfile -ExecutionPolicy Unrestricted -Command "& './%edit_script%'" 


REM This section commit all files to a pre-configured GitHub repository.
powershell -Command "git add .; git commit -m 'Last update'; git push" || goto :error


REM This section handles success / error messages with logging if an error occurs .
goto :success
:error
echo An error occurred during script execution. Please check the logs for more details >> errors.log  
exit /b %ERRORLEVEL%                 
:success
echo Script executed successfully!