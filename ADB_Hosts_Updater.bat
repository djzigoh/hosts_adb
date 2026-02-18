@echo off
setlocal EnableExtensions EnableDelayedExpansion

REM --- Read variables from settings.ini ---
for /f "usebackq tokens=1,2 delims==" %%a in ("settings.ini") do (
    if "%%a"=="URL"         set "URL=%%b"
    if "%%a"=="local_dir"   set "local_dir=%%b"
    if "%%a"=="temp_list"   set "temp_list=%%b"
    if "%%a"=="edit_script" set "edit_script=%%b"
)

REM --- Config ---
set "ACTIVE_YEARS=2025 2026"
set "EXPIRED_YEARS=2024"

REM Specific month-year expirations (MM_YYYY tokens)
set "EXPIRED_MONTHS="
REM Example:
REM set "EXPIRED_MONTHS=01_2025 02_2025"

cd /d "%local_dir%" || goto :error

REM Download + edit in a single PowerShell process (faster than 2 calls)
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "Invoke-WebRequest -Uri '%URL%' -OutFile '%temp_list%'; & './%edit_script%'" || goto :error

REM 1) Generate all ACTIVE years (fast native copy)
for %%y in (%ACTIVE_YEARS%) do (
  for %%m in (01 02 03 04 05 06 07 08 09 10 11 12) do (
    copy /Y "%temp_list%" "%%m_%%y_adb_block_with_login" >nul
  )
)

REM 2) Expire full years (overwrite with expired.txt)
for %%y in (%EXPIRED_YEARS%) do (
  for %%m in (01 02 03 04 05 06 07 08 09 10 11 12) do (
    copy /Y "expired.txt" "%%m_%%y_adb_block_with_login" >nul
  )
)

REM 3) Expire specific months (overwrite with expired.txt)
if defined EXPIRED_MONTHS (
  for %%e in (%EXPIRED_MONTHS%) do (
    copy /Y "expired.txt" "%%e_adb_block_with_login" >nul
  )
)

del "%temp_list%" >nul 2>&1

REM Skip git commit/push if nothing changed (saves time)
set "CHANGED="
for /f %%G in ('git status --porcelain') do set "CHANGED=1"
if defined CHANGED (
  git add .
  git commit -m "Updated files for 2025-2026"
  git push || goto :error
) else (
  echo No changes to commit.
)

echo Script executed successfully!
exit /b 0

:error
echo An error occurred during script execution. Please check the logs for more details>> errors.log
exit /b 1
