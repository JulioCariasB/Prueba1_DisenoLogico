cmake_minimum_required (VERSION 3.0)
project (test_piano)

if ( ${CMAKE_SOURCE_DIR} STREQUAL ${CMAKE_BINARY_DIR} )
    message( FATAL_ERROR "In-source builds not allowed. Please make a new directory (called a build directory) and run CMake from there. You may need to remove CMakeCache.txt." )
endif()

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include_directories(${CMAKE_CURRENT_BINARY_DIR})
include_directories(${PROJECT_SOURCE_DIR}/..)
 
add_executable(${PROJECT_NAME}  ${PROJECT_SOURCE_DIR}/../SineWave.cpp
                                ${PROJECT_NAME}.cpp)

target_link_libraries(${PROJECT_NAME} ${VERILOG_LIB})
