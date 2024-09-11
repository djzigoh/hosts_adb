@echo off

set URL=https://a.dove.isdumb.one/list.txt
set OUTPUT_FILE=list.txt

powershell -Command "Invoke-WebRequest -Uri %URL% -OutFile %OUTPUT_FILE%"



set GITHUB_USERNAME=djzigoh
set GITHUB_REPO_NAME=hosts_adb
set OUTPUT_FILE=list.txt

powershell -Command "git init"
powershell -Command "git add ./*list.txt"
powershell -Command "git commit -m 'Initial commit'"
