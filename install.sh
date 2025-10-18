#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

DownloadDependency() {
  DEP_NAME=$1
  DEP_GIT_TAG=$2
  DEP_GIT_URL=$3
  ADDITIVE_ARCHIVE_GIT_URI=$4

  if [ -z "$4" ]; then
    ADDITIVE_ARCHIVE_GIT_URI="archive/refs/tags"
  fi

  echo "Install ${DEP_NAME}..."


  if [ -d "${THIRD_PARTY_DEPS_SOURCES_DIR}/${DEP_NAME}" ]; then
    echo "Dependency ${DEP_NAME} already was successfully installed."
    return;
  fi

echo "PKG_VERSION = ${PKG_VERSION}"
mkdir -p "${THIRD_PARTY_DEPS_SOURCES_DIR}"

  cd "${THIRD_PARTY_DEPS_SOURCES_DIR}"
  if [[ ! -d $$DEP_NAME ]]; then

echo "git command = git clone --branch ${DEP_GIT_TAG} --depth 1 ${DEP_GIT_URL} ${THIRD_PARTY_DEPS_SOURCES_DIR}/${DEP_NAME}"

  # Correct: Use git clone to get the repository as a folder.
  git clone --branch "${DEP_GIT_TAG}" --depth 1 "${DEP_GIT_URL}" "${THIRD_PARTY_DEPS_SOURCES_DIR}/${DEP_NAME}" || {
      echo "Error: Failed to clone ${DEP_NAME}."
      exit 1
  }

  fi
  cd "${DEPS_INSTALL_DIR}"
}

DepInstall() {
  DEP_NAME=$1
  DEP_GIT_URL=$2
  DEP_GIT_TAG=$3

  DownloadDependency "${DEP_NAME}" "${DEP_GIT_TAG}" "${DEP_GIT_URL}"
}

DepInstall "com.third_party.nlohmann_json" "https://github.com/nlohmann/json" "v${PKG_VERSION}"
