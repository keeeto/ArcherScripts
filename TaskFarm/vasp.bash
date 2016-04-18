# The variables are red in from the command in farm.bash.
export NPROC2=$1
export dir=$2
echo $dir
cd $dir
echo `pwd`
# This tests if the VASP calculation has previously completed in this directory.
finished_calc=`grep 'free energy' OUTCAR | awk '{print $2}'`
if [ "$finished_calc" == 'energy' ]
then
    echo "Calculation done already!"
else
# This is just the way that this particular script runs the job, change as you please.
    cp ../INCAR ../POTCAR ../KPOINTS .
    cp *POSCAR-* POSCAR
    aprun -n $NPROC2 -N 24 vasp_std > vasp.out
fi
