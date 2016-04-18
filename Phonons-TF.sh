#!/bin/bash --login

#PBS -N ZnPn-EV
#PBS -l select=24
#PBS -l walltime=4:00:00
#PBS -A e05-gener-wal
#PBS -q long

#Note: select = No. Nodes (e.g. 12 = 12*24 = 288 cores)

export OMP_NUM_THREADS=1
ulimit -s unlimited
module load vasp5/5.3.3

JOBS=24
export NPROC=`qstat -f $PBS_JOBID | awk '/Resource_List.mpiprocs/ {print $3}'`
NPROC2=$( echo "$NPROC/$JOBS" | bc ) #

cd $PBS_O_WORKDIR

for dir in  disp-*
do
  cd $dir
        finished_calc=`grep 'free  energy' OUTCAR | awk '{print $2}'`
	if [ "$finished_calc" == 'energy' ]
    	then
    	echo "Calculation done already!"
	else
  	cp ../INCAR ../POTCAR ../KPOINTS .
  	cp *POSCAR* POSCAR
  	aprun -n $NPROC2 -N 24 /home/e05/shared/red/vasp5 > vasp.out &
	fi
  cd ../
done
wait

rm disp-*/DOSCAR
rm disp-*/EIGENVAL

tar -cvf FinishedPhonons.tar disp-*
