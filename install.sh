#!/bin/sh

#
# Setup
#
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

echo
echo "--------------------------------------------------------------------------------"
echo "Install Meteor"
echo "--------------------------------------------------------------------------------"
curl https://install.meteor.com/ | sh

echo
echo "--------------------------------------------------------------------------------"
echo "Get application source"
echo "--------------------------------------------------------------------------------"
if [ -e ~/Desktop/source ]
then
  echo "There's already a source file at ~/Desktop/source."
  cd ~/Desktop/source && { git pull origin master; }
else
  echo "Downloading source"
  cd ~/Desktop/ && { git clone https://github.com/scimusmn/houston-lab.git ~/Desktop/source; cd - ; }
fi

if [ ! -e ~/Desktop/source/config/settings.json ]
then
  echo "Setup default config file for Meteor source"
  cp ~/Desktop/source/config/settings.default.json ~/Desktop/source/config/settings.json
fi

echo "--------------------------------------------------------------------------------"
echo "Setup Stele"
echo "--------------------------------------------------------------------------------"
if [ -e ~/Desktop/stele ]
then
  echo "Stele is already installed. Just going to check that it's up to date."
  cd ~/Desktop/stele && { git pull origin master; }
else
  echo "Downloading Stele"
  cd ~/Desktop/ && { git clone https://github.com/scimusmn/stele.git ~/Desktop/stele; cd - ; }
fi

if [ ! -e ~/Desktop/stele/cfg/browser.cfg ]
then
  echo "Setup default config file for Stele"
  cp ~/Desktop/stele/cfg/browser.cfg.default ~/Desktop/stele/cfg/browser.cfg
else
  echo "Stele is already configured"
fi

#
# Click script
# We use this to ensure that Stele has full focus to prevent the menu bar
# and the dock from showing.
#
cp $DIR/assets/click.sh ~/Desktop/
chmod +x ~/Desktop/click.sh

echo
echo "--------------------------------------------------------------------------------"
echo "Setup system startup items"
echo "--------------------------------------------------------------------------------"
# Install LaunchAgents to start everything up when the computer boots
echo "Install LaunchAgents."
cp $DIR/assets/launchd/* ~/Library/LaunchAgents/

echo
echo "--------------------------------------------------------------------------------"
echo "Manual steps"
echo "--------------------------------------------------------------------------------"
echo "You have to do two things manually to finalize the setup"
echo "Google Analytics setup - Manually add your GA project ID with:"
echo " - vi ~/Desktop/source/config/settings.json"
echo "Stele setup - Manually set the home URL"
echo " - vi ~/Desktop/stele/cfg/browser.cfg"

