# Created by the script cgal_create_cmake_script
# This is the CMake script for compiling a CGAL application.


project(Topper_)


cmake_minimum_required(VERSION 2.8)
if("${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}" VERSION_GREATER 2.8)
  if("${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}.${CMAKE_PATCH_VERSION}" VERSION_GREATER 2.8.3)
    cmake_policy(VERSION 2.8.4)
  else()
    cmake_policy(VERSION 2.8)
  endif()
endif()


find_package(CGAL QUIET COMPONENTS Core)

if ( CGAL_FOUND )
  include( ${CGAL_USE_FILE} )
  include( CGAL_CreateSingleSourceCGALProgram )
  create_single_source_cgal_program( "src/topper.cpp" )
else()
    message(STATUS "This program requires the CGAL library, and will not be compiled.")
endif()


find_program(OPENSCAD_FOUND openscad) 

if( NOT OPENSCAD_FOUND )
	message(FATAL_ERROR "This program requires OpenSCAD to run")
endif()


file(COPY ${CMAKE_SOURCE_DIR}/src/main.scad DESTINATION .)
file(COPY ${CMAKE_SOURCE_DIR}/src/variables.scad DESTINATION .)
file(COPY ${CMAKE_SOURCE_DIR}/src/infills/ DESTINATION .)
