#!/usr/bin/env bash

if [ "$(uname)" == "Darwin" ]; then
  # Do something under Mac OS X platform        
  echo "Running under MAC OS"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  # Do something under GNU/Linux platform
  echo "Running under Linux"
 elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
  # Do something under 32 bits Windows NT platform
  echo "Running under MIN32"
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
  # Do something under 64 bits Windows NT platform
  echo "Running under MIN64"
fi

# and this...
case "$OSTYPE" in
  linux*)   echo "LINUX" ;;
  darwin*)  echo "OSX" ;; 
  win*)     echo "Windows" ;;
  msys)     echo "MINGW" ;;
  cygwin*)  echo "Cygwin" ;;
  bsd*)     echo "BSD" ;;
  solaris*) echo "SOLARIS" ;;
  *)        echo "unknown: $OSTYPE" ;;
esac


