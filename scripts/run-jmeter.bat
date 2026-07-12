@echo off
setlocal

echo ==========================================
echo     One Touch Performance Framework
echo ==========================================
echo.

:: Project Home
set PROJECT_HOME=E:\performance-onetouch-framework

:: JMeter Home
set JMETER_HOME=C:\Loadmagic\apache-jmeter-5.6.3\apache-jmeter-5.6.3

echo Checking Java...
java -version

if errorlevel 1 (
    echo.
    echo ERROR: Java not found.
    pause
    exit /b
)

echo.
echo Java OK
echo.

echo Checking JMeter...

if not exist "%JMETER_HOME%\bin\jmeter.bat" (
    echo ERROR: JMeter not found at:
    echo %JMETER_HOME%
    pause
    exit /b
)

echo JMeter OK
echo.

echo Checking Project Structure...

if not exist "%PROJECT_HOME%\jmeter\testplans\RestfulBooker.jmx" (
    echo ERROR: JMX file not found.
    pause
    exit /b
)

echo JMX Found
echo.

echo Framework Validation Completed Successfully.
pause