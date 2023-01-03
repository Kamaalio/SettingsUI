#!/bin/sh

echo "listing available Xcode versions:"
ls -d /Applications/Xcode*

sudo xcode-select --switch /Applications/$XCODE_APP_NAME/Contents/Developer