#!/bin/bash


echo "Homebrew kurulumu başlatılıyor..."

sudo apt update
sudo apt install -y build-essential curl file git

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> ~/.profile
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

brew doctor

echo "Homebrew kurulumu tamamlandı."


#Uninstall
#/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"