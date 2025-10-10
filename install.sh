#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

echo "--- Processing nlohmann_json ---"
JSON_NAME="nlohmann-json" # Уточнил имя, так как папка называется 'json'
JSON_URL="https://github.com/nlohmann/json"
JSON_TAG="v3.12.0" # Указываем нужный тег

DownloadDependency() {
  DEP_NAME=$1
  DEP_GIT_TAG=$2
  DEP_GIT_URL=$3
  ADDITIVE_ARCHIVE_GIT_URI=$4

  if [ -z "$4" ]; then
    ADDITIVE_ARCHIVE_GIT_URI="archive/refs/tags"
  fi

#if [[ -n WUDGINE_ROOT ]]; then
#  SCRIPT_DIR="$(cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")" && pwd)"
#  WUDGINE_ROOT=$(realpath "${SCRIPT_DIR}/../../.wudgine")
#fi

  DEPS_SOURCES_DIR="${WUDGINE_ROOT}/.deps"

  echo "Install ${DEP_NAME}..."


  if [ -d "${DEPS_SOURCES_DIR}/${DEP_NAME}" ]; then
    echo "Dependency ${DEP_NAME} already was successfully installed."
    return;
  fi

#  cd "${DEPS_SOURCES_DIR}"
#  git clone "${DEP_GIT_URL}" "${DEPS_SOURCES_DIR}/${DEP_NAME}.git" || { echo "Error: Failed to install ${DEP_NAME}."; exit 1; }
#  echo "Dependency ${DEP_NAME} install successfully."
#  echo "Updating and pinning ${DEP_NAME} to tag ${DEP_GIT_TAG}..."
#  cd "${DEPS_SOURCES_DIR}/${DEP_NAME}" || { echo "Error: Dependency directory for ${DEP_NAME} not found."; exit 1; }
#  git fetch origin
#  git checkout "${DEP_GIT_TAG}" || { echo "Error: Failed to checkout tag ${DEP_GIT_TAG} for ${DEP_NAME}. Does it exist?"; exit 1; }
#  echo "${DEP_NAME} pinned to tag ${DEP_GIT_TAG}."
#  cd "${DEPS_INSTALL_DIR}"


echo "DEPS_SOURCES_DIR = ${DEPS_SOURCES_DIR}"
mkdir -p "${DEPS_SOURCES_DIR}"

  cd "${DEPS_SOURCES_DIR}"
  if [[ ! -d $$DEP_NAME ]]; then

  # Correct: Use git clone to get the repository as a folder.
  git clone --branch "${DEP_GIT_TAG}" --depth 1 "${DEP_GIT_URL}" "${DEPS_SOURCES_DIR}/${DEP_NAME}" || {
      echo "Error: Failed to clone ${DEP_NAME}."
      exit 1
  }

#    Q_PATH="${DEP_GIT_URL}/${ADDITIVE_ARCHIVE_GIT_URI}/${DEP_GIT_TAG}.zip"
#    echo "Q_PATH = ${Q_PATH}"
#    curl -L ${Q_PATH} -o ${DEP_NAME}.zip
#    unzip ${DEP_NAME}.zip >/dev/null
#    new_folder=$(unzip -l ${DEP_NAME}.zip | awk '/\/$/ {print $4}' | head -n1 | cut -d/ -f1)
#    echo "📂 Extracted folder: $new_folder"
#    mv $new_folder $DEP_NAME
#    rm -f ${DEP_NAME}.zip
  fi
  cd "${DEPS_INSTALL_DIR}"
}

if [[ ! "$1" == "Build" ]]; then
#  Build "${JOLT_NAME}" "${JOLT_SOURCE_DIR}" "${JOLT_BUILD_DIR}" "${JOLT_INSTALL_DIR}"
#else
  DownloadDependency "${JSON_NAME}" "${JSON_TAG}" "${JSON_URL}"
fi
