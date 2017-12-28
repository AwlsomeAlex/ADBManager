@echo off
REM Android ADB Device Manager - Version GIT
REM Created by AwlsomeAlex (GPLv3)
title Android ADB Device Manager - Loading Files...
goto home

:home
title Android ADB Device Manager - Main Menu
cls
call:title
echo.
echo Welcome to the Android ADB Device Manager!
echo Created by AwlsomeAlex (GPLv3)
echo.
echo Please Select an Option:
echo ========================
echo.
echo 1) Test ADB Connection
echo 2) Sideload APK to Device
echo 3) Inject File to Device
echo 4) Reboot Device
echo 5) Install Universal ADB Driver
echo 6) Exit Utility
echo.
set /p choice=Please Select a Number:
if "%choice%"=="1" goto test
if "%choice%"=="2" goto sideload
if "%choice%"=="3" goto inject
if "%choice%"=="4" goto reboot
if "%choice%"=="5" goto drivers
if "%choice%"=="6" goto stop
goto home

:: TITLE FUNCTION
:title
echo  ====================
echo   ADB Device Manager 
echo  ====================
echo Created by AwlsomeAlex
echo     GPLv3 License
echo      Version GIT
echo.
goto:eof

:: TEST FUNCTION
:test
title Android ADB Device Manager - Test ADB Connection
cls
call:title
echo The Utility will now scan for ADB Connections...
echo.
adb.exe devices
pause
goto home


:: SIDELOAD FUNCTION
:sideload
title Android ADB Device Manager - Sideload APK
cls
call:title
echo Please Select an APK to be Sideloaded.
%extd% /browseforfile "Browse for a file" "" "APK (*.apk)|*.apk" "1"
if "%result%"=="" (goto home) else (set file="%result%")
echo.
echo The file selected is %file%. Is this correct?
set /p choice=Type YES or NO:
if "%choice%"=="YES" goto sideloadapk
if "%choice%"=="NO" goto home

:sideloadapk
title Android ADB Device Manager - Sideloading %file%...
cls
call:title
echo The Utility will now sideload %file% to the Device.
echo.
adb.exe install %file%
echo.
echo The APK %file% has been sideloaded.
pause
goto home

:: INJECT FILES TO SDCARD
:inject
title Android ADB Device Manager - Inject File
cls
call:title
echo Please select a File to be Injected.
%extd% /browseforfile "Browse for a file" "" "All Files (*.*)|*.*"
if "%result%"=="" (exit) else (set file="%result%")
echo.
echo The file selected is %file%. Is this correct?
echo.
set /p choice=Type YES or NO:
if "%choice%"=="YES" goto injectfile
if "%choice%"=="NO" goto home

:injectfile
title Android ADB Device Manager - Injecting %file%...
cls
call:title
echo The Utility will now inject %file% to the SDCARD Storage.
echo.
adb.exe push %file% /sdcard/
echo.
echo The file %file% has been injected.
pause
goto home

:: REBOOT DEVICE
:reboot
title Android ADB Device Manager - Reboot Device
cls
call:title
echo The Utility will now reboot the device. Continue?
set /p choice=Type YES, NO or RECOVERY:
if "%choice%"=="YES" goto rebootdevice
if "%choice%"=="NO" goto home
if "%choice%"=="RECOVERY" goto recovery

:rebootdevice
title Android ADB Device Manager - Rebooting Device...
cls
call:title
echo The Utility will now reboot the device...
adb.exe reboot
echo.
pause
goto home

:recovery
title Android ADB Device Manager - Rebooting Device into Recovery...
cls
call:title
echo The Utility will now reboot the device into recovery...
adb.exe reboot recovery
echo.
pause
goto home

:: INSTALL ADB UNIVERSAL DRIVER
:drivers
title Android ADB Device Manager - Install Universal ADB Driver
cls
call:title
echo The Utility will now install the ADB Universal Driver. Continue?
echo.
echo =================
echo !!!!!WARNING!!!!!
echo =================
echo This will require a REBOOT!
echo.
set /p choice=Type YES or NO:
if "%choice%"=="YES" goto installdriver
if "%choice%"=="NO" goto home

:installdriver
wget.exe http://download.clockworkmod.com/test/UniversalAdbDriverSetup.msi
UniversalAdbDriverSetup.msi
pause
goto creboot

:creboot
Taskkill /IM adb.exe /F
shutdown /r
goto home

:: STOP FUNCTION
:stop
Taskkill /IM adb.exe /F
exit
