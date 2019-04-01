rm ~/projects/grl/build/*.yaml
rm ~/projects/grl/build/*-0.txt
rm ~/projects/grl/build/*-1.txt
rm ~/projects/grl/build/*-2.txt
rm ~/projects/grl/build/*-3.txt
rm ~/projects/grl/build/*-4.txt
rm ~/projects/grl/build/*-5.txt
rm ~/projects/grl/build/*-6.txt
rm ~/projects/grl/build/*-7.txt
rm ~/projects/grl/build/*-8.txt
rm ~/projects/grl/build/*-9.txt
rm ~/projects/grl/build/env_*
rm ~/projects/grl/build/agent_*
cp ~/projects/grl/cfg/cart_double_pole/env_cart_double_pole.yaml ~/projects/grl/build
cp ~/projects/grl/cfg/cart_double_pole/agent_replay_ddpg_tensorflow_geometric.yaml ~/projects/grl/build
../bin/grlr ../bin/spec_cart_double_pole_replay.yaml
