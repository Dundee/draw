#!/bin/bash

BASE_PATH=~/workspace/js/closure
CALCDEPS_PATH=$BASE_PATH/closure-library/closure/bin/  #directory containing calcdeps.py
JAR_PATH=$BASE_PATH                                    #directory containing compiler.jar
CLOSURE_PATH=$BASE_PATH/closure-library                #path to closure-library
COMPILER_FLAGS="--compiler_flags --compilation_level=ADVANCED_OPTIMIZATIONS"
COMPILER_FLAGS="$COMPILER_FLAGS --compiler_flags --warning_level=VERBOSE"
COMPILER_FLAGS="$COMPILER_FLAGS --compiler_flags --manage_closure_dependencies"
COMPILER_FLAGS="$COMPILER_FLAGS --compiler_flags --closure_entry_point=draw.main"
COMPILE=1

if [ -z $1 ]; then
	echo "Usage:" $0 "file.js"
	exit 1
fi

OUTPUT=$1
shift

EXTERNS=$1
COMPILER_FLAGS="$COMPILER_FLAGS --compiler_flags --externs=$EXTERNS"
shift

INPUTS=""
for IN in $@; do
	INPUTS="${INPUTS} -i ${IN}"
done

if [ $COMPILE -eq 1 ]; then
	$CALCDEPS_PATH/calcdeps.py $INPUTS \
		-p $CLOSURE_PATH -o compiled \
		$COMPILER_FLAGS \
		-c $JAR_PATH/compiler.jar > $OUTPUT
else
	$CALCDEPS_PATH/calcdeps.py $INPUTS \
		-p $CLOSURE_PATH -o script > $OUTPUT
fi
