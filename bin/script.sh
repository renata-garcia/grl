: '
./grld ../cfg/pendulum/mpol_dpg_13_mean_mov.yaml
./grld ../cfg/pendulum/mpol_dpg_13_mean.yaml 
./grld ../cfg/pendulum/mpol_dpg_13_random.yaml 
./grld ../cfg/pendulum/mpol_dpg_13_greedy.yaml

./grld ../cfg/pendulum/mpol_dpg_13_data_center_mm_b2_a01.yaml
./grld ../cfg/pendulum/mpol_dpg_13_data_center_mm_b2_a75.yaml
./grld ../cfg/pendulum/mpol_dpg_13_data_center_mm_b2_a90.yaml
./grld ../cfg/pendulum/mpol_dpg_13_data_center_mm_b2_a98.yaml

./grld ../cfg/pendulum/mpol_dpg_13_data_center_mm_b3_a01.yaml
./grld ../cfg/pendulum/mpol_dpg_13_data_center_mm_b3_a75.yaml
./grld ../cfg/pendulum/mpol_dpg_13_data_center_mm_b3_a90.yaml
./grld ../cfg/pendulum/mpol_dpg_13_data_center_mm_b3_a98.yaml

./grld ../cfg/pendulum/mpol_ddpg_2_data_center.yaml
./grld ../cfg/pendulum/mpol_dpg_2_data_center.yaml
'

python3 ../addons/tensorflow/share/pendulum_ddpg.py
./grld ../cfg/pendulum/mpol_1_replay_ddpg_tensorflow.yaml

./grld ../cfg/pendulum/mpol_dpg_2_data_center_equals.yaml
