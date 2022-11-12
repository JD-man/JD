#!/usr/bin/env sh

# Configuration
XCODE_TEMPLATE_DIR=$HOME'/Library/Developer/Xcode/Templates/File Templates/JDA'
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Copy file templates into the local template directory
xcodeTemplate () {
  echo "==> Copying up Xcode file JDA templates..."

  if [ -d "$XCODE_TEMPLATE_DIR" ]; then
    rm -R "$XCODE_TEMPLATE_DIR"
  fi
  mkdir -p "$XCODE_TEMPLATE_DIR"

  cp -R $SCRIPT_DIR/*.xctemplate "$XCODE_TEMPLATE_DIR"
}

xcodeTemplate

echo "==> ... success!"
echo "==> JDA have been set up. In Xcode, select 'New File...' to use JDA templates."