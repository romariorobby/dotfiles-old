#!/bin/sh
info(){
    dialog --title "$1" --infobox "$2" 5 70
} 
set -euo pipefail

echo "Post Configuration" "Activating SKHD"
[ -x "$(command -v "skhd")" ] && brew services start skhd || brew services restart skhd
[ $? == 0 ] &&  echo "Post Configuration" "SKHD Activated"

echo "Post Configuration" "Set Default style to Dark Mode"
defaults write NSGlobalDomain AppleInterfaceStyle Dark
echo "Post Configuration" "Set Default Locale to en_US"
defaults write NSGlobalDomain AppleLocale en_US

echo ""
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
echo "Close any open Systyem Preferences panes, to prevent them from overiding"
osascript -e 'tell application "System Preferences" to quit'

# echo "Ask for root password upfront" 
# sudo -v

echo "Keep-alive: update existing \`sudo\` time stamp until \`.macos\` has finished"
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "Keyboard: Disable press-and-hold for keys in favor of key repeat"
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
echo "Keyboard: Set a blazingly fast keyboard repeat rate"
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 15

echo "Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)"
defaults write com.apple.screencapture type -string "png"

echo "Disable the “Are you sure you want to open this application?” dialog"
defaults write com.apple.LaunchServices LSQuarantine -bool false

# effected when SystemUIServer restarted 
echo "Trackpad: enable tap to click for this user and for the login screen"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

echo "Avoid creating .DS_Store files on network or USB volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

echo "+++++++++FINDER+++++++++"
echo "Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons"
defaults write com.apple.finder QuitMenuItem -bool true

echo "Finder: show hidden files by default"
defaults write com.apple.finder AppleShowAllFiles -bool true
echo "Finder: set default finder location to $HOME"
defaults write com.apple.finder NewWindowTarget -string "PfLo" &&
	defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"
# killall Finder

echo "Finder: show path bar"
defaults write com.apple.finder ShowPathbar -bool true

echo "Finder: show all filename extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true


echo "+++++++++SAFARI+++++++++"
echo "Safari: Privacy: don’t send search queries to Apple"
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

echo "Safari: Privacy: Enable Do Not Track"
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

echo "Safari: Set Safari’s home page to \`about:blank\` for faster loading"
defaults write com.apple.Safari HomePage -string "about:blank"

echo "+++++++++DOCK+++++++++"
echo "Dock: Automatically hide and show the Dock"
defaults write com.apple.dock autohide -bool true

echo "Dock: Don't animate opening application from the dock"
defaults write com.apple.dock launchanim -bool false

echo "Hammerspoon: Change default configuration to $HOME/.config/hammerspoon"
defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"

echo "Dock: Remove the auto-hiding Dock delay"
defaults write com.apple.dock autohide-delay -float 0

echo "Dock: Remove the animation when hiding/showing the Dock"
defaults write com.apple.dock autohide-time-modifier -float 0

echo "Dock: Don’t show recent applications in Dock"
defaults write com.apple.dock show-recents -bool false
echo "Dock: Orientation (left,right,bottom)"
defaults write com.apple.dock orientation left
# Remove $dockItemLabel from Dock
[ -x $(command -v "dockutil" ) ] & echo "Dockutil Ready" || brew install dockutil
for dockItemLabel in \
	Safari \
	Mail \
	FaceTime \
	Messages \
	Maps \
	Photos \
	Contacts \
	Calendar \
	Reminders \
	Notes \
	Music \
	Podcasts \
	TV \
	News \
	Numbers \
	Keynote \
	Pages \
	"App Store"; do
    echo "remove $dockItemLabel from dock"
    echo "================"
	dockutil --find "$dockItemLabel" >/dev/null && dockutil --no-restart --remove "$dockItemLabel"
done
killall Dock

echo "Killing Finder..."
killall Finder
echo "Killing SystemUIServer"
killall SystemUIServer

echo "Done. Note that some of these changes require a logout/restart to take effect."
