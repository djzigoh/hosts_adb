$URL = https://a.dove.isdumb.one/list.txt"
Set-Location -Path 'C:\hosts_adb' 
foreach ($i in 3..12) {     
    $outFile = "${i}_2024_adb_block_with_login"
    try {             
        Invoke-WebRequest -Uri $URL -OutFile $outFile
    } catch {                     
    }
    try {                              
        $content = Get-Content -Path $outFile | Select-Object -Skip 7   
        Set-Content -Path $outFile -Value $content  
    } catch {                      
    }
}
try {                              
    git add .  
} catch {                        
}
try {                
    git commit -m 'Automated update' 
} catch {                   
}