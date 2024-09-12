@echo off

set URL=https://a.dove.isdumb.one/list.txt
set OUTPUT_FILE=list.txt
cd c:\hosts_adb
powershell -Command "Invoke-WebRequest -Uri %URL% -OutFile %OUTPUT_FILE%"



set GITHUB_USERNAME=djzigoh
set GITHUB_REPO_NAME=hosts_adb
set OUTPUT_FILE=list.txt

REM powershell -Command "git init"
powershell -Command "git add ."
powershell -Command "git commit -m "last" ."
powershell -Command "git push"