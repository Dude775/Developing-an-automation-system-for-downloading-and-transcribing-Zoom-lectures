function Transcribe-Audio {
    param(
        [string]$AudioPath,
        [string]$OutputPath,
        [string]$Language = "hebrew"
    )
    
    Write-Host "Starting transcription for: $AudioPath" -ForegroundColor Cyan
    
    try {        
        # הפעלת Whisper
        $whisperArgs = @(
            $AudioPath,
            "--language", $Language,
            "--output_format", "txt",
            "--output_dir", (Split-Path $OutputPath -Parent)
        )
        
        Write-Host "Running: whisper $($whisperArgs -join ' ')" -ForegroundColor Yellow
        
        $process = Start-Process -FilePath "whisper" -ArgumentList $whisperArgs -Wait -NoNewWindow -PassThru
        
        # חיפוש קובץ התמלול שנוצר
        $baseName = [System.IO.Path]::GetFileNameWithoutExtension($AudioPath)
        $transcriptFile = Join-Path (Split-Path $OutputPath -Parent) "$baseName.txt"
        
        if (Test-Path $transcriptFile) {
            # העברת הקובץ לשם הרצוי
            Move-Item $transcriptFile $OutputPath -Force
            Write-Host "Transcription completed successfully!" -ForegroundColor Green
            return $true
        } else {
            Write-Host "Transcription file not found" -ForegroundColor Red
            return $false
        }
    }
    catch {
        Write-Host "Transcription failed: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}
