#!/usr/bin/python

#https://realpython.com/python-random/
import numpy as np
import yaml, sys

# seed the pseudorandom number generator
def random_double(matrix):
  min = 0
  max = 1
  return (min + (matrix * (max - min)))

def getoutput(base, spec, conf):
  global output_counter
  output_counter = output_counter + 1
  
  if "output" in spec:
    pattern = spec["output"]
    pattern = pattern.replace("$@", base)
      
    for i in range(len(spec["parameters"])):
      curval = getconf(conf, spec["parameters"][i]["name"])
      pattern = pattern.replace("$%d" % i, curval)
      
      for v in range(len(spec["parameters"][i]["values"])):
        if spec["parameters"][i]["values"][v] == curval:
          pattern = pattern.replace("#%d" % i, str(v))
    return pattern + "-" + str(output_counter)
  else:
    return ""

'''
from random import seed
from random import random

# seed random number generator
seed(1)
# generate some random numbers
print(random(), random(), random())
'''

'''
np.random.seed(1)
np.set_printoptions(precision=2)

print(random_double(np.random.rand(3,4)));

'''

if __name__ == '__main__':
  cfg = 'random.yaml'
  if len(sys.argv) > 1:
    cfg = sys.argv[1]

  stream = open(cfg, 'r')
  spec = yaml.load(stream)
  stream.close()
  
  #write first part
  #write the three parts
  #write last part

  file = spec["file"]
  if file == "all":
    # All combinations of agents and environments in current directory
    for env in glob.glob('env_*.yaml'):
      for agent in glob.glob('agent_*.yaml'):
        stream = open(env)
        conf = yaml.load(stream)
        stream.close()
        stream = open(agent)
        mergeconf(conf, yaml.load(stream))
        
        optimize(os.path.basename(env)[4:-5] + "_" + os.path.basename(agent)[6:-5], spec, conf)
  else:
    # Specific file, possibly with wildcards
    for f in glob.glob(file):
      stream = open(f)
      conf = yaml.load(stream)
      stream.close()
    
      optimize(os.path.basename(f)[:-5], spec, conf)

