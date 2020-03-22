#!/usr/bin/env bash

# Functions

url_exists() {
  curl --silent --fail --output /dev/null --head "$1"
}

download_file() {
  local -r file_url="$1"
  local -r file_path="$2"

  curl --silent --fail --output "${file_path}" "${file_url}"
}

download_dictionary_files() {
  local -r dictionary_base_url="$1"
  local -r dictionary_name="$2"

  # .aff files parameters
  local -r aff_file="${dictionary_name}.aff"
  local -r aff_file_path="${DICPATH}/${aff_file}"
  local -r aff_file_url="${dictionary_base_url}/${aff_file}"

  # .dic files parameters
  local -r dic_file="${dictionary_name}.dic"
  local -r dic_file_path="${DICPATH}/${dic_file}"
  local -r dic_file_url="${dictionary_base_url}/${dic_file}"

  # For a dictionary to work w/ hunspell, it must have both .aff and .dic files
  if url_exists "$aff_file_url" && url_exists "$dic_file_url"
  then
    echo " * Downloading ${dictionary_name} files..."

    if download_file "${aff_file_url}" "${aff_file_path}" \
        && download_file "${dic_file_url}" "${dic_file_path}"
    then
      echo "   SUCCESS: ${dictionary_name} files downloaded."
      return 0
    else
      rm -rf "${aff_file_path}"
      rm -rf "${dic_file_path}"
      return 1
    fi
  else
    echo " - ERROR: 'curl' could not download at least one of these:"
    echo "   ${aff_file_url}"
    echo "   ${dic_file_url}"
    return 1
  fi
}

# Check dictionaries directory
if [ -z "${DICPATH}" ]
then
  echo " - ERROR: The env var \$DICPATH must be set."
  exit 1
fi

if [ ! -d "${DICPATH}" ]
then
  echo " - ERROR: The directory ${DICPATH} (\$DICPATH) does not exist."
  exit 1
fi

# Check dictionary entry format
DICT_ENTRY=$1

if echo "$DICT_ENTRY" | grep -qE "^[a-z]{2}_[A-Z]{2}$"
then
  DICT_LANGUAGE="$(echo "$DICT_ENTRY" | cut -d'_' -f1)"
else
  echo " - ERROR: a dictionary entry must be in the format 'xx_XX'"
  exit 1
fi

DICT_SOURCE_URL="https://cgit.freedesktop.org/libreoffice/dictionaries/plain"
DICT_PRIMARY_BASE_URL="${DICT_SOURCE_URL}/${DICT_ENTRY}"
DICT_ALT_BASE_URL="${DICT_SOURCE_URL}/${DICT_LANGUAGE}"

# Check dictionaries base URL (some may not have the locale _XX suffix)
if url_exists "${DICT_PRIMARY_BASE_URL}"
then
  DICT_BASE_URL="${DICT_PRIMARY_BASE_URL}"
elif url_exists "${DICT_ALT_BASE_URL}"
then
  DICT_BASE_URL="${DICT_ALT_BASE_URL}"
fi

download_dictionary_files "${DICT_BASE_URL}" "${DICT_ENTRY}"
