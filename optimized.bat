@echo off
setlocal enabledelayedexpansion

set "URL=https://a.dove.isdumb.one/list.txt"
set "WORKING_DIR=c:\hosts_adb"
set "REPLACEMENT_LINE=#### BLOCK ADOBE GENUINE HOSTS WITH LOGIN ACCESS #####"
set "MONTHS=03 04 05 06 07 08 09 10 11 12"

powershell -ExecutionPolicy Bypass -File "process_files.ps1" -url "%URL%" -workingDir "%WORKING_DIR%" -replacementLine "%REPLACEMENT_LINE%" -months "%MONTHS%"

git add .
git commit -m "Updated files with new header"
git push
