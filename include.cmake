set(NLOHMANN_JSON_SUBMODULE_PATH "${DEPS_SOURCES_DIR}/nlohmann-json")

if(NOT EXISTS "${NLOHMANN_JSON_SUBMODULE_PATH}/CMakeLists.txt")
    message(FATAL_ERROR "Nlohmann-json submodule not found at ${NLOHMANN_JSON_SUBMODULE_PATH}. Please ensure it is added correctly and your build script is run.")
endif()

add_subdirectory("${NLOHMANN_JSON_SUBMODULE_PATH}" ${CMAKE_CURRENT_BINARY_DIR}/nlohmann_json)

#add_library(nlohmann_json::nlohmann_json ALIAS nlohmann_json)

add_library(tp::nlohmann_json ALIAS nlohmann_json)
