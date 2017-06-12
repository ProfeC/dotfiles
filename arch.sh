#!/usr/bin/env bash

echo "Installing Ruby"
sudo pacman -Syu --needed ruby ruby-bundler


echo "Installing Z Shell"
sudo pacman -Syu --needed zsh zsh-completions

echo "Setting ZSH as the default shell"
chsh -s /bin/zsh

echo "Installing web Browsers"
sudo pacman -Syu --needed chromium firefox qt5-webengine

echo "Installing Sublime Text"
sudo pacman -Syu --needed sublime-text-dev

echo "Installing S3 CMD"
sudo pacman -Syu --needed s3cmd

echo "Installing Vagrant & Virtual Box VM"
sudo pacman -Syu --needed vagrant virtualbox virtualbox-host-modules-arch

echo "Installing NodeJS"
sudo pacman -Syu --needed nodejs npm
