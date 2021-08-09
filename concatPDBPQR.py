#!/usr/bin/env python

import os, sys, subprocess, argparse, re, logging, errno
import json
import numpy as np
import mymm

parser = argparse.ArgumentParser(description="This program generates a set of rotated and possibly translated versions of the input PQR.", prog = sys.argv[0])

parser.add_argument('--inpdb', metavar = 'input_molecule.pdb')
parser.add_argument('--inpqr', metavar = 'molecule_to_add.pqr')
parser.add_argument('--outpdb', metavar = 'output_molecule.pdb')
parser.add_argument('--outchargefile', metavar = 'changes_to_make_to_PSF.txt')

args = parser.parse_args(sys.argv[1:])

print("Reminder: this script assumes that inpdb is a latticeSphereProtein\n")

original = mymm.Molecule()
original.read_pdb(args.inpdb)

newmol = mymm.Molecule()
newmol.read_pqr(args.inpqr)

currentNumberMaximum = 2103
currentAtomIDMaximum = 3
currentResNumMaximum = 22

psf_changes = {}
index = 1

for atom in newmol.atoms:
    number = atom.number + currentNumberMaximum
    atomid     = "S" + str(currentAtomIDMaximum+index)
    index = index+1

    # note that we're using both number and index in case the pqr file doesn't start at 1
    # but the above may still have bugs
    
    resid  = "NSR"
    segid  = ""
    resnum = currentResNumMaximum
    absres = currentResNumMaximum

    psf_changes[number] = atom.q

    original.add_atom(mymm.Atom(number,atomid,resid,segid,resnum,absres,atom.xyz[0],atom.xyz[1],atom.xyz[2],elem=atom.elem,tempfactor=1.0,occupancy=1.0,q=0.0))

#original.add_molecule(newmol)

original.write_pdb(args.outpdb)

output_chargefile = open(args.outchargefile,'w')
json.dump(psf_changes,output_chargefile)
output_chargefile.close()
