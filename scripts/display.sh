#!/usr/bin/env bash

# Basic actions funcions
turn_display_on() {
  local -r display="$1"

  [ -n "${display}" ] && xrandr --output "${display}" --auto
}

turn_display_off() {
  local display="$1"

  [ -n "${display}" ] && xrandr --output "${display}" --off
}

# Primary display actions functions
turn_primary_on() {
  turn_display_on "${PRIMARY_DISPLAY}"
}

turn_primary_off() {
  turn_display_off "${PRIMARY_DISPLAY}"
}

# Secondary display actions functions
turn_secondary_on() {
  turn_display_on "${SECONDARY_DISPLAY}"
}

turn_secondary_off() {
  turn_display_off "${SECONDARY_DISPLAY}"
}

turn_secondary_on_relative_to_primary() {
  local -r position="$1"

  if [ -z "${PRIMARY_DISPLAY}" ] || [ -z "${SECONDARY_DISPLAY}" ]
  then
    return 1
  fi

  case "${position}" in
    above)
      xrandr --output "${SECONDARY_DISPLAY}" --auto \
        --above "${PRIMARY_DISPLAY}"
      ;;
    below)
      xrandr --output "${SECONDARY_DISPLAY}" --auto \
        --below "${PRIMARY_DISPLAY}"
      ;;
    left)
      xrandr --output "${SECONDARY_DISPLAY}" --auto \
        --left-of "${PRIMARY_DISPLAY}"
      ;;
    right)
      xrandr --output "${SECONDARY_DISPLAY}" --auto \
        --right-of "${PRIMARY_DISPLAY}"
      ;;
    mirror)
      xrandr --output "${SECONDARY_DISPLAY}" --auto \
        --same-as "${PRIMARY_DISPLAY}"
      ;;
    *)
      return 1
      ;;
   esac
}

# Extract display names
PRIMARY_DISPLAY="$(xrandr -q | grep -iE "\bprimary\b" | cut -d' ' -f1)"
export PRIMARY_DISPLAY

connected_displays="$(xrandr -q | grep -iE "\bconnected\b")"

if [ "$(echo "${connected_displays}" | wc -l)" -eq 2 ]
then
  SECONDARY_DISPLAY="$(echo "${connected_displays}" \
    | grep -iEv "\bprimary\b" | cut -d' ' -f1)"

  export SECONDARY_DISPLAY
else
  export SECONDARY_DISPLAY=""
fi

# Display actions (command line argument)
display_action="$1"

case "${display_action}" in
  only1)
    turn_primary_on && turn_secondary_off || exit 1
    ;;
  only2)
    turn_secondary_on && turn_primary_off || exit 1
    ;;
  2above1)
    turn_secondary_on_relative_to_primary above || exit 1
    ;;
  2below1)
    turn_secondary_on_relative_to_primary below || exit 1
    ;;
  2left1)
    turn_secondary_on_relative_to_primary left || exit 1
    ;;
  2right1)
    turn_secondary_on_relative_to_primary right || exit 1
    ;;
  2mirror1)
    turn_secondary_on_relative_to_primary mirror || exit 1
    ;;
  *)
    echo "Invalid display action"
    exit 1
    ;;
esac
