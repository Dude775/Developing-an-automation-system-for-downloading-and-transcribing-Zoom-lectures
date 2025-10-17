param(
    [Parameter(Mandatory=$true)]
    [string]$VideoUrl,
    
    [Parameter(Mandatory=$false)]
    [string]$CourseTitle = "Unknown"
)

# טעינת כל המודולים
. ".\modules\VideoDownloader.ps1"
. ".\modules\AudioExtractor.ps1"
. ".\modules\Transcriber.ps1"

# קריאת קובץ התצורה
$config = Get-Content ".\config.json" | ConvertFrom-Json

Write-Host "=== Zoom Transcriber Started ===" -ForegroundColor Green
Write-Host "Video URL: $VideoUrl" -ForegroundColor Yellow
Write-Host "Course: $CourseTitle" -ForegroundColor Yellow

# יצירת שמות קבצים ייחודיים
$timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm"
$safeTitle = $CourseTitle -replace '[^\w\-_\.]', '_'
$videoPath = ".\temp\$timestamp_$safeTitle.mp4"
$audioPath = ".\temp\$timestamp_$safeTitle.mp3"
$transcriptPath = ".\output\$timestamp_$safeTitle.txt"

# שלב 1: הורדת הסרטון
Write-Host "
--- Step 1: Downloading Video ---" -ForegroundColor Magenta
if (-not (Download-VideoFile -VideoUrl $VideoUrl -OutputPath $videoPath)) {
    Write-Host "Failed to download video. Exiting." -ForegroundColor Red
    exit 1
}

# שלב 2: חילוץ שמע
Write-Host "
--- Step 2: Extracting Audio ---" -ForegroundColor Magenta
if (-not (Extract-AudioFromVideo -VideoPath $videoPath -AudioPath $audioPath -Quality $config.settings.audio_quality)) {
    Write-Host "Failed to extract audio. Exiting." -ForegroundColor Red
    exit 1
}

# שלב 3: תמלול
Write-Host "
--- Step 3: Transcribing Audio ---" -ForegroundColor Magenta
if (-not (Transcribe-Audio -AudioPath $audioPath -OutputPath $transcriptPath -Language $config.whisper.language)) {
    Write-Host "Failed to transcribe audio. Exiting." -ForegroundColor Red
    exit 1
}

# ניקוי קבצים זמניים (אם מוגדר)
if ($config.settings.cleanup_temp_files) {
    Write-Host "
--- Cleaning up temporary files ---" -ForegroundColor Magenta
    Remove-Item $videoPath -Force -ErrorAction SilentlyContinue
    Remove-Item $audioPath -Force -ErrorAction SilentlyContinue
}

Write-Host "
=== Process Completed Successfully! ===" -ForegroundColor Green
Write-Host "Transcript saved to: $transcriptPath" -ForegroundColor Yellow
