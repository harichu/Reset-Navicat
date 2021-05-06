@color a0
@title Reset Navicat trial period
@echo off
echo --------------------------
echo     Closing process...
echo --------------------------
taskkill /F /T /IM navicat.exe
if exist %temp%\backup.reg (
del %temp%\backup.reg
)
echo --------------------------
echo     Backing up the registry...
echo --------------------------
reg EXPORT HKCU\Software %temp%\backup.reg
echo --------------------------
echo   Generating registry file...
echo --------------------------
set fr=-
echo Windows Registry Editor Version 5.00 >> %temp%\Navicat.reg
echo [-HKEY_CURRENT_USER\Software\PremiumSoft\Data] >>%temp%\Navicat.reg
for /F "delims=" %%i in ('"REG QUERY "HKEY_CURRENT_USER\Software\Classes\CLSID" /s | findstr /E Info"') do (
echo [%fr%%%i] >> %temp%\Navicat.reg
)
echo --------------------------
echo     Operation in progress...
echo --------------------------
regedit /s %temp%\Navicat.reg
echo --------------------------
echo   Navicat trial period has been reset...
echo --------------------------
del %temp%\Navicat.reg
pause
