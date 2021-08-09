#!/usr/bin/env python


import os, sys, subprocess, argparse, re, logging, errno
import json
import numpy as np
import mymm


def replaceChargeInPSFline(line, new_q):

    if new_q > 0.0:
        padstring = " "
    else:
        padstring = ""

    q_string = "%7f"%new_q
    prefloat = line[0:35]
    postfloat = line[44:]
    line = prefloat + padstring + q_string + postfloat
    return line


parser = argparse.ArgumentParser(description="This program generates a set of rotated and possibly translated versions of the input PQR.", prog = sys.argv[0])

parser.add_argument('--inpsf', metavar = 'input_molecule.psf')
parser.add_argument('--outpsf', metavar = 'output_molecule.psf')
parser.add_argument('--chargefile', metavar = 'changes_to_make_to_PSF.txt')

args = parser.parse_args(sys.argv[1:])

chargefile = open(args.chargefile,'r')
psf_changes = json.load(chargefile)
print("psf_changes = " + str(psf_changes))
chargefile.close()

inpsf = open(args.inpsf,'r')
outpsf = open(args.outpsf,'w')

inAtomsSection = False

for line in inpsf:

    if inAtomsSection:
        # check if line takes us OUT of Atoms section
        matched = re.search('!N' ,line)
        match = bool(matched)
        if match:
#            print("line indicating we're leaving ATOMS section:\n"+line+"\n\n")
            inAtomsSection = False

        match = False
        
        #check if line matches an index to have its charge changed
        for atomNumberToChange in psf_changes.keys():
#            print("atomNumberToChange = " + str(atomNumberToChange))
 #           print("atom line = " + line)
            pat = '^\\s+'+atomNumberToChange+'\\s+'
            matched = re.search(pat, line)
            match = bool(matched)
            if match:
#                print("matched " + line)
                line = replaceChargeInPSFline(line, psf_changes[atomNumberToChange])
                
    else:
        #check if line puts us into Atoms section
        matched = re.search("NATOM", line)
        match = bool(matched)
        if match:
 #           print("line indicating we're entering ATOMS section:\n"+line+"\n\n")
            inAtomsSection = True
            
    # now that we've processed the line and possibly modified it, write it out
    outpsf.write(line)

            
outpsf.close()
inpsf.close()

