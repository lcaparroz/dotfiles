#!/usr/bin/env bash

# Load ~/.profile
if [ -r "${HOME}/.profile" ]
then
  source "${HOME}/.profile"
fi

# Load ~/.bashrc
if [ -r "${HOME}/.bashrc" ]
then
  source "${HOME}/.bashrc"
fi
