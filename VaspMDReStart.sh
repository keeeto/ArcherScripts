#!/bin/bash

if [ -e XDATCAR.Old ]
    then
    echo "XDATCAR.Old already exists, rename it to avoid data loss. I will not continue."
else
    cp CONTCAR POSCAR
    cp XDATCAR XDATCAR.Old
    temp_new=`grep 'kin. lattice' OUTCAR | tail -1 | awk '{print $6}'`
    sed  "s/.*TEBEG.*/ TEBEG   =    $temp_new     (Start temperature K)/" INCAR > tmp
    steps_run=`grep -wc LOOP+ OUTCAR`
    steps_ini=`grep NSW INCAR | awk '{print $3}'`
    steps_new=`expr  $steps_ini - $steps_run`
    echo "You still have $steps_new steps remaining."
    echo "Your new starting temperature is $temp_new."
    if [ $steps_new -gt 0 ]
    	then
    	sed "s/.*NSW.*/ NSW     =  $steps_new /" tmp > INCAR.New 
	cp INCAR.New INCAR
    else 
    	echo "No distance left to run, don't resatrt"
    fi
fi
