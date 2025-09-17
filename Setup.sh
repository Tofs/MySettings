
# cli setup
sudo pacman -S zsh tmux fzf sudo ripgrep
chsh -s /usr/bin/zsh # set default shell
rm ~/.zshenv
rm ~/.zshrc
rm ~/.tmux.conf
ln -s ~/code/MySettings/zshenv ~/.zshenv
ln -s ~/code/MySettings/zshrc ~/.zshrc
ln -s ~/code/MySettings/.tmux.conf ~/.tmux.conf

# development
sudo pacman -S git nvim npm clang cmake make lazygit fakeroot debugedit
mkdir -p ~/.config/nvim
ln -s ~/code/MySettings/neovim ~/.config/nvim

# install yay
rm -rf yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si


#installing firefox
sudo pacman -S firefox

#hyprland
sudo pacman -S hyprland
mkdir -p ~/.config/hypr/
rm ~/.config/hypr/hyprland.conf
ln -s ~/code/MySettings/hyprland.conf ~/.config/hypr/hyprland.conf

# waybar
sudo pacman -S waybar
# link in waybar config

# Kitty
sudo pacman -S kitty

# openSSH
sudo pacman -S openssh
systemctl enable sshd
systemctl start sshd

# general tools
# yazi file manager
sudo pacman -S yazi unzip
yay -S 1password

# media tools
sudo pacman -S mpv
