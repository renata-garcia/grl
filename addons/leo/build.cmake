# Setup build environment
set(TARGET addon_leo)

set(WORKSPACE_DIR ${SRC}/../../../externals/odesim)

find_package(PkgConfig)

SET(QT_USE_QTOPENGL TRUE)
find_package(Qt4 COMPONENTS QtCore QtGui QtOpenGL)

if (PKG_CONFIG_FOUND AND QT4_FOUND)
  pkg_check_modules(TINYXML tinyxml)
  pkg_check_modules(MUPARSER muparser)
  pkg_check_modules(ODE ode)

  if (TINYXML_FOUND AND MUPARSER_FOUND AND ODE_FOUND)
    set(GRL_BUILD_LEO ON CACHE BOOL "Build leo addon")
  else()
    message("** Cannot build leo addon: missing one of {tinyxml, muparser, ode}")
  endif()
else()
  message("** Cannot build leo addon: missing one of {pkgconfig, qt4}")
endif()

if (GRL_BUILD_LEO)
  message("** Building leo addon")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC")

  # Build library
  add_library(${TARGET} SHARED
                        ${SRC}/leo.cpp
                        ${SRC}/leo_walk.cpp
                        ${SRC}/leo_squat.cpp
                        ${SRC}/LeoBhWalkSym.cpp
                        ${SRC}/STGLeoSim.cpp
                        ${SRC}/ThirdOrderButterworth.cpp
                        ${SRC}/state_machine.cpp
                        ${SRC}/samplers/leo_action_sampler.cpp
                        ${SRC}/agents/leo_sym_wrapper.cpp
                        ${SRC}/agents/leo_td.cpp
                        ${SRC}/agents/leo_fixed.cpp
                        ${SRC}/agents/leo_sma.cpp
                        ${SRC}/agents/leo_preprogrammed.cpp)

  include_directories(${SRC}/../include/grl/environments/leo)

  INCLUDE (${WORKSPACE_DIR}/dbl/platform/io/configuration/configuration.cmake)
  INCLUDE (${WORKSPACE_DIR}/dbl/platform/io/logging/stdlogging.cmake)
  INCLUDE (${WORKSPACE_DIR}/dbl/externals/bithacks/bithacks.cmake)

  add_definitions(-DLEO_CONFIG_DIR="${SRC}/../cfg")

  # Add dependencies
  grl_link_libraries(${TARGET} base addons/odesim)
  target_link_libraries(${TARGET})

  install(TARGETS ${TARGET} DESTINATION ${GRL_LIB_DESTINATION})
  install(DIRECTORY ${SRC}/../include/grl DESTINATION ${GRL_INCLUDE_DESTINATION} FILES_MATCHING PATTERN "*.h")
endif()
