# Pull settings from INI file and define them as variables
$INI = Get-Content -Path 'settings.ini' | Select-Object -Skip 1
$directory = ($INI | Where-Object { $_.Trim() -match '^directory=' }) -replace '^directory=', ''
$temp_list = ($INI | Where-Object { $_.Trim() -match '^temp_list=' }) -replace '^temp_list=|$', ''

# Define your custom text
$customText = @"
########################################################
#####            ADOBE TELEMETRY BLOCK            ######
########################################################
# These IPs will only block the telemetry check of Adobe
# apps, and shouldn't interfere with any other network
# option, such as AI generation, downloads, etc.
"@

# Process the temp file
$filePath = Join-Path -Path $directory -ChildPath $temp_list
$fileContent = Get-Content $filePath | Select-Object -Skip 6
$newContent = $customText + "`r`n" + ($fileContent -join "`r`n")
[System.IO.File]::WriteAllText($filePath, $newContent)
