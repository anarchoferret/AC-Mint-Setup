#!/bin/bash

#Run this script to set up a new ubuntu computer for the Math Outreach Center.
#written by: Joshua Allen
#Modified by Skylar Preston (AnarchoFerret)
# run with the command:  ./setup.sh

#first update
sudo apt update;
yes | sudo apt upgrade;
flatpak update -y;

#Remove deb Firefox (It's slow)
sudo apt remove firefox -y
flatpak install flathub org.mozilla.firefox

#install google chrome
flatpak install flathub com.google.Chrome -y;

#install Discord
flatpak install flathub com.discordapp.Discord -y;

#install Zoom
flatpak install flathub us.zoom.Zoom -y;

#enable auto updates and ensure that they happen
#yes | sudo apt install crontab
#sudo crontab ./crontab.bak
#sudo rtcwake -m no -u -t "$(date -u -d 'tomorrow 00:00:00' '+%s')"
#sudo dpkg-reconfigure --priority=low unattended-upgrades



#Add user student
#sudo adduser student

#copy necessary files
FILE=ac_logo_white.png
if [ -e ./$FILE ]; then
    sudo cp ./$FILE /usr/share/backgrounds/
fi
FILE=student-setup-mint.sh
if [ -e ./$FILE ]; then
    sudo cp ./$FILE /home/student
fi

#Ensure the time is set properly
#gsettings set com.canonical.indicator.datetime timezone-name 'America/Chicago Amarillo';
#gsettings set org.gnome.desktop.datetime automatic-timezone true;
gsettings set org.cinnamon.desktop.interface clock-use-24h false;


#Desktop settings
#Add Firefox and Google Chrome desktop icons
#FILE=firefox.desktop
#if [ -e /usr/share/applications/$FILE ]; then
#    cp /usr/share/applications/$FILE ~/Desktop
#    chmod 711 ~/Desktop/$FILE
#fi
#FILE=google-chrome.desktop
#if [ -e /usr/share/applications/$FILE ]; then
#    cp /usr/share/applications/$FILE ~/Desktop
#    chmod 711 ~/Desktop/$FILE
#fi

gsettings set org.cinnamon.desktop.interface gtk-theme Mint-Y-Red
gsettings set org.cinnamon.desktop.interface icon-theme Mint-Y-Dark-Sand
gsettings set org.cinnamon.theme name Mint-Y-Dark

#Set Natural scrolling
gsettings set org.cinnamon.settings-daemon.peripherals.touchpad natural-scroll false

#Set the background
gsettings set org.cinnamon.desktop.background primary-color '#02023c3c8888'
gsettings set org.cinnamon.desktop.background color-shading-type 'solid'
FILE=ac_logo_white.png
if [ -e /usr/share/backgrounds/$FILE ]; then
    gsettings set org.cinnamon.desktop.background picture-uri 'file:///usr/share/backgrounds/ac_logo_white.png'
fi
gsettings set org.cinnamon.desktop.background picture-options 'centered'


#Power Settings
#Never turn off screen when inactive.
gsettings set org.cinnamon.desktop.session idle-delay 0;

#Never lock the screen
gsettings set org.cinnamon.desktop.screensaver lock-enabled false;

#Dont require password from suspend
gsettings set org.cinnamon.desktop.screensaver lock-on-suspend false;

#Dont suspend on lid closed
gsettings set org.cinnamon.settings-daemon.plugins.power lid-close-ac-action 'nothing';
gsettings set org.cinnamon.settings-daemon.plugins.power lid-close-battery-action 'nothing';

#Only suspend when inactive for 30 min
gsettings set org.cinnamon.settings-daemon.plugins.power sleep-inactive-ac-timeout 1800;
gsettings set org.cinnamon.settings-daemon.plugins.power sleep-inactive-battery-timeout 1800;


#Clean up
#Remove google chrome deb file from the directory that ran the program
#rm -f ./google*.deb
