sh ../bin/clean_build.sh
cp ~/projects/grl/cfg/leosim/agent_ddpg.yaml ~/projects/grl/build/agent_leosim_ddpg.yaml
cp ~/projects/grl/cfg/leosim/env_leo.yaml ~/projects/grl/build
../bin/grlr ../bin/spec_leosim_replay.yaml