# GENERIC CMAKE 
project(XUL_TEMPLATE LANGUAGES CXX)
cmake_minimum_required(VERSION 3.10)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOUIC OFF)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_FLAGS "-lX11 -lpthread ${CMAKE_CXX_FLAGS} ${Qt5Widgets_EXECUTABLE_COMPILE_FLAGS}") # added X11 and pthread (only linux support)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/bin")
set(CMAKE_PREFIX_PATH "/opt/Qt/5.12.5/gcc_64/lib/cmake") # CHANGE THIS TO YOUR QT VERSION

# COMPILE CONFIGURATIONS
set(XUL_TEMPLATE_DEBUG ON)# USE THIS TO CONTROL VERBOSE MESSAGES
set(XUL_TEMPLATE_TARGET "Linux")# USE THIS FOR PLATFORM SELECTION
set(APP_DEPLOY_MODE "Debug")# USE THIS TO DEFINE HOW YOUR CODE WILL BE COMPILED

# TERMINAL INPUT ARG DEFINED IN CODE (CMAKE CONFIGURE) TEMPLATE
#   ...
# 	cmake  ../ -DCMAKE_BUILD_TYPE=Release 
#		   -DCMAKE_C_COMPILER=/usr/bin/x86_64-linux-gnu-gcc-8
# 		   -DCMAKE_CXX_COMPILER=/usr/bin/x86_64-linux-gnu-g++-8 
#		   -DXUL_CMAKE_ARG1="EXAMPLE" <-------------------------- DEFINED HERE !!!  
# 	cmake --build ./ --config Release --target clean -- -j 10 
#   ...

if(NOT ${XUL_CMAKE_ARG1} STREQUAL  "")
	message("XUL_CMAKE_ARG1: ${XUL_CMAKE_ARG1}")
	add_definitions(-DXUL_CMAKE_ARG1="${XUL_CMAKE_ARG1}")
else()
	message(WARNING "XUL_CMAKE_ARG1: NOT SPECIFIED")
endif()

# DEFINITIONS AND PRE COMPILE LOGIC
add_definitions(-D${APP_DEPLOY_MODE}="true")
if(NOT ${XUL_TEMPLATE_TARGET} STREQUAL  "")
	message("[CURRENT TEMPLATE TARGET : ${XUL_TEMPLATE_TARGET}]")
	add_definitions(-DXUL_TEMPLATE_TARGET="${XUL_TEMPLATE_TARGET}")
else()
	message(FATAL_ERROR "XUL_TEMPLATE_TARGET NOT SPECIFIED")
endif()

#QT STUFF
find_package(Qt5 COMPONENTS Core Quick Widgets REQUIRED)
include_directories(${Qt5Widgets_INCLUDE_DIRS} ${QtQml_INCLUDE_DIRS} ${QT_5_PATH})
add_definitions(${Qt5Widgets_DEFINITIONS} ${QtQml_DEFINITIONS} ${Qt5Quick_DEFINITIONS} )

if(${XUL_TEMPLATE_DEBUG})
	message("[DEBUG MESSAGES ON]")
	message(WARNING "TEMPLATE TARGET: ${XUL_TEMPLATE_TARGET}")
	message(WARNING "TEMPLATE DEPLOY MODE: ${APP_DEPLOY_MODE}")
	message("QT PREFIX PATH:\n [${CMAKE_PREFIX_PATH}]")
	message("Include QT dirs:\n ${Qt5Widgets_INCLUDE_DIRS} ${QtQml_INCLUDE_DIRS}")
	message("QT definitions:\n ${Qt5Widgets_DEFINITIONS} ${QtQml_DEFINITIONS} ${Qt5Quick_DEFINITIONS}")
endif()

#TEMPLATE APP SOURCES and RESOURCES
file(GLOB_RECURSE XUL_TEMPLATE_SOURCES "template-app/*.cpp")
file(GLOB_RECURSE XUL_TEMPLATE_HEADERS "template-app/include/*.h")
set(XUL_TEMPLATE_RESOURCES "template-app/resources/qml.qrc")

#-------------------------------------------------------------------------------------------------
# XUL TEMPLATE EXECUTABLE (QT5) 
#-------------------------------------------------------------------------------------------------
add_executable(XUL_TEMPLATE ${XUL_TEMPLATE_HEADERS} ${XUL_TEMPLATE_SOURCES} ${XUL_TEMPLATE_RESOURCES})
target_link_libraries(XUL_TEMPLATE PUBLIC Qt5::Core Qt5::Quick Qt5::Widgets)


