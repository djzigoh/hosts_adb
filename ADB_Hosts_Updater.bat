@echo off
setlocal EnableDelayedExpansion

REM --- Read variables from settings.ini ---
for /f "usebackq tokens=1,2 delims==" %%a in ("settings.ini") do (
    if "%%a"=="URL"         set "URL=%%b"
    if "%%a"=="local_dir"   set "local_dir=%%b"
    if "%%a"=="temp_list"   set "temp_list=%%b"
    if "%%a"=="edit_script" set "edit_script=%%b"
    if "%%a"=="directory"   set "directory=%%b"
)

REM --- Configuration ---
set "ACTIVE_YEARS=2025 2026"
set "EXPIRED_YEARS=2024"

REM Specific month/year exclusions (space-separated tokens: MM_YYYY)
set "EXPIRED_MONTHS="
REM Example:
REM set "EXPIRED_MONTHS=01_2025 02_2025"

REM --- Workdir ---
cd /d "%local_dir%" || goto :error

REM --- Download and edit upstream list ---
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "Invoke-WebRequest -Uri '%URL%' -OutFile '%temp_list%'" || goto :error

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "& './%edit_script%'" || goto :error

REM --- Expire full years (overwrite all 12 months) ---
for %%y in (%EXPIRED_YEARS%) do (
  for %%m in (01 02 03 04 05 06 07 08 09 10 11 12) do (
    copy /Y "expired.txt" "%%m_%%y_adb_block_with_login" >nul
  )
)

REM --- Expire specific months (overwrite only listed tokens) ---
if defined EXPIRED_MONTHS (
  for %%e in (%EXPIRED_MONTHS%) do (
    copy /Y "expired.txt" "%%e_adb_block_with_login" >nul
  )
)

REM --- Generate active years, skipping expired months ---
for %%y in (%ACTIVE_YEARS%) do (
  for %%m in (01 02 03 04 05 06 07 08 09 10 11 12) do (

    set "SKIP=0"
    if defined EXPIRED_MONTHS (
      for %%e in (%EXPIRED_MONTHS%) do (
        if "%%e"=="%%m_%%y" set "SKIP=1"
      )
    )

    if "!SKIP!"=="0" (
      powershell -NoProfile -ExecutionPolicy Bypass -Command ^
        "Copy-Item -Path '%temp_list%' -Destination '%%m_%%y_adb_block_with_login' -Force" || goto :error
    )
  )
)

del "%temp_list%" >nul 2>&1

REM --- Git commit/push (same behavior as your original idea) ---
powershell -Command "git add .; git commit -m 'Updated files for 2025-2026'; git push" || goto :error

echo Script executed successfully!
exit /b 0

:error
echo An error occurred during script execution. Please check the logs for more details>> errors.log
exit /b 1
