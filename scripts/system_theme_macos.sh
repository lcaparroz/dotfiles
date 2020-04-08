#!/bin/bash

readonly DARK_THEME="challenger_deep"
readonly LIGHT_THEME="seoul256_light"
readonly CURRENT_TIME="$(date +%k%M)"

if [ "${CURRENT_TIME}" -ge 700 ] && [ "${CURRENT_TIME}" -lt 2000 ]
then
  launchctl setenv SYSTEM_THEME "${LIGHT_THEME}"
else
  launchctl setenv SYSTEM_THEME "${DARK_THEME}"
fi
