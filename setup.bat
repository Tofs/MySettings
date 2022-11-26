@echo off
setlocal EnableDelayedExpansion 
if "%1"=="" (  
	echo Usage install.bat install update
) 
if "%1"=="install" (  
	winget install --id Git.Git -e --source winget
	winget install Microsoft.PowerToys --source winget
	curl http://www.cygwin.com/setup-x86_64.exe -o .\cygwin_setup.exe
)
exit /b
