# Setup build environment
set(TARGET grl)

# Make library
add_library(${TARGET} SHARED
            ${SRC}/grl.cpp
            ${SRC}/agents/fixed.cpp
            ${SRC}/agents/black_box.cpp
            ${SRC}/agents/td.cpp
            ${SRC}/agents/dyna.cpp
            ${SRC}/agents/master.cpp
            ${SRC}/agents/compartmentalized.cpp
            ${SRC}/configurable.cpp
            ${SRC}/discretizers/uniform.cpp
            ${SRC}/environments/observation.cpp
            ${SRC}/environments/modeled.cpp
            ${SRC}/environments/pendulum.cpp
            ${SRC}/environments/cart_pole.cpp
            ${SRC}/environments/pinball.cpp
            ${SRC}/environments/windy.cpp
            ${SRC}/environments/compass_walker/SWModel.cpp
            ${SRC}/environments/compass_walker/compass_walker.cpp
            ${SRC}/experiments/approx_test.cpp
            ${SRC}/experiments/online_learning.cpp
            ${SRC}/experiments/batch_learning.cpp
            ${SRC}/policies/random.cpp
            ${SRC}/policies/action.cpp
            ${SRC}/policies/q.cpp
            ${SRC}/policies/bounded_q.cpp
            ${SRC}/policies/parameterized.cpp
            ${SRC}/policies/pid.cpp
            ${SRC}/policies/mcts.cpp
            ${SRC}/predictors/model.cpp
            ${SRC}/predictors/sarsa.cpp
            ${SRC}/predictors/ggq.cpp
            ${SRC}/predictors/ac.cpp
            ${SRC}/predictors/fqi.cpp
            ${SRC}/predictors/qv.cpp
            ${SRC}/projectors/identity.cpp
            ${SRC}/projectors/normalizing.cpp
            ${SRC}/projectors/tile_coding.cpp
            ${SRC}/projectors/fourier.cpp
            ${SRC}/representations/linear.cpp
            ${SRC}/representations/multisine.cpp
            ${SRC}/representations/ann.cpp
#            ${SRC}/representations/dmp.cpp
            ${SRC}/samplers/greedy.cpp
            ${SRC}/samplers/softmax.cpp
            ${SRC}/traces/enumerated.cpp
            ${SRC}/visualizations/pendulum.cpp
            ${SRC}/visualizations/cart_pole.cpp
            ${SRC}/visualizations/compass_walker.cpp
           )

# Dependencies
target_link_libraries(${TARGET} -lpthread -ldl)
grl_link_libraries(${TARGET} externals/yaml-cpp externals/itc)
install(TARGETS ${TARGET} DESTINATION ${GRL_LIB_DESTINATION})
install(DIRECTORY ${SRC}/../include/grl DESTINATION ${GRL_INCLUDE_DESTINATION} FILES_MATCHING PATTERN "*.h")

# Deployer
set (TARGET grld)
add_executable(${TARGET} ${SRC}/deployer.cpp)
grl_link_libraries(${TARGET} base)
install(TARGETS ${TARGET} DESTINATION ${GRL_BIN_DESTINATION})

# Requestgen
set (TARGET grlg)
add_executable(${TARGET} ${SRC}/requestgen.cpp)
grl_link_libraries(${TARGET} base)
install(TARGETS ${TARGET} DESTINATION ${GRL_BIN_DESTINATION})

install(CODE "execute_process(COMMAND ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/grlg ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/requests.yaml)")
install(FILES ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/requests.yaml DESTINATION ${GRL_BIN_DESTINATION})
