#!/bin/bash -l

#export PATH="/cfs/klemming/home/l/ldl/neko/bin:$PATH"

# USER INPUT #
echo "-------------- N E (=^_^=) K O  ----------------"
echo ""
echo "Casename: "
read casename
echo "Streamwise and spanwise length: "
read Lx
Lz=$Lx
echo "Vertical length: "
read Ly
echo "Resolution: "
read nex
ney=$nex
nez=$nex

[ ! -f "box.nmsh" ] && {
echo "Meshing..."
/cfs/klemming/home/l/ldl/neko/makeneko 0 $Lx 0 $Ly 0 $Lz $nex $ney $nez .true. .false. .true. # periodicity
}

# echo "Compiling the case..."
# [ ! -f "USER.mod" ] &&      ############ CHANGE THIS IN IF CLAUSE THAT DELETES USER.MOD AND NEKO IF PRESENT AND THEN RUNS COMPILING!!!

echo "Compiling..."
/cfs/klemming/home/l/ldl/neko/makeneko "${casename}".f90 
echo ""

