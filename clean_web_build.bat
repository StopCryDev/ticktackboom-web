@echo off
setlocal

echo ========================================
echo TickTackBoom WebGL Deploy Folder Cleanup
echo ========================================
echo.

cd /d "%~dp0"

echo Working directory:
echo %CD%
echo.

echo Keeping:
echo - .git
echo - _headers
echo - clean_web_build.bat
echo.

echo Removing old Unity WebGL build output...

if exist "Build" (
    rmdir /s /q "Build"
    echo Removed: Build
) else (
    echo Skipped: Build not found
)

if exist "TemplateData" (
    rmdir /s /q "TemplateData"
    echo Removed: TemplateData
) else (
    echo Skipped: TemplateData not found
)

if exist "index.html" (
    del /f /q "index.html"
    echo Removed: index.html
) else (
    echo Skipped: index.html not found
)

echo.
echo Cleanup complete.
echo Now build from Unity directly into:
echo %CD%
echo.
pause