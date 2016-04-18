export NPROC2=$1
export dir=$2
echo $dir
cd $dir
echo `pwd`
finished_calc=`grep 'free energy' OUTCAR | awk '{print $2}'`
if [ "$finished_calc" == 'energy' ]
then
    echo "Calculation done already!"
else
    cp ../INCAR ../POTCAR ../KPOINTS .
    cp *POSCAR-* POSCAR
    aprun -n $NPROC2 -N 24 vasp_std > vasp.out
fi
