## cli setup


## handle arguments

if [ $# -eq 0 ]
then
	echo "Use Install and/or Link to use the script"
fi

if [ "$1" = "Install"  ] || [ "$1" = "install" ] || [ "$2" = "Install" ] || [ "$2" = "install" ]
then
	install=true
fi

if [ "$1" = "Link" ] || [ "$1" = "link" ] || [ "$2" = "Link" ] || [ "$2" = "link" ]
then
	link=true
fi


if [ $install ]
then 
	echo "Will install applications"
else
	echo "Will NOT install applications"
fi

if [ $link ]
then 
	echo "Will create links to config"
else
	echo "Will NOT create links to config"
fi


if [ $install ]
then
	sudo pacman -S zsh tmux fzf sudo ripgrep
	chsh -s /usr/bin/zsh # set default shell
fi
if [ $link ]
then
	rm ~/.zshenv
	rm ~/.zshrc
	rm ~/.tmux.conf
	ln -s ~/code/MySettings/zshenv ~/.zshenv
	ln -s ~/code/MySettings/zshrc ~/.zshrc
	ln -s ~/code/MySettings/.tmux.conf ~/.tmux.conf
fi

# development
if [ $install ]
then
	sudo pacman -S git nvim npm clang cmake make lazygit fakeroot debugedit
fi
if [ $link ]
then
	rm -rf ~/.config/nvim
	ln -s ~/code/MySettings/neovim ~/.config/nvim
fi

# install yay
if [ $install ]
then
	rm -rf yay
	git clone https://aur.archlinux.org/yay.git
	pushd yay
	makepkg -si
	popd
	rm -rf yay
fi



#installing firefox
if [ $install ]
then
	sudo pacman -S firefox
fi

#hyprland
if [ $install ]
then
	sudo pacman -S hyprland waybar wofi hypridle
fi
if [ $link ]
then
	mkdir -p ~/.config/
	rm -rf ~/.config/hypr
	rm -rf ~/.config/waybar
	ln -s ~/code/MySettings/hyprland ~/.config/hypr
	ln -s ~/code/MySettings/waybar ~/.config/waybar
fi

# Kitty
if [ $install ]
then
	sudo pacman -S kitty
	mkdir -p ~/.config/kitty
	ln -s ~/code/MySettings/kitty.conf ~/.config/kitty/kitty.conf
fi

# openSSH
if [ $install ]
then
	sudo pacman -S openssh
	systemctl enable sshd
	systemctl start sshd
fi

# general tools
if [ $install ]
then
	# bluetooth
	sudo pacman -S bluetui

	# yazi file manager
	sudo pacman -S yazi unzip
	yay -S 1password
	
	# media tools
	sudo pacman -S mpv wiremix
fi

