from ase.dft.kpoints import *
import numpy as np
import os
import ase
from ase.calculators.vasp import Vasp

mof = ase.io.read('POSCAR.init')

calc_opt = Vasp(system = "MOF-7",
               istart = 0,iniwav = 1,icharg = 0,gamma=True,reciprocal=True,
               prec="Accurate", lreal = False, algo = "Normal", encut = 500.00,
               nelm = 200, ediff = 1e-6, gga = "PS",kpts=(1,1,1),
               ediffg = 1e-3, nsw = 100, ibrion = 1, isif = 3, isym = 2,
               ismear = 0)

mof.set_calculator(calc_opt)
energy = mof.get_potential_energy()
print("Energy: ", energy)
