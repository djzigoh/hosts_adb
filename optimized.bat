@echo off
setlocal enabledelayedexpansion

set "URL=https://a.dove.isdumb.one/list.txt"
set "GITHUB_USERNAME=djzigoh"
set "GITHUB_REPO_NAME=hosts_adb"
set "WORKING_DIR=c:\hosts_adb"

cd /d "%WORKING_DIR%"

set "MONTHS=03 04 05 06 07 08 09 10 11 12"

for %%M in (%MONTHS%) do (
    powershell -Command "Invoke-WebRequest -Uri '%URL%' -OutFile '%%M_2024_adb_block_with_login'"
)

powershell -Command "Invoke-WebRequest -Uri '%URL%' -OutFile '03_2024_adb_block'"

git add .
git commit -m "last" .
git push
