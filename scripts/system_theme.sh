#!/bin/bash

export_system_theme() {
  local color_theme="$1"

  local current_os
  current_os="$(uname -s)"

  if [ "${current_os}" = "Darwin" ]
  then
    launchctl setenv SYSTEM_THEME "${color_theme}"
  elif [ "${current_os}" = "Linux" ]
  then
    export SYSTEM_THEME="${color_theme}"
  fi
}

readonly DARK_THEME="challenger_deep"
readonly LIGHT_THEME="seoul256_light"
readonly CURRENT_TIME="$(date +%k%M)"

if [ "${CURRENT_TIME}" -ge 700 ] && [ "${CURRENT_TIME}" -lt 2000 ]
then
  export_system_theme "${LIGHT_THEME}"
else
  export_system_theme "${DARK_THEME}"
fi
