function Extract-AudioFromVideo {
    param(
        [string]$VideoPath,
        [string]$AudioPath,
        [string]$Quality = "192k"
    )
    
    Write-Host "Extracting audio from: $VideoPath" -ForegroundColor Cyan
    
    try {
        # בניית פקודת FFmpeg
        $ffmpegArgs = @(
            "-i", $VideoPath,
            "-vn",
            "-acodec", "mp3", 
            "-ab", $Quality,
            "-y",
            $AudioPath
        )
        
        Write-Host "Running: ffmpeg $($ffmpegArgs -join ' ')" -ForegroundColor Yellow
        
        # הפעלת FFmpeg
        $process = Start-Process -FilePath "ffmpeg" -ArgumentList $ffmpegArgs -Wait -NoNewWindow -PassThru
        
        if ($process.ExitCode -eq 0 -and (Test-Path $AudioPath)) {
            $audioSize = (Get-Item $AudioPath).Length / 1MB
            Write-Host "Audio extraction completed! File size: $([math]::Round($audioSize, 2)) MB" -ForegroundColor Green
            return $true
        } else {
            Write-Host "FFmpeg failed with exit code: $($process.ExitCode)" -ForegroundColor Red
            return $false
        }
    }
    catch {
        Write-Host "Audio extraction failed: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}
