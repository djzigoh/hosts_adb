param (
    [string]$url,
    [string]$workingDir,
    [string]$replacementLine,
    [string]$months
)

$monthsArray = $months -split ' '

foreach ($month in $monthsArray) {
    $filename = "$month_2024_adb_block_with_login.txt"
    Invoke-WebRequest -Uri $url -OutFile "$workingDir\$filename"

    $content = Get-Content "$workingDir\$filename" -Raw
    $lines = $content -split '[\r\n]+'
    $newContent = "$replacementLine`n" + ($lines | Select-Object -Skip 7 -join "`n")
    [System.IO.File]::WriteAllText("$workingDir\$filename", $newContent)
}

Invoke-WebRequest -Uri $url -OutFile "$workingDir\03_2024_adb_block.txt"
