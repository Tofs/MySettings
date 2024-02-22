
setlocal EnableDelayedExpansion 
if "%1"=="" (  
	echo Usage install.bat install pull setup
) 
if "%1"=="install" (  
	winget install --id Git.Git -e --source winget
	winget install Microsoft.PowerToys --source winget
	winget install neovim
  winget install BurntSushi.ripgrep.MSVC
)
if "%1"=="pull" (
	cp -r %appdata%\..\Local\nvim .
)
if "%1"=="setup" (
	cp ./.vimrc %home%/_vimrc
)
exit /b
