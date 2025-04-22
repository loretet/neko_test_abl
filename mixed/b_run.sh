#!/bin/bash -l
#SBATCH -J f_in
#SBATCH -t 00:30:00
#SBATCH --ntasks-per-node=128
#SBATCH --nodes=2
#SBATCH -p main
#SBATCH -A naiss2024-1-3
#SBATCH --mail-type=BEGIN,END,FAIL

ntasks=$((128*2))
casename="mixed"

[ ! -d "logfiles/" ] && mkdir logfiles
[ ! -d "output/" ] && mkdir output

##### json-fortran must be loaded when sbatch-ing! ######  

srun -u -n $ntasks ./neko ${casename}.case > logfiles/run.log"$(date +%F_%H-%M-%S)" 2>&1
if tail -n 2 logfiles/run.log${d} | grep -qi " Normal end."; then
    mv *0.f0* output/
    mv les0* output/
    mv *.log logfiles/
fi
# Bolin centre compute node: naiss2024-1-3
# Philipp KTH compute node: naiss2023-3-13
