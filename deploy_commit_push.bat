@echo off
setlocal

echo ========================================
echo TickTackBoom Web Deploy Commit + Push
echo ========================================
echo.

cd /d "%~dp0"

echo Working directory:
echo %CD%
echo.

git status
echo.

set /p COMMIT_MSG=Commit message eingeben: 

if "%COMMIT_MSG%"=="" (
    echo.
    echo FEHLER: Commit message darf nicht leer sein.
    pause
    exit /b 1
)

echo.
echo Adding files...
git add .

echo.
echo Creating commit...
git commit -m "%COMMIT_MSG%"

if errorlevel 1 (
    echo.
    echo Commit wurde nicht erstellt. Moeglich: Keine Aenderungen vorhanden oder Git-Fehler.
    pause
    exit /b 1
)

echo.
echo Pushing to GitHub...
git push

if errorlevel 1 (
    echo.
    echo FEHLER: Push fehlgeschlagen.
    pause
    exit /b 1
)

echo.
echo Final status:
git status

echo.
echo Done.
pause