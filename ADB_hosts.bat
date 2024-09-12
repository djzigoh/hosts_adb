@echo off

set URL=https://a.dove.isdumb.one/list.txt
set OUTPUT_FILE=list.txt

REM powershell -Command "Invoke-WebRequest -Uri %URL% -OutFile %OUTPUT_FILE%"



set GITHUB_USERNAME=djzigoh
set GITHUB_REPO_NAME=hosts_adb
set OUTPUT_FILE=list.txt

REM powershell -Command "git init"
REM powershell -Command "git add ./*list.txt"
REM powershell -Command "git commit -m 'Initial commit'"
powershell -Command "git push"