#!/usr/bin/env bash

# we need bash 4 for associative arrays
if [ "${BASH_VERSION%%[^0-9]*}" -lt "4" ]; then
  echo "BASH VERSION < 4: ${BASH_VERSION}" >&2
  exit 1
fi

#This condition is to avoid reruning install when build argument is passed
if [[ $# -eq 0 ]] ; then
  # define colors
  GRAY='\033[1;30m'; RED='\033[0;31m'; LRED='\033[1;31m'; GREEN='\033[0;32m'; LGREEN='\033[1;32m'; ORANGE='\033[0;33m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; LBLUE='\033[1;34m'; PURPLE='\033[0;35m'; LPURPLE='\033[1;35m'; CYAN='\033[0;36m'; LCYAN='\033[1;36m'; LGRAY='\033[0;37m'; WHITE='\033[1;37m';
fi

echo `pwd`
echo `ls -a`

# Get the pylint_version from .pylintrc

PYLINT_VERSION=$(cat .pylintrc | awk '/\#\spylint_version:\s(.*)/ { print $3 }' )
echo "Pylint version is: $PYLINT_VERSION"

# Install dependencies
sudo apt-get update
sudo apt-get install libudev-dev libusb-1.0
sudo apt-get install -y gettext
pip install circuitpython-build-tools Sphinx sphinx-rtd-theme
pip install --force-reinstall pylint==$PYLINT_VERSION black==19.10b0
pip install -r requirements.txt
