
setlocal EnableDelayedExpansion 
if "%1"=="" (  
	echo Usage install.bat install pull setup
) 
if "%1"=="install" (  
	winget install --id Git.Git -e --source winget
	winget install Microsoft.PowerToys --source winget
	winget install neovim
	curl http://www.cygwin.com/setup-x86_64.exe -o .\cygwin_setup.exe
)
if "%1"=="pull" (
	git clone https://github.com/Tofs/MySettings.git ./mysettings
)
if "%1"=="setup" (
	cp ./.vimrc %home%/_vimrc
)
exit /b
