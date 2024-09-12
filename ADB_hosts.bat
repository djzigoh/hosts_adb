@echo off

set URL=https://a.dove.isdumb.one/list.txt
set OUTPUT_FILE=list.txt
cd c:\hosts_adb
powershell -Command "Invoke-WebRequest -Uri %URL% -OutFile 03_2024_adb_block"
powershell -Command "Invoke-WebRequest -Uri %URL% -OutFile 03_2024_adb_block_with_login"
powershell -Command "Invoke-WebRequest -Uri %URL% -OutFile 04_2024_adb_block_with_login"
powershell -Command "Invoke-WebRequest -Uri %URL% -OutFile 05_2024_adb_block_with_login"
powershell -Command "Invoke-WebRequest -Uri %URL% -OutFile 06_2024_adb_block_with_login"
powershell -Command "Invoke-WebRequest -Uri %URL% -OutFile 07_2024_adb_block_with_login"
powershell -Command "Invoke-WebRequest -Uri %URL% -OutFile 08_2024_adb_block_with_login"
powershell -Command "Invoke-WebRequest -Uri %URL% -OutFile 09_2024_adb_block_with_login"
powershell -Command "Invoke-WebRequest -Uri %URL% -OutFile 10_2024_adb_block_with_login"
powershell -Command "Invoke-WebRequest -Uri %URL% -OutFile 11_2024_adb_block_with_login"
powershell -Command "Invoke-WebRequest -Uri %URL% -OutFile 12_2024_adb_block_with_login"





set GITHUB_USERNAME=djzigoh
set GITHUB_REPO_NAME=hosts_adb
set OUTPUT_FILE=list.txt

REM powershell -Command "git init"
powershell -Command "git add ."
powershell -Command "git commit -m "last" ."
powershell -Command "git push"