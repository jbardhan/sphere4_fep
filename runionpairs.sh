#!/bin/bash

mkdir /big_scratch/bard415
cd /big_scratch/bard415

rsync -ravuz /home/bard415/repos/sphere4_fep/ionpair .

# 90.0 180.0
for angle in 0.0 
do
    # 0.4 0.8 1.2 1.6 2.0 2.267
    for distance in 0.0 
    do

	cd /big_scratch/bard415/ionpair/trans${distance}_${angle}
	/home/bard415/bin/namd2-multicore +p36 equil.namd > equil.out 

	/home/bard415/bin/namd2-multicore +p36 forward.namd > forward.out

	/home/bard415/bin/namd2-multicore +p36 backward.namd > backward.out

	cd /big_scratch/bard415
	rsync -ravuz ionpair /home/bard415
    done
done

cd /big_scratch/bard415 
rsync -ravuz ionpair /home/bard415
