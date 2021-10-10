#!/usr/bin/env bash

set -u

source "${HOME}/.dotfiles/share/install/functions.sh"

readonly ASSETS_TEMP_DIR="${HOME}/.dotfiles/assets/tmp"
readonly USER_FONTS_DIR="${HOME}/.local/share/fonts"

readonly GH_OWNER_EXP="([a-z1-9]|\.|-)+"
readonly GH_REPO_EXP="([a-z1-9]|\.|-)+"
readonly VERSION_EXP="v?([[:digit:]]+\.?)+[[:graph:]]*[^/]"
readonly FILENAME_EXP="[^/][[:graph:]]+([[:alnum:]]{2,}\.?)+"

github_latest_release_url() {
  local -r owner="$1"
  local -r repo="$2"

  echo "https://api.github.com/repos/${owner}/${repo}/releases/latest"
}

get_release_data() {
  local -r release_url="$1"

  local release_data

  if release_data="$(curl --fail --silent --location "${release_url}")"
  then
    echo "$release_data"
    return 0
  else
    echo "'curl' has failed the request to '${release_url}' (error code: $?)" >&2
    return 1
  fi
}

extract_assets_urls() {
  local -r release_data="$1"

  echo "$release_data" | grep -iEo \
    "https://[[:graph:]]+${GH_OWNER_EXP}/${GH_REPO_EXP}/releases/download/${VERSION_EXP}/${FILENAME_EXP}"
}

filter_asset() {
  local -r assets_urls="$1"
  local -r filename_regexp="$2"

  local -r assets="$(echo "$assets_urls" | grep -iE "${filename_regexp}$")"
  local -r assets_count="$(echo "$assets" | wc -l)"

  if [ -n "${assets}" ] && [ "${assets_count}" -gt 1 ]
  then
      echo "The regexp '${filename_regexp}' matches $assets_count assets:" >&2
      echo "$assets" | grep -iEo "[^/]+$" | sed -E "s/(.*)/ - \1/g" >&2
      return 1
  elif [ -z "${assets}" ]
  then
      echo "The regexp '${filename_regexp}' matches no assets. Availables assets are:" >&2
      echo "$assets_urls" | grep -iEo "[^/]+$" | sed -E "s/(.*)/ - \1/g" >&2
      return 1
  fi

  echo "${assets}"
}

get_latest_asset_url() {
  local -r repo_owner="$1"
  local -r repo_name="$2"
  local -r filename_regexp="$3"

  local -r gh_release_url="$(github_latest_release_url "${repo_owner}" "${repo_name}")"
  local release_data

  if ! release_data="$(get_release_data "${gh_release_url}")"
  then
    return 1
  fi

  local -r assets_urls_list="$(extract_assets_urls "$release_data")"
  local asset_url

  if ! asset_url="$(filter_asset "$assets_urls_list" "${filename_regexp}")"
  then
    return 1
  fi

  echo "$asset_url"
}

create_temp_dir() {
  if [ -d "${ASSETS_TEMP_DIR}" ]
  then
    return 0
  else
    mkdir -p "${ASSETS_TEMP_DIR}"
  fi
}

download_asset() {
  local -r repo_owner="$1"
  local -r repo_name="$2"
  local -r filename_regexp="$3"

  local asset_url
  if ! asset_url="$(get_latest_asset_url "${repo_owner}" "${repo_name}" "${filename_regexp}")"
  then
    echo "Failed to retrieve asset URL."
    return 1
  fi

  local -r file_name="$(echo "${asset_url}" | grep -iEo "[^/]+$")"
  local -r absolute_file_name="${ASSETS_TEMP_DIR}/${file_name}"

  rm -rf "${absolute_file_name}"
  create_temp_dir

  if curl --fail --silent --location --output "${absolute_file_name}" "${asset_url}"
  then
    ls "${absolute_file_name}"
    return 0
  else
    echo "'curl' has failed the request to '${asset_url}' (error code: $?)" >&2
    return 1
  fi
}

install_font_from_zip_file() {
  local -r github_owner="$1"
  local -r github_repo="$2"
  local -r filename_regexp="$3"
  local -r zip_file_regexp="${filename_regexp}\S*\.zip"
  local -r font_dir="${USER_FONTS_DIR}/${github_owner}"

  echo "=> Installing '${github_owner}/${github_repo}'"
  echo "   Downloading the asset with file expression '${filename_regexp}'"

  local asset_path
  if ! asset_path="$(download_asset "${github_owner}" "${github_repo}" "${filename_regexp}")"
  then
    echo "   Downloading the asset has failed"
    return 1
  fi
  echo "   SUCCESS: Temporary asset downloaded to '${asset_path}'"

  echo "   Checking asset with 'unzip'"
  if ! unzip -l "${asset_path}" > /dev/null 2>&1
  then
    echo " - ERROR: 'unzip' failed to check the file (error code: $?)" >&2
    return 1
  fi

  rm -rf "${font_dir}" > /dev/null 2>&1
  create_directory "${USER_FONTS_DIR}"

  echo "   Extracting '${asset_path}' to directory '${font_dir}'"
  if ! unzip -q "${asset_path}" -d "${font_dir}" > /dev/null 2>&1
  then
    echo " - ERROR: 'unzip' failed to extract the file (error code: $?)" >&2
    return 1
  fi

  echo "   Building font information"
  if ! fc-cache -fv > /dev/null 2>&1
  then
    echo " - ERROR: 'fc-cache' failed to build font information (error code: $?)" >&2
    return 1
  fi

  rm -rf "${asset_path}" > /dev/null 2>&1
  echo "   SUCCESS: '${github_repo}' installed"
}

# install_font_from_zip_file "JetBrains" "JetBrainsMono" "jetbrainsmono"
install_font_from_zip_file "ryanoasis" "nerd-fonts" "jetbrainsmono"
