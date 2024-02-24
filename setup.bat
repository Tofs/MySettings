
setlocal EnableDelayedExpansion 
if "%1"=="update" (
	set INSTALL=1
)
if "%1"=="install" (  
	set INSTALL=1
	set REPOCLONE=1
)
if defined INSTALL (
	winget install --id Git.Git -e --source winget
	winget install Microsoft.PowerToys --source winget
	winget install neovim
	winget install BurntSushi.ripgrep.MSVC
  winget install python3
  winget install zip.zip
	git config --global core.sshCommand "C:/Windows/System32/OpenSSH/ssh.exe"
)
if defined REPOCLONE (
	git clone https://github.com/Tofs/neovim.git %appdata%\..\Local\nvim
)
exit /b
