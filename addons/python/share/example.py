#!/usr/bin/python3
#
# OpenAI Gym example using GRL environment
# This example must be run from its own directory, with
# grl installed to a path in LD_LIBRARY_PATH and grlpy installed
# to a path in PYTHON_PATH.

import sys, math, time 
import numpy as np
import gym
from gym.envs.registration import register
import grlenv

# Register environmnent instantiation. Every configuration file
# requires a different instantiation, as Gym does not allow passing
# parameters to an environment.
# The configuration must define an "environment" tag at the root that
# specifies the environment to be used.
register(
  id='GrlEnv-Pendulum-v0',
  entry_point='grlenv.grlenv:GrlEnv',
  kwargs={"file":"../../../cfg/matlab/pendulum_swingup.yaml"}
)

env = gym.make("GrlEnv-Pendulum-v0")
observation = env.reset()
for _ in range(1000):
  # Environment requires an np.ndarray
  action = np.ndarray(dtype=np.float64, shape=(1,))

  if abs(observation[0] - math.pi) > 0.5*math.pi:
    # Gain energy
    action[0] = math.copysign(3, observation[1])
  else:
    # Balance
    action[0] = (math.pi - observation[0]) * 5 - observation[1] * 0.5
    
  observation, reward, done, info = env.step(action)
  
  if done:
    observation = env.reset()
  
  time.sleep(0.05)
