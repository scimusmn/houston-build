#!/bin/sh

#
# Setup
#
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

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

if [ ! -e ~/Desktop/source/config/settings.json]
then
  echo "Setup default config file for Meteor source"
  cp ~/Desktop/source/config/settings.default.json ~/Desktop/source/config/settings.json
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
