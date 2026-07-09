@echo off
setlocal enabledelayedexpansion

cd /d "%~dp0"

if not exist "Logs" mkdir "Logs"

set "LOG_FILE=Logs\deploy_commit_push_log.txt"

(
echo ========================================
echo TickTackBoom Web Deploy Commit + Push
echo ========================================
echo.
echo Date/Time:
echo %date% %time%
echo.
echo Working directory:
echo %CD%
echo.
) > "%LOG_FILE%"

echo ========================================
echo TickTackBoom Web Deploy Commit + Push
echo ========================================
echo.
echo Working directory:
echo %CD%
echo.

where git >nul 2>&1
if errorlevel 1 (
    echo FEHLER: Git wurde nicht gefunden.
    echo FEHLER: Git wurde nicht gefunden. >> "%LOG_FILE%"
    pause
    exit /b 1
)

git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (
    echo FEHLER: Dieser Ordner ist kein Git-Repository.
    echo FEHLER: Dieser Ordner ist kein Git-Repository. >> "%LOG_FILE%"
    pause
    exit /b 1
)

echo Initial status:
git status
git status >> "%LOG_FILE%" 2>&1

echo.
set /p COMMIT_MSG=Commit message eingeben: 

if "%COMMIT_MSG%"=="" (
    echo.
    echo FEHLER: Commit message darf nicht leer sein.
    echo FEHLER: Commit message darf nicht leer sein. >> "%LOG_FILE%"
    pause
    exit /b 1
)

(
echo.
echo Commit message:
echo %COMMIT_MSG%
echo.
echo Adding files...
) >> "%LOG_FILE%"

echo.
echo Adding files...
git add -A >> "%LOG_FILE%" 2>&1

if errorlevel 1 (
    echo.
    echo FEHLER: git add ist fehlgeschlagen.
    echo FEHLER: git add ist fehlgeschlagen. >> "%LOG_FILE%"
    type "%LOG_FILE%"
    pause
    exit /b 1
)

echo.
echo Status after git add:
git status
git status >> "%LOG_FILE%" 2>&1

git diff --cached --quiet
if not errorlevel 1 (
    echo.
    echo Keine gestagten Aenderungen vorhanden. Commit wird nicht erstellt.
    echo Keine gestagten Aenderungen vorhanden. Commit wird nicht erstellt. >> "%LOG_FILE%"
    type "%LOG_FILE%"
    pause
    exit /b 0
)

(
echo.
echo Creating commit...
) >> "%LOG_FILE%"

echo.
echo Creating commit...
git commit -m "%COMMIT_MSG%" >> "%LOG_FILE%" 2>&1

if errorlevel 1 (
    echo.
    echo FEHLER: Commit wurde nicht erstellt.
    echo FEHLER: Commit wurde nicht erstellt. >> "%LOG_FILE%"
    type "%LOG_FILE%"
    pause
    exit /b 1
)

type "%LOG_FILE%"

(
echo.
echo Pushing to GitHub...
) >> "%LOG_FILE%"

echo.
echo Pushing to GitHub...
git push >> "%LOG_FILE%" 2>&1

if errorlevel 1 (
    echo.
    echo FEHLER: Push fehlgeschlagen.
    echo FEHLER: Push fehlgeschlagen. >> "%LOG_FILE%"
    type "%LOG_FILE%"
    pause
    exit /b 1
)

(
echo.
echo Final status:
) >> "%LOG_FILE%"

echo.
echo Final status:
git status
git status >> "%LOG_FILE%" 2>&1

(
echo.
echo Done.
) >> "%LOG_FILE%"

echo.
echo Log written to:
echo %CD%\%LOG_FILE%
echo.
echo Done.
pause