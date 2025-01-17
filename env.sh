#!/bin/bash

# run `source env.sh /path/to/delphes/repo`, otherwise pass no
# argument to use the default location
# - it may be useful to set your own default location (hard-coded)
# - if you are in a container, environment may already be set

if [ $# -eq 1 ]; then
  # user-specified delphes location
  delphesDir=$1
elif [ "$DELPHES_HOME" = "/opt/delphes" ]; then
  # assume we are in a container, and delphes env is likely already set
  delphesDir=$DELPHES_HOME
else
  # default delphes location (hard-coded)
  delphesDir=${HOME}/builds/delphes
fi
echo "delphes repository expected at $delphesDir"

if [ -f "$delphesDir/DelphesEnv.sh" ]; then

  # source delphes environment
  cd $delphesDir
  source DelphesEnv.sh
  echo "DELPHES_HOME set to $DELPHES_HOME"
  export PATH=$PATH:$DELPHES_HOME
  echo "success!"
  cd -

  # symlink delphes external stuff (so that we can run analysis code here)
  ln -sf $DELPHES_HOME/external ./

else
  echo "ERROR: DelphesEnv.sh not found, is the repo really at ${delphesDir}?"
fi

export MSTWPDF_HOME=$(pwd)/mstwpdf
echo "MSTWPDF at $MSTWPDF_HOME"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$MSTWPDF_HOME"
