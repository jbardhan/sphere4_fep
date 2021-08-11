#!/bin/bash

for angle in 0.0 10.0 20.0 30.0 40.0 50.0 60.0 70.0 80.0 90.0 100.0 110.0 120.0 130.0 140.0 150.0 160.0 170.0 180.0
do

    for distance in 0.0  0.4 0.8 1.2 1.6 2.0 2.267
    do

	mkdir ionpair/trans${distance}_${angle}
	cd ionpair/trans${distance}_${angle}
	
	cp /home/bard415/repos/sphere_dipoles_slic/salt_bridges/ionPair_sphere5067/ionPair_10deg_trans${distance}_${angle}.pqr ./ionpair.pqr

	cp ../../basecase/latticeSphereProtein.pdb ./preIonPairSphere.pdb
	cp ../../basecase/*vmd ./
	cp ../../basecase/*namd ./

	python ../../concatPDBPQR.py --inpdb preIonPairSphere.pdb --inpqr ionpair.pqr --outpdb latticeSphereProtein.pdb  --outchargefile changesToMakeToPSF

	vmd -dispdev text -e dopsfgen.vmd > out.dopsfgen
	vmd -dispdev text -e solvate.vmd > out.solvate
	vmd -dispdev text -e makeFixed.vmd > out.makeFixed
	vmd -dispdev text -e makePDB_FEP.vmd > out.makePDB_FEP

	python ../../turnSolvatedPSFtoChargedPSF.py --inpsf solvated.psf --outpsf charged.psf --chargefile changesToMakeToPSF

	cd ../..

    done
    
done
