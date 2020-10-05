#!/usr/bin/env bash

# Check if this script is running as root
if [ "$EUID" -ne 0 ]
then
  echo " - ERROR: The Xorg configuration script must be run as root."
  exit 1
fi

# Check if the dotfiles directory env var is set (to run as root)
if [ -z "${DOTFILES_DIR}" ]
then
  echo " - ERROR: the env var \$DOTFILES_DIR must be set."
  exit 1
fi

if [ ! -d "${DOTFILES_DIR}" ]
then
  echo " - ERROR: The directory ${DOTFILES_DIR} " \
    "(\$DOTFILES_DIR) does not exist."
  exit 1
fi

# Import functions
source "${DOTFILES_DIR}/share/install/functions.sh"

# Create Xorg configuration directory and files
XORG_CONFIG_DIR="/etc/X11/xorg.conf.d"

create_directory "${XORG_CONFIG_DIR}"

read -r -p "* Install touchpad? (yes/no): " install_touchpad
if [ "${install_touchpad}" = "yes" ]
then
  create_symbolic_link "${DOTFILES_DIR}/linux/share/xorg/touchpad.conf" \
    "${XORG_CONFIG_DIR}/90-touchpad.conf"
fi

read -r -p "* Install Logitech Marble Trackball? (yes/no): " install_trackball
if [ "${install_trackball}" = "yes" ]
then
  create_symbolic_link "${DOTFILES_DIR}/linux/share/xorg/logitech_marble_trackball.conf" \
    "${XORG_CONFIG_DIR}/10-evdev.conf"
fi
