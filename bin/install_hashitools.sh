#!/usr/bin/env bash
set -e
CIRCLECI_CACHE_DIR="${HOME}/bin"
PROD=$1
VER=$2

URL="https://releases.hashicorp.com/${PROD}/${VER}/${PROD}_${VER}_linux_amd64.zip"

download() {
  wget -O "/tmp/${PROD}.zip" "${URL}"
  unzip -o -d "${CIRCLECI_CACHE_DIR}" "/tmp/${PROD}.zip"
}

[[ -f "${CIRCLECI_CACHE_DIR}/${PROD}" ]] || (echo not installed; download)

current_version=$($PROD version | sed -n 's/^.*v\(.*\)/\1/p')
[[ "${current_version}" != "${VER}" ]] && (echo out of date; download)

$PROD version
