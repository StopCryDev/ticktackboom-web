@echo off
setlocal enabledelayedexpansion

cd /d "%~dp0"

if not exist "Logs" mkdir "Logs"

for /f "tokens=1-4 delims=/:. " %%a in ("%date% %time%") do (
    set "STAMP=%%d-%%b-%%c_%%a-%%e"
)

set "LOG_FILE=Logs\clean_web_build_log.txt"

(
echo ========================================
echo TickTackBoom WebGL Deploy Folder Cleanup
echo ========================================
echo.
echo Date/Time:
echo %date% %time%
echo.
echo Working directory:
echo %CD%
echo.
echo Keeping:
echo - .git
echo - _headers
echo - clean_web_build.bat
echo - deploy_commit_push.bat
echo - Logs
echo.
echo Removing old Unity WebGL build output...
echo.
) > "%LOG_FILE%"

echo ========================================
echo TickTackBoom WebGL Deploy Folder Cleanup
echo ========================================
echo.
echo Working directory:
echo %CD%
echo.

call :RemoveFolder "Build"
call :RemoveFolder "TemplateData"
call :RemoveFile "index.html"

(
echo.
echo Cleanup complete.
echo Now build from Unity directly into:
echo %CD%
echo.
) >> "%LOG_FILE%"

echo.
echo Cleanup complete.
echo Log written to:
echo %CD%\%LOG_FILE%
echo.
echo Now build from Unity directly into:
echo %CD%
echo.
pause
exit /b 0

:RemoveFolder
if exist "%~1" (
    rmdir /s /q "%~1"
    echo Removed folder: %~1
    echo Removed folder: %~1 >> "%LOG_FILE%"
) else (
    echo Skipped folder: %~1 not found
    echo Skipped folder: %~1 not found >> "%LOG_FILE%"
)
exit /b 0

:RemoveFile
if exist "%~1" (
    del /f /q "%~1"
    echo Removed file: %~1
    echo Removed file: %~1 >> "%LOG_FILE%"
) else (
    echo Skipped file: %~1 not found
    echo Skipped file: %~1 not found >> "%LOG_FILE%"
)
exit /b 0