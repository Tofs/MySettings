# prepare computer
echo "Update APT"
apt update
apt upgrade

#intall vim
echo "Install VIM" 
apt install vim

#install awesome and xdr for remote desktop
echo "Installing Awesome window manager"
apt install awesome
apt install stterm

echo "Install XRDP"
apt install xrdp
adduser xrdp ssl-cert
cp -f .xsession ~/.xsession
systemctl restart xrdp


#installing firefox
apt install firefox

#installing visual studio code
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
apt-get install apt-transport-https
apt-get update
apt-get install code # or code-insiders



