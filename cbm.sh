#!/bin/bash
nkpts=`grep NKPTS OUTCAR | awk '{print $4}'`
uband=`grep NELECT OUTCAR | awk '{print $3/2+1}'`
grep "  $uband   " OUTCAR | tail -$nkpts | awk '{print $2}' | sort -n | head
