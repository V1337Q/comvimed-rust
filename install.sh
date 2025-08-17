#!/bin/bash

TARGET_DIR="$HOME/.vim/plugged"
REPO_NAME="comvimed-rust" 
echo "----------------------------------"
echo "Starting installation script"
echo "----------------------------------"
echo "Repository name: $REPO_NAME"
echo "Target directory: $TARGET_DIR"

if [ -d "$TARGET_DIR/$REPO_NAME" ]; then
    echo "!! WARNING: Installation directory exists!"
    read -p "Overwrite? (y/N) " answer
    case $answer in
        [yY]*)
            echo "Removing old directory..."
            rm -rf "$TARGET_DIR/$REPO_NAME"
            ;;
        *)
            echo "Installation canceled"
            exit 1
            ;;
    esac
fi

echo "Creating directory: $TARGET_DIR/$REPO_NAME"
mkdir -p "$TARGET_DIR/$REPO_NAME"

echo "Copying files..."
cp -r ./* "$TARGET_DIR/$REPO_NAME"/

echo "----------------------------------"
echo "Installation complete!"
echo "----------------------------------"
