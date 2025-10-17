function Download-VideoFile {
    param(
        [string]$VideoUrl,
        [string]$OutputPath
    )
    
    Write-Host "Downloading video from: $VideoUrl" -ForegroundColor Cyan
    
    try {
        # יצירת session עם headers מתקדמים
        $session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
        $session.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36"
        
        $headers = @{
            "sec-ch-ua-platform" = ""Windows""
            "Referer" = "https://lemida.biu.ac.il/mod/hvp/view.php?id=2432484"
            "Accept-Encoding" = "identity;q=1, *;q=0"
            "sec-ch-ua" = ""Google Chrome";v="141", "Not?A_Brand";v="8", "Chromium";v="141""
            "sec-ch-ua-mobile" = "?0"
        }
        
        # הורדה עם headers מתקדמים
        Invoke-WebRequest -UseBasicParsing -Uri $VideoUrl -OutFile $OutputPath -WebSession $session -Headers $headers
        
        if (Test-Path $OutputPath) {
            $fileSize = (Get-Item $OutputPath).Length / 1MB
            Write-Host "Download completed! File size: $([math]::Round($fileSize, 2)) MB" -ForegroundColor Green
            return $true
        }
    }
    catch {
        Write-Host "Download failed: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
    
    return $false
}
