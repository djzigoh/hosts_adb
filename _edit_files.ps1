# Pull settings from INI file ad define them as variables

$INI = Get-Content -Path 'settings.ini' | Select-Object -Skip 1
$directory = ($INI | Where-Object { $_.Trim() -match '^directory=' }) -replace '^directory=', ''
$temp_list = ($INI | Where-Object { $_.Trim() -match '^temp_list=' }) -replace '^temp_list=|$', ''

# Define your custom text (replace newline `r`n with your custom separator)
$customText = @"
########################################################
#####            ADOBE TELEMETRY BLOCK            ######
########################################################
# These IPs will only block the telemetry check of Adobe
# apps, and shouldn't interfere with any other network
# option, such as AI generation, downloads, etc.
"@

# Loop through all the .txt files in the directory
Get-ChildItem "$directory\$temp_list" | ForEach-Object {
    # Read the content of the file, skipping the first six lines
      $fileContent = Get-Content $_.FullName | Select-Object -Skip 6

    # Combine the custom text with the rest of the file content
    $newContent = $customText + "`r`n" + ($fileContent -join "`r`n")

    # Write the new content back to the file
    [System.IO.File]::WriteAllText($_.FullName, $newContent)
}