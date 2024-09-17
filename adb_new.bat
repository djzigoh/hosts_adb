@echo off

set URL=https://a.dove.isdumb.one/list.txt
set GITHUB_USERNAME=djzigoh
set GITHUB_REPO_NAME=hosts_adb
setlocal enableDelayedExpansion
set today=%date%

cd c:\hosts_adb

for /l %%a in (1,1,12) do (
  if %%a lss 10 (powershell -Command "Invoke-WebRequest -Uri %URL% -OutFile "0%%a_2024_adb_block_with_login"") else powershell -Command "Invoke-WebRequest -Uri %URL% -OutFile "%%a_2024_adb_block_with_login""
)

powershell -Command "git add ."
powershell -Command "git commit -m "%date%" ."
powershell -Command "git push"