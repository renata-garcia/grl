#!/usr/bin/python
#
# NOTE: Actions are defined on [-1, 1], so they need to be
# normalized on input (with a signed projector/pre/normalized) and
# on output (with a renormalizing mapping/policy/action)


from __future__ import print_function

import numpy as np
import tensorflow as tf
import time, sys

from keras.models import Model
from keras.layers.core import Dense, Lambda
from keras.layers.merge import Concatenate
from keras.layers.normalization import BatchNormalization
from keras.backend import get_session

print(sys.argv)
print(len(sys.argv))
print(sys.argv[-1])

from tensorflow.python.platform import gfile
#from IPython.display import clear_output, Image, display, HTML
import numpy as np
import tensorflow as tf

# def strip_consts(graph_def, max_const_size=32):
#     """Strip large constant values from graph_def."""
#     strip_def = tf.GraphDef()
#     for n0 in graph_def.node:
#         n = strip_def.node.add() 
#         n.MergeFrom(n0)
#         if n.op == 'Const':
#             tensor = n.attr['value'].tensor
#             size = len(tensor.tensor_content)
#             if size > max_const_size:
#                 tensor.tensor_content = bytes("<stripped %d bytes>"%size, encoding='utf-8')
#     return strip_def

# def show_graph(graph_def, max_const_size=32):
#     """Visualize TensorFlow graph."""
#     if hasattr(graph_def, 'as_graph_def'):
#         graph_def = graph_def.as_graph_def()
#     strip_def = strip_consts(graph_def, max_const_size=max_const_size)
#     code = """
#         <script>
#           function load() {{
#             document.getElementById("{id}").pbtxt = {data};
#           }}
#         </script>
#         <link rel="import" href="https://tensorboard.appspot.com/tf-graph-basic.build.html" onload=load()>
#         <div style="height:600px">
#           <tf-graph-basic id="{id}"></tf-graph-basic>
#         </div>
#     """.format(data=repr(str(strip_def)), id='graph'+str(np.random.rand()))

#     iframe = """
#         <iframe seamless style="width:1200px;height:620px;border:0" srcdoc="{}"></iframe>
#     """.format(code.replace('"', '&quot;'))
#     display(HTML(iframe))

if len(sys.argv) == 4:
  lr_actor = 0.0001
  lr_critic = 0.001
  activation_dl = "relu"
  activation_end_critic = "linear"
  layer1_size = 8
  layer2_size = 8
  layer3_size = 8
elif len(sys.argv) != 11:
  print("Usage:")
  print(" ", sys.argv[0], "<inputs> <outputs> <lr_actor> <lr_critic> <activation_dl> <activation_end_critic> <layer1_size> <layer2_size> <layer3_size> <output.pb>")
  sys.exit(1)
else:
  lr_actor = float(sys.argv[3])
  lr_critic = float(sys.argv[4])
  activation_dl = sys.argv[5]
  activation_end_critic = sys.argv[6]
  layer1_size = int(sys.argv[7])
  layer2_size = int(sys.argv[8])
  layer3_size = int(sys.argv[9])

if int(sys.argv[2]) != 1:
  print("Not suitable for more than one output", file=sys.stderr)
  sys.exit(1)

obs = int(sys.argv[1])
actions = int(sys.argv[2])
normalization = False
share_weights = False

print("lr_actor: ",lr_actor, ", lr_critic: ", lr_critic, ", activation_dl: ", activation_dl, ", activation_end_critic: ", activation_end_critic, ", layer1_size: ", layer1_size, ", layer2_size: ", layer2_size, ", layer3_size: ", layer3_size)

# Actor network definition
s_in = tf.placeholder(tf.float32, shape=(None,obs), name='s_in')
if normalization:
  sn = BatchNormalization()(s_in)
else:
  sn = s_in
hc = Dense(layer1_size, activation=activation_dl, name='h_common')(sn)
if normalization:
  hcn = BatchNormalization()(hc)
else:
  hcn = hc
hb = Dense(layer2_size, activation=activation_dl, name='h_actor')(hcn)
if normalization:
  hbn = BatchNormalization()(hb)
else:
  hbn = hb
ha = Dense(layer3_size, activation=activation_dl, name='h_actor')(hbn)
if normalization:
  han = BatchNormalization()(ha)
else:
  han = ha
a_out = Dense(actions, activation='tanh', name='a_out')(han)
theta = tf.trainable_variables()

# Critic network definition
a_in = tf.placeholder_with_default(tf.stop_gradient(a_out), shape=(None,actions), name='a_in')
if normalization:
  an = BatchNormalization()(a_in)
else:
  an = a_in
if share_weights:  
  ca = Concatenate()([hcn, an])
else:
  hc2 = Dense(layer1_size, activation=activation_dl, name='h_common2')(sn)
  if normalization:
    hcn2 = BatchNormalization()(hc2)
  else:
    hcn2 = hc2
  ca = Concatenate()([hcn2, an])
hp = Dense(layer2_size, activation=activation_dl, name='h_critic')(ca)
if normalization:
  hqn = BatchNormalization()(hp)
else:
  hpn = hp
hq = Dense(layer3_size, activation=activation_dl, name='h_critic')(hpn)
if normalization:
  hqn = BatchNormalization()(hq)
else:
  hqn = hq
q = Dense(1, activation=activation_end_critic, name='q')(hqn)
tf.group([s_in, a_in], name='inputs')
tf.group([q, a_out], name='outputs')


# Critic network update
q_target = tf.placeholder(tf.float32, shape=(None, 1), name='target')
q_loss = tf.losses.mean_squared_error(q_target, q)
q_update = tf.train.AdamOptimizer(lr_critic).minimize(q_loss, name='update')

# Actor network update
dq_da = tf.gradients(q, a_in, name='dq_da')[0]
dq_dtheta = tf.gradients(a_out, theta, -dq_da, name='dq_dtheta')

a_update = tf.train.AdamOptimizer(lr_actor).apply_gradients(zip(dq_dtheta, theta), name='a_update')

# Create weight assign placeholders
vars = tf.trainable_variables()
for v in vars:
  tf.assign(v, tf.placeholder(tf.float32, shape=v.shape))

tf.train.write_graph(get_session().graph.as_graph_def(), './', sys.argv[-1], as_text=False)

# # Build your graph.
# #//-------------------------------------
# #tensorboard --logdir ./log --port=8008
# with tf.Session() as sess:

#   with gfile.FastGFile('./pb.pb', 'rb') as f:
#     graph_def = tf.GraphDef()
#     graph_def.ParseFromString(f.read())
#     sess.graph.as_default()
#     g_in = tf.import_graph_def(graph_def)
#     f.close()

#   writer = tf.summary.FileWriter('./log')
#   writer.add_graph(sess.graph)
#   writer.flush()
#   writer.close()
