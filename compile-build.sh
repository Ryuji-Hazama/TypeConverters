#!/bin/zsh

# Compile
./compile.sh

if [ $? -ne 0 ]; then
	exit 1
fi

# Build
./build.sh
