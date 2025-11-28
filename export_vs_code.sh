#!/bin/bash

VSCODE_PATH=$1


cp $VSCODE_PATH/User/keybindings.json ./vscode
cp $VSCODE_PATH/User/settings.json ./vscode
cp -r $VSCODE_PATH/User/snippets ./vscode/

code --list-extensions > ./vscode/extensions.txt
