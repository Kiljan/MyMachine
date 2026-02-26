#!/bin/bash
FONTS=$HOME/.local/share/fonts/ttf/CascadiaMono/CaskaydiaMonoNerdFont

#Packages install
cat packages_list | sudo xargs zypper install --no-confirm

#Font Install
mkdir -p $FONTS
unzip CascadiaMono.zip -d $FONTS
fc-cache -f -v

#Basic config upload
cp -avr config/i3 $HOME/.config
cp -avr config/polybar $HOME/.config
cp -avr config/picom $HOME/.config

go install golang.org/x/tools/gopls@latest
go install golang.org/x/tools/cmd/goimports@latest

echo 'export PATH=$PATH:$HOME/eclipse:$HOME/go/bin' >> ~/.bashrc source ~/.bashrc

cp config/.vimrc $HOME/.vimrc
