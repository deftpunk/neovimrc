#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Neovide
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName Neovide
# @raycast.argument1 { "type": "dropdown", "placeholder": "directory", "data": [{"title": "devtools", "value": "~/WorkStuff/eig/devtools"}]}

# Documentation:
# @raycast.description Open another neovide instance

# open --new -b com.neovide.neovide --args "~/WorkStuff/eig/devtools-master/"
open --new -b com.neovide.neovide
