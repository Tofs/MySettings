
# install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# development
sudo pacman -S git nvim npm clang cmake lazygit
ln -s ~/code/MySettings/neovim ~/.config/nvim

#installing firefox
sudo pacman -S firefox

#hyprland
sudo pacman -S hyprland
ln -s ~/code/MySettings/hyprland.conf ~/.config/hypr/hyprland.conf

# waybar
sudo pacman -S waybar
# link in waybar config

# cli setup
sudo pacman -S zsh tmux fzf
yay -S 1password
chsh -s /usr/bin/zsh # set default shell
ln -s ~/code/MySettings/zshenv ~/.zshenv
ln -s ~/code/MySettings/zshrc ~/.zshrc

# openSSH
sudo pacman -S openssh
systemctl enable sshd
systemctl start sshd

# cli setup
sudo pacman -S zsh tmux fzf
yay -S 1password
chsh -s /usr/bin/zsh # set default shell
ln -s ~/code/MySettings/zshenv ~/.zshenv
ln -s ~/code/MySettings/zshrc ~/.zshrc

# general tools
# yazi file manager
pacman -S yazi 

# media tools
pacman -S mpv
