@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"
color 0A

echo ============================================================
echo    TUYA LOCAL KEY EXTRACTOR - SETUP WIZARD
echo ============================================================
echo.
echo This wizard will help you configure and run the extractor.
echo.
pause
cls

echo ============================================================
echo    STEP 1: SELECT YOUR REGION
echo ============================================================
echo.
echo Choose your Tuya cloud region:
echo.
echo   1. America (US)
echo   2. America Azure (US - Alternative)
echo   3. Europe
echo   4. Europe MS (Europe - Alternative)
echo   5. China
echo   6. India
echo.
set /p region_choice="Enter your choice (1-6): "

if "%region_choice%"=="1" (
    set endpoint=TuyaCloudOpenAPIEndpoint.AMERICA
    set region_name=America (US)
)
if "%region_choice%"=="2" (
    set endpoint=TuyaCloudOpenAPIEndpoint.AMERICA_AZURE
    set region_name=America Azure (US - Alternative)
)
if "%region_choice%"=="3" (
    set endpoint=TuyaCloudOpenAPIEndpoint.EUROPE
    set region_name=Europe
)
if "%region_choice%"=="4" (
    set endpoint=TuyaCloudOpenAPIEndpoint.EUROPE_MS
    set region_name=Europe MS (Europe - Alternative)
)
if "%region_choice%"=="5" (
    set endpoint=TuyaCloudOpenAPIEndpoint.CHINA
    set region_name=China
)
if "%region_choice%"=="6" (
    set endpoint=TuyaCloudOpenAPIEndpoint.INDIA
    set region_name=India
)

echo.
echo Selected: !region_name!
echo.
cls

echo ============================================================
echo    STEP 2: COUNTRY CODE
echo ============================================================
echo.
echo Enter your country's international dialing code (without +)
echo.
echo Common codes:
echo   1   - USA/Canada
echo   44  - United Kingdom
echo   86  - China
echo   91  - India
echo.
set /p country_code="Enter your country code: "
echo.
cls

echo ============================================================
echo    STEP 3: MOBILE APP
echo ============================================================
echo.
echo Which app did you use to set up your devices?
echo.
echo   1. Smart Life
echo   2. Tuya Smart
echo.
set /p app_choice="Enter your choice (1 or 2): "

if "%app_choice%"=="1" (
    set app_type=AppType.SMART_LIFE
)
if "%app_choice%"=="2" (
    set app_type=AppType.TUYA_SMART
)

echo.
echo Selected: !app_type!
echo.
cls

echo ============================================================
echo    STEP 4: ACCOUNT CREDENTIALS
echo ============================================================
echo.
echo Enter your Smart Life/Tuya Smart account credentials
echo.
set /p email="Email: "
set /p password="Password: "
echo.
cls

echo ============================================================
echo    STEP 5: TUYA IOT PLATFORM CREDENTIALS
echo ============================================================
echo.
echo Find these at: https://iot.tuya.com
echo Navigate to: [Your Project] - Authorization - Cloud Authorization
echo.
set /p access_id="Enter your Access ID/Client ID: "
set /p access_key="Enter your Access Secret/Client Secret: "
echo.
cls

echo ============================================================
echo    GENERATING CONFIG FILE...
echo ============================================================
echo.

REM Create the config.py file with ORIGINAL format
(
echo from enum import Enum
echo from tuya_iot import TuyaCloudOpenAPIEndpoint
echo.
echo.
echo class AppType^(Enum^):
echo     TUYA_SMART = 'tuyaSmart'
echo     SMART_LIFE = 'smartlife'
echo.
echo.
echo # Select server of your Tuya Smart/Smart Life account.
echo ENDPOINT = !endpoint!
echo.
echo # Calling country code. For example: USA = 1
echo COUNTRY_CODE = !country_code!
echo.
echo # Change to AppType.SMART_LIFE for Smart Life app
echo APP = !app_type!
echo.
echo # Your Tuya Smart/Smart Life app account
echo EMAIL = '!email!'
echo PASSWORD = '!password!'
echo.
echo # Get these info on https://iot.tuya.com
echo ACCESS_ID = '!access_id!'
echo ACCESS_KEY = '!access_key!'
) > config.py

echo [OK] config.py has been created!
echo.
echo Your configuration:
echo   Region: !region_name!
echo   Country Code: !country_code!
echo   App: !app_type!
echo   Email: !email!
echo.
echo ============================================================
echo    CHECKING DEPENDENCIES
echo ============================================================
echo.

python -c "import tuya_iot" 2>nul
if errorlevel 1 (
    echo [ERROR] tuya-iot-python-sdk is NOT installed
    echo.
    set /p install_choice="Install now? (Y/N): "
    if /i "!install_choice!"=="Y" (
        pip install tuya-iot-python-sdk
        pip install paho-mqtt==1.6.1
        echo [OK] Installation complete!
    )
) else (
    echo [OK] tuya-iot-python-sdk is installed
    echo [OK] Checking paho-mqtt version...
    pip install paho-mqtt==1.6.1 --quiet
)

echo.
echo ============================================================
echo    IMPORTANT - BEFORE RUNNING
echo ============================================================
echo.
echo Make sure you have subscribed to IoT Core service:
echo   1. Go to https://iot.tuya.com
echo   2. Navigate to: Cloud - Development - Cloud Services
echo   3. Subscribe to "IoT Core" (free version is fine)
echo   4. Verify status shows "In service" (not "Alerting")
echo.
echo ============================================================
echo.
set /p run_now="Extract Tuya keys now? (Y/N): "
echo.

if /i "!run_now!"=="Y" (
    echo.
    echo ================================================
    echo Running Tuya Local Key Extractor
    echo ================================================
    echo.
    python extract.py
    echo.
    echo ================================================
    echo Results saved to: tuya_devices.json
    echo ================================================
    echo.
) else (
    echo.
    echo Run extraction anytime with: python extract.py
    echo Results will be saved to: tuya_devices.json
    echo.
)

pause
