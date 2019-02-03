import yaml
import itertools
import threading
import socket
import select

try:
    # included in standard lib from Python 2.7
    from collections import OrderedDict
except ImportError:
    # try importing the backported drop-in replacement
    # it's available on PyPI
    from ordereddict import OrderedDict

class hashabledict(OrderedDict):
    def __hash__(self):
        return hash(yaml.dump(self))

_mapping_tag = yaml.resolver.BaseResolver.DEFAULT_MAPPING_TAG

def dict_representer(dumper, data):
  return dumper.represent_dict(data.iteritems())
    
def dict_constructor(loader, node):
  return hashabledict(loader.construct_pairs(node))
        
yaml.add_representer(hashabledict, dict_representer)
yaml.add_constructor(_mapping_tag, dict_constructor)

class Worker():
  def __init__(self, socket, output=""):
    self.socket = socket
    self.output = output
    self.dead = False

  def read(self, regret='simple'):
    """Read worker result, returning either simple or cumulative regret"""
    data = [float(v) for v in self.socket.makefile().readlines()]
    self.socket.close()
    self.dead = True
    
    if self.output:
      stream = open(self.output + ".txt", 'w')
      for d in data:
        print >>stream, d
      stream.close()
    
    if regret == 'simple':
      sample = int(len(data)/20)
      if sample == 0:
        raise Exception("Worker did not return data")
      return sum(data[-sample:])/sample
    elif regret == 'cumulative':
      return sum(data)
    else:
      raise Exception("Unknown regret type " + regret)

  # DELETES DATA FROM QUEUE! ONLY USE IF YOU DON'T
  # CARE ABOUT THE RETURN VALUE OF READ!
  def alive(self):
    if self.dead:
      return False
  
    while True:
      r, w, e = select.select([self.socket], [], [], 0)
      if r:
        buf = self.socket.recv(4096, socket.MSG_DONTWAIT)
        if len(buf) == 0:
          self.dead = True
          return False
      else:
        return True

class Server():
  def __init__(self, port=3373):
    """Spawn thread to listen to connections"""
    self.port = port
    self.workers = []
    self.condition = threading.Condition()
    self.thread = threading.Thread(target=Server.thread, args=[self])
    self.thread.daemon = True
    self.thread.start()

  def thread(self):
    """Listen to connections, adding them to available workers"""
    s = socket.socket()
    s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    s.bind(('', self.port))
    s.listen(100)
    
    print "Server listening for connections on port", self.port
    
    try:
      while True:
        c, _ = s.accept()
        with self.condition:
          self.workers.append(c)
          self.condition.notify()
    except e:
      raise e

  def submit(self, conf, output=""):
    """ Submit job to available worker"""
    # Wait for available worker
    with self.condition:
      while len(self.workers) == 0:
        self.condition.wait()
      w = self.workers.pop()
    
    # Send configuration
    w.send(conf + '\0')
    
    # Return stream for reading by submitter
    return Worker(w, output)

def splittype(type):
  """Splits type into base and role."""
  temp = type.split('.')
  if len(temp) == 1:
    return temp[0], ''
  else:
    return temp[0], temp[1]

def isobject(type):
  """Returns true if the type is not a builtin type."""
  base, role = splittype(type)
  
  if base in ['int','double','string','vector']:
    return False
  else:
    return True

def isnumber(type):
  try:
    float(type)
    return True
  except ValueError:
    return False

def findrequests(requests, type):
  """Find parameter requests that match a certain type."""
  matches = list()
  
  base, role = splittype(type)
  
  for key in requests:
    if key[0:len(base)] == base and (role == "" or key[-len(role):] == role):
      keybase, keyrole = splittype(key)
      matches.append(keybase)
  
  return sorted(list(set(matches)))

def findparams(params, type):
  """Find registered parameters that match a certain type."""
  components = type.split('+')
  
  pmatches = list()
  
  for c in components:
    cmatches = list()
    
    if isnumber(c):
      cmatches.append(c)
    else:
      base, role = splittype(c)
      
      for key in params:
        if params[key][0:len(base)] == base and (role == "" or params[key][-len(role):] == role):
          keybase, keyrole = splittype(key)
          cmatches.append(keybase)
        
    pmatches.append(cmatches)

  # Cartesian product
  matches = list()
  for element in itertools.product(*pmatches):
    matches.append('+'.join(element))

  return sorted(list(set(matches)))

def setconf(conf, param, value):
  """Set parameter in configuration to value"""
  # Strip leading /
  if param[0] == '/':
    param = param[1:]
    
  path = param.split('/')
  try:
    item = int(path[0])
  except:
    item = path[0]
  
  if len(path) == 1:
    conf[item] = value
  else:
    setconf(conf[item], '/'.join(path[1:]), value)
    
  return conf

def getconf(conf, param):
  """Get parameter value in configuration"""
  # Strip leading /
  if param[0] == '/':
    param = param[1:]
    
  path = param.split('/')
  
  try:
    item = int(path[0])
  except:
    item = path[0]
  
  if len(path) == 1:
    return conf[item]
  else:
    return getconf(conf[item], '/'.join(path[1:]))

def mergeconf(base, new):
  """Merge configurations"""
  if isinstance(base,dict) and isinstance(new,dict):
    for k,v in new.iteritems():
      if k not in base:
        base[k] = v
      else:
        base[k] = merge(base[k],v)

  return base
