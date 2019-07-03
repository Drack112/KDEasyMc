#!/bin/bash

###
# KvantumEasyMc.
# Bootstraps a MacOS-like look with Kvantum and some of the most popular themes/icon packages available to date.
# Designed for Debian-based systems. Make this file executable first! (chmod +x ...)
# https://github.com/caglarturali/KvantumEasyMc
##

# Install dependencies/necessary packages
echo "Installing dependencies/necessary packages..."
sudo apt install git cmake g++ libx11-dev libxext-dev qtbase5-dev libqt5svg5-dev libqt5x11extras5-dev libkf5windowsystem-dev qttools5-dev-tools build-essential libkf5config-dev libkdecorations2-dev qtdeclarative5-dev extra-cmake-modules libkf5guiaddons-dev libkf5configwidgets-dev libkf5coreaddons-dev libkf5plasma-dev libsm-dev gettext extra-cmake-modules kwin-dev libdbus-1-dev
echo "Done."

# Create an temp directory and run there
TMP_DIR=$(mktemp -d)
cd $TMP_DIR

# Compile and install Kvantum
echo -e "\nInstalling Kvantum..."
git clone https://github.com/tsujan/Kvantum.git
cd Kvantum && cd Kvantum
mkdir build && cd build
cmake ..
make
sudo make install
cd $TMP_DIR
echo "Done."

# Compile and install SierraBreeze
echo -e "\nInstalling SierraBreeze..."
git clone https://github.com/ishovkun/SierraBreeze.git
cd SierraBreeze
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release -DKDE_INSTALL_LIBDIR=lib -DBUILD_TESTING=OFF -DKDE_INSTALL_USE_QT_SYS_PATHS=ON
sudo make install
cd $TMP_DIR
echo "Done."

# Compile and install Active Window Control Applet
echo -e "\nInstalling Active Window Control Applet..."
git clone git://anongit.kde.org/plasma-active-window-control
cd plasma-active-window-control
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr
make
sudo make install
cd $TMP_DIR
echo "Done."

# Compile and install Yet Another Magic Lamp
echo -e "\nInstalling Yet Another Magic Lamp..."
git clone https://github.com/zzag/kwin-effects-yet-another-magic-lamp.git
cd kwin-effects-yet-another-magic-lamp
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr
make
sudo make install
cd $TMP_DIR
echo "Done."

# Install Latte dock
echo -e "\nInstalling Latte dock..."
sudo apt install latte-dock
echo "Done."

# Install McMojave KDE Themes
echo -e "\nInstalling McMojave KDE Themes..."
git clone https://github.com/vinceliuice/McMojave-kde.git
cd McMojave-kde
# Necessary for Active Window Control applet.
sudo cp -r aurorae /usr/local/share/
# Get back on track.
./install.sh
# Install SDDM theme.
cd sddm
sudo ./install.sh
cd $TMP_DIR

# Install Mojave Gtk Theme
echo -e "\nInstalling Mojave Gtk Theme..."
git clone https://github.com/vinceliuice/Mojave-gtk-theme.git
cd Mojave-gtk-theme
sudo ./install.sh -d /usr/share/themes
cd $TMP_DIR

# Install McMojave-circle Icon Theme
echo -e "\nInstalling McMojave-circle Icon Theme..."
git clone https://github.com/vinceliuice/McMojave-circle.git
cd McMojave-circle
./install.sh
cd $TMP_DIR

# Install Capitaine Cursors
echo -e "\nInstalling Capitaine Cursors..."
mkdir $HOME/.icons
git clone https://github.com/keeferrourke/capitaine-cursors.git
cd capitaine-cursors
cp -pr dist/ $HOME/.icons/capitaine-cursors
cp -pr dist-white/ $HOME/.icons/capitaine-cursors-white
cd $TMP_DIR

# Install SF Mono Font
echo -e "\nInstalling SF Mono Font..."
mkdir -p $HOME/.fonts/SFMono
git clone https://github.com/ZulwiyozaPutra/SF-Mono-Font.git
cp SF-Mono-Font/SFMono-* $HOME/.fonts/SFMono
#sudo fc-cache -fv
cd $TMP_DIR
echo "Done."

# Apply configuration
echo -e "\nApplying configuration..."
wget -q https://github.com/caglarturali/KvantumEasyMc/raw/master/files/dotfiles.tar.gz
tar -xzf config.tar.gz -C $HOME
echo "Done."

# Delete temporary directory
echo -e "\nCleaning up..."
sudo rm -rf $TMP_DIR
echo "Done."

echo -e "\nInstallation complete! Restart your computer for the changes to take effect."
