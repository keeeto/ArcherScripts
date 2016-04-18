#!/bin/bash

    for dir in `ls -d */`
	do
	pushd $dir > /dev/null
	finished=`grep equired OUTCAR.Ions.Tight | awk '{print $1}'`
	directory=$PWD
	if [ "$finished" == "reached" ]
	    then
	    echo  $directory finished
	    grep TOTEN $directory/OUTCAR | tail -1
	    else
	    echo $directory not finished
	fi
	popd > /dev/null
    done
