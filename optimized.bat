@echo off
setlocal enabledelayedexpansion
set URL=https://a.dove.isdumb.one/list.txt
cd /d c:\hosts_adb
for %%i in (03,04,05,06,07,08,09,10,11,12) do (powershell -NoProfile -ExecutionPolicy Unrestricted -Command "Invoke-WebRequest -Uri '%URL%' -OutFile '%%i_2024_adb_block_with_login'"; -Command "&" './Remove-FirstSevenLines.ps1' '%%i_2024_adb_block_with_login'" || goto :error
)
powershell -Command "git add .; git commit -m 'Last update'; git push" || goto :error
goto :success
:error
echo An error occurred during script execution. Please check the logs for more details >> errors.log  :: Log error message to a file for later analysis if needed; use > instead of >> operator to overwrite existing log contents with each new error, or append using >> as shown here
exit /b %ERRORLEVEL%                   :: Exit script and return non-zero exit code indicating that an error occurred during execution. This allows calling scripts/programs to take appropriate action based on the failure (e.g., notifying users of failed job).
:success
echo Script executed successfully!      :: Display success message in console window for user feedback, if desired; otherwise remove this line entirely and keep it quiet by default during normal operation without unnecessary output cluttering up the screen unnecessarily