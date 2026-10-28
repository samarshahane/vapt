
@echo off
setlocal
title VAPT Device Information Assessment

echo.
echo ==========================================
echo    VAPT DEVICE INFORMATION ASSESSMENT
echo ==========================================
echo.

set "OUT=VAPT_Report.txt"

echo VAPT DEVICE INFORMATION ASSESSMENT > "%OUT%"
echo Date: %DATE% %TIME% >> "%OUT%"
echo Computer: %COMPUTERNAME% >> "%OUT%"
echo ========================================== >> "%OUT%"

echo [1] HOSTNAME
hostname
hostname >> "%OUT%" 2>&1

echo.
echo [2] IP CONFIGURATION
ipconfig
ipconfig >> "%OUT%" 2>&1

echo.
echo [3] WINDOWS SYSTEM INFORMATION
systeminfo
systeminfo >> "%OUT%" 2>&1

echo.
echo [4] NMAP VERSION
nmap --version
nmap --version >> "%OUT%" 2>&1

echo.
echo [5] NMAP LOCALHOST SERVICE SCAN
where nmap >nul 2>&1
if errorlevel 1 (
    echo Nmap is not installed or is not in PATH.
    echo Nmap is not installed or is not in PATH. >> "%OUT%"
) else (
    nmap -sV 127.0.0.1
    nmap -sV 127.0.0.1 >> "%OUT%" 2>&1
)

echo.
echo [6] LISTENING TCP PORTS AND PIDS
netstat -ano | findstr LISTENING
netstat -ano | findstr LISTENING >> "%OUT%" 2>&1

echo.
echo [7] POSTGRESQL LISTENER CHECK
powershell -NoProfile -Command "Get-NetTCPConnection -LocalPort 5432 -State Listen -ErrorAction SilentlyContinue | Format-Table LocalAddress,LocalPort,State,OwningProcess"
powershell -NoProfile -Command "Get-NetTCPConnection -LocalPort 5432 -State Listen -ErrorAction SilentlyContinue | Format-Table LocalAddress,LocalPort,State,OwningProcess" >> "%OUT%" 2>&1

echo.
echo ==========================================
echo Assessment complete.
echo Report saved to: %CD%\%OUT%
echo ==========================================
pause
endlocal
