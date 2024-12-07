@echo off
REM Svc.cmd - Script to manage self-hosted runner as a Windows service

if "%1"=="install" (
    echo Installing GitHub Actions Runner as a Windows service...
    sc create GitHubActionsRunner binPath= "\"%~dp0\bin\RunnerService.exe\" --start-as-service" start= auto
    if %ERRORLEVEL% EQU 0 (
        echo Service installed successfully.
    ) else (
        echo Failed to install the service.
        exit /b %ERRORLEVEL%
    )
    goto :eof
)

if "%1"=="uninstall" (
    echo Uninstalling GitHub Actions Runner service...
    sc delete GitHubActionsRunner
    if %ERRORLEVEL% EQU 0 (
        echo Service uninstalled successfully.
    ) else (
        echo Failed to uninstall the service.
        exit /b %ERRORLEVEL%
    )
    goto :eof
)

if "%1"=="start" (
    echo Starting GitHub Actions Runner service...
    net start GitHubActionsRunner
    if %ERRORLEVEL% EQU 0 (
        echo Service started successfully.
    ) else (
        echo Failed to start the service.
        exit /b %ERRORLEVEL%
    )
    goto :eof
)

if "%1"=="stop" (
    echo Stopping GitHub Actions Runner service...
    net stop GitHubActionsRunner
    if %ERRORLEVEL% EQU 0 (
        echo Service stopped successfully.
    ) else (
        echo Failed to stop the service.
        exit /b %ERRORLEVEL%
    )
    goto :eof
)

echo Usage:
echo svc.cmd install   - Install the runner as a Windows service
echo svc.cmd uninstall - Uninstall the runner service
echo svc.cmd start     - Start the runner service
echo svc.cmd stop      - Stop the runner service
exit /b 0
