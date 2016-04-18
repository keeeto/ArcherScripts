#!/bin/bash --login

#PBS -N Nb2O5-B112
#PBS -l select=4
#PBS -l walltime=1:00:00
#PBS -A e05-gener-wal

#Note: select = No. Nodes (e.g. 12 = 12*24 = 288 cores)

export OMP_NUM_THREADS=1
ulimit -s unlimited
module load vasp5/5.3.3

export NPROC=`qstat -f $PBS_JOBID | awk '/Resource_List.mpiprocs/ {print $3}'`

cd $PBS_O_WORKDIR

for i in 0.94 0.96 0.98 1.00 1.02 1.04 1.06
do
  sed "s/FACTOR/$i/" POSCAR.Template > POSCAR;
  aprun -n $NPROC /home/e05/shared/red/vasp5 > vasp.out
  E=`tail -1 OSZICAR` ; echo $i $E >> ev.dat
done
