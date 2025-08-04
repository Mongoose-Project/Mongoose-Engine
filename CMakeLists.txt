cmake_minimum_required(VERSION 3.16)
project(mongoose C)

# Enable compile_commands.json generation
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Use passed-in executable name or fallback
if(NOT DEFINED EXECUTABLE_NAME)
    set(EXECUTABLE_NAME ${PROJECT_NAME})
endif()

# Find Python 3 (includes Interpreter, Development headers, and libraries)
find_package(Python3 REQUIRED COMPONENTS Interpreter Development)

# Add your executable
add_executable(${EXECUTABLE_NAME} src/main.c)

# Include Python headers
target_include_directories(${EXECUTABLE_NAME} PRIVATE ${Python3_INCLUDE_DIRS})

# Link Python libraries
target_link_libraries(${EXECUTABLE_NAME} PRIVATE ${Python3_LIBRARIES})

# Optional: Print out paths for debugging
message(STATUS "Python3 include dirs: ${Python3_INCLUDE_DIRS}")
message(STATUS "Python3 libraries: ${Python3_LIBRARIES}")
