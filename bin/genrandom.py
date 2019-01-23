# seed the pseudorandom number generator
def random_double(matrix):
  min = 0
  max = 1
  return (min + (matrix * (max - min)))

'''
from random import seed
from random import random

# seed random number generator
seed(1)
# generate some random numbers
print(random(), random(), random())
'''

#https://realpython.com/python-random/
import numpy as np
np.random.seed(1)
np.set_printoptions(precision=2)

print(random_double(np.random.rand(3,4)));

