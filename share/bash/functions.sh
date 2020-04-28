#!/usr/bin/env bash

source_file() {
  local -r file_name="$1"

  [ -f "${file_name}" ] && source "${file_name}"
}
