::http://stackoverflow.com/questions/137182/how-to-launch-windows-regedit-with-certain-path


@echo off
setlocal EnableDelayedExpansion
set "RootName=Computer"

if not "%~1"=="" (
    set "RegKey=%~1"
    goto PrepareKey
)

echo.
echo Please enter the path of the registry key to open.
echo.
set "RegKey="
set /P "RegKey=Key path: "

rem Exit batch file without starting Regedit if nothing entered by user.
if "!RegKey!"=="" goto ExitBatch

:PrepareKey
rem Remove square brackets and double quotes from entered key path.
set "RegKey=!RegKey:"=!"
if "!RegKey!"=="" goto ExitBatch
set "RegKey=!RegKey:[=!"
if "!RegKey!"=="" goto ExitBatch
set "RegKey=!RegKey:]=!"
if "!RegKey!"=="" goto ExitBatch

rem Replace hive name abbreviation by appropriate long name.
set "Abbreviation=%RegKey:~0,4%"
if /I "%Abbreviation%"=="HKCC" (
    set "RegKey=HKEY_CURRENT_CONFIG%RegKey:~4%"
    goto GetRootName
)
if /I "%Abbreviation%"=="HKCR" (
    set "RegKey=HKEY_CLASSES_ROOT%RegKey:~4%"
    goto GetRootName
)
if /I "%Abbreviation%"=="HKCU" (
    set "RegKey=HKEY_CURRENT_USER%RegKey:~4%"
    goto GetRootName
)
if /I "%Abbreviation%"=="HKLM" (
    set "RegKey=HKEY_LOCAL_MACHINE%RegKey:~4%"
    goto GetRootName
)
if /I "%RegKey:~0,3%"=="HKU" (
    set "RegKey=HKEY_USERS%RegKey:~3%"
)

:GetRootName
rem Try to determine automatically name of registry root.
for /F "tokens=1,2*" %%K in ('%SystemRoot%\System32\reg.exe query "HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit" /v "LastKey"') do (
    if /I "%%K"=="LastKey" (
        for /F "delims=\" %%N in ("%%M") do set "RootName=%%N"
    )
)

rem Is Regedit already running?
%SystemRoot%\System32\tasklist.exe | %SystemRoot%\System32\findstr.exe /B /I /L regedit.exe >nul
if errorlevel 1 goto SetRegPath

echo.
echo Regedit is already running. Path can be set only when Regedit is not running.
echo.
set "Choice=N"
set /P "Choice=Kill Regedit (y/N): "
if /I "!Choice!"=="y" (
    %SystemRoot%\System32\taskkill.exe /IM regedit.exe >nul 2>nul
    goto SetRegPath
)
echo Switch to running instance of Regedit without setting entered path.
goto StartRegedit

:SetRegPath
rem Add this key as last key to registry for Regedit.
%SystemRoot%\System32\reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit" /v "LastKey" /d "%RootName%\%RegKey%" /f >nul 2>nul

:StartRegedit
start /B regedit.exe

:ExitBatch
endlocal