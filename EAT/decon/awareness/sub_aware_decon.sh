#!/bin/bash
#---Number 0f core
#SBATCH -c 12

#---Job's name in LSF system
#SBATCH -J aware_decon

#---Error file
#SBATCH -e aware_decon_err

#---Output file
#SBATCH -o aware_decon_out

#---Queue name
#SBATCH -q PQ_nbc

#---Partition
#SBATCH -p investor
########################################################
export NPROCS=`echo $LSB_HOSTS | wc -w`
export OMP_NUM_THREADS=$NPROCS
. $MODULESHOME/../global/profile.modules
module load afni

bash aware_decon.sh > aware_decon_out.txt
