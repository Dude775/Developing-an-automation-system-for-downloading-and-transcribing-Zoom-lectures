#
```markdown
# Installation Guide

Complete step-by-step installation guide for ZoomTranscriber.

---

## Prerequisites

### Required Software

#### 1. FFmpeg 7.1+
**Purpose:** Audio extraction from video files

**Download:**
- Official website: https://ffmpeg.org/download.html
- Windows builds: https://www.gyan.dev/ffmpeg/builds/

**Installation:**
1. Download `ffmpeg-release-full.7z`
2. Extract to `C:\ffmpeg\`
3. Add to PATH or note the path: `C:\ffmpeg\bin\ffmpeg.exe`

**Verify installation:**
```powershell
ffmpeg -version
```

---

#### 2. Python 3.10+
**Purpose:** Running OpenAI Whisper

**Download:**
- Official website: https://www.python.org/downloads/

**Installation:**
1. Download Windows installer (64-bit)
2. ✅ **Check "Add Python to PATH"** during installation
3. Install to default location or note custom path

**Verify installation:**
```powershell
python --version
pip --version
```

---

#### 3. OpenAI Whisper
**Purpose:** Audio-to-text transcription

**Installation:**
```powershell
pip install openai-whisper
```

**For GPU acceleration (optional, NVIDIA only):**
```powershell
pip install openai-whisper[gpu]
```

**Verify installation:**
```powershell
python -m whisper --help
```

---

## System Requirements

### Minimum:
- **OS:** Windows 10/11
- **RAM:** 4GB (8GB recommended)
- **CPU:** Any modern processor (AVX support recommended)
- **Disk:** 5GB free space for temporary files

### Recommended:
- **RAM:** 8GB+
- **CPU:** Multi-core with AVX2 support
- **GPU:** NVIDIA GPU with CUDA (optional, speeds up transcription by ~70%)

---

## Installation Steps

### Step 1: Clone Repository
```powershell
cd C:\
git clone https://github.com/YourUsername/ZoomTranscriber.git
cd ZoomTranscriber
```

**Or download ZIP:**
1. Click green **"Code"** button → **"Download ZIP"**
2. Extract to `C:\ZoomTranscriber\`

---

### Step 2: Configure Paths

Edit `config.json` with your system paths:

```json
{
  "paths": {
    "videos": "C:\\ZoomTranscriber\\videos",
    "audio": "C:\\ZoomTranscriber\\audio",
    "transcripts": "C:\\ZoomTranscriber\\transcripts",
    "ffmpeg": "C:\\ffmpeg\\bin\\ffmpeg.exe",
    "python": "C:\\Users\\YourUsername\\AppData\\Local\\Programs\\Python\\Python313\\python.exe"
  }
}
```

**Find your Python path:**
```powershell
where.exe python
```

---

### Step 3: Create Output Directories

The script will create these automatically on first run, but you can create them manually:

```powershell
New-Item -ItemType Directory -Path "C:\ZoomTranscriber\videos"
New-Item -ItemType Directory -Path "C:\ZoomTranscriber\audio"
New-Item -ItemType Directory -Path "C:\ZoomTranscriber\transcripts"
```

---

### Step 4: Test Installation

Run a test command (without actual video URL):

```powershell
.\main.ps1 -VideoUrl "test" -CourseTitle "TestRun"
```

This will fail (expected), but verifies script loading works.

---

## First Run

### Basic Usage:
```powershell
.\main.ps1 -VideoUrl "https://example.com/lecture.mp4" -CourseTitle "MyFirstLecture"
```

### Expected output:
```
Downloading video...
Extracting audio...
Transcribing...
Complete! Transcript: C:\ZoomTranscriber\transcripts\MyFirstLecture_20251017_103045_transcript.txt
```

---

## Troubleshooting Installation

### Error: "ffmpeg is not recognized"
**Solution:**
1. Verify FFmpeg path in `config.json`
2. Test manually: `C:\ffmpeg\bin\ffmpeg.exe -version`

### Error: "No module named 'whisper'"
**Solution:**
```powershell
pip install --upgrade openai-whisper
```

### Error: "Python was not found"
**Solution:**
1. Reinstall Python with "Add to PATH" checked
2. Or manually add Python to PATH:
   - Search "Environment Variables" in Windows
   - Edit PATH → Add: `C:\Users\YourUsername\AppData\Local\Programs\Python\Python313\`

### Slow transcription
**Solutions:**
- Use smaller Whisper model: `"model": "tiny"` in config.json
- Enable GPU acceleration (NVIDIA only)
- Close other applications during transcription

---

## Upgrading Whisper Model

For better accuracy (slower processing):

Edit `config.json`:
```json
"transcription": {
    "model": "medium"
}
```

**Model comparison:**
| Model  | Size  | RAM  | Speed | Accuracy |
|--------|-------|------|-------|----------|
| tiny   | 39MB  | 1GB  | 5x    | 65%      |
| base   | 74MB  | 1GB  | 3x    | 75%      |
| small  | 244MB | 2GB  | 1.5x  | 85%      |
| medium | 769MB | 5GB  | 1x    | 92%      |
| large  | 1.5GB | 10GB | 0.5x  | 96%      |

---

## Next Steps

- Read [USAGE.md](USAGE.md) for advanced features
- See [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for common issues
- Check [ARCHITECTURE.md](ARCHITECTURE.md) for technical details
```
