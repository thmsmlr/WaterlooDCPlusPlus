#!/bin/bash 
pushd ~/Downloads
curl -o ShakeSpeer.dmg http://shakespeer.googlecode.com/files/shakespeer-0.9.11.dmg
hdiutil attach ShakeSpeer.dmg
popd
pushd /Volumes/shakespeer-0.9.11
sudo cp -r ShakesPeer.app/ /Applications/ShakesPeer.app
sleep 5 
hdiutil detach -force /Volumes/shakespeer-0.9.11
popd 
x=`/usr/bin/osascript <<EOT
tell application "Finder"
	activate
	set myReply to text returned of (display dialog "Enter a unique username that you would like to use on DC++ (no spaces)." default answer "")
end tell
EOT`
y=`/usr/bin/osascript <<EOT
tell application "Finder"
	activate
	choose folder with prompt "Choose a folder of your media that you would like to share:"
	set jobFolder to the POSIX path of (result as alias)
end tell
EOT`

z=`echo $y | sed 's/\ /\\\\ /g'`


BASEDIR=$(dirname $0)
defaults write $BASEDIR/se.hedenfalk.shakespeer nick -string $x
defaults write $BASEDIR/se.hedenfalk.shakespeer sharedPaths -array "$z"
sudo cp -p $BASEDIR/se.hedenfalk.shakespeer.plist ~/Library/Preferences

