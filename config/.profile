#!/bin/bash

# Remap Caps Lock to Control, use Right Alt as the compose key
setxkbmap -model pc105 -layout us -option -option "ctrl:nocaps,compose:ralt"
