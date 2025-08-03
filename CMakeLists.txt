cmake_minimum_required(VERSION 3.16)
project(mongoose C)

# Use passed-in executable name or fallback
if(NOT DEFINED EXECUTABLE_NAME)
    set(EXECUTABLE_NAME ${PROJECT_NAME})
endif()

add_executable(${EXECUTABLE_NAME} src/main.c)