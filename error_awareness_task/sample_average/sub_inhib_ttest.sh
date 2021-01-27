#!/bin/bash
#---Number 0f core
#SBATCH -c 12

#---Job's name in LSF system
#SBATCH -J inhib_ttest

#---Error file
#SBATCH -e inhib_ttest_err

#---Output file
#SBATCH -o inhib_ttest_out

#---Queue name
#SBATCH -q PQ_nbc

#SBATCH --account iacc_nbc
 
#---Partition
#SBATCH -p investor
########################################################
export NPROCS=`echo $LSB_HOSTS | wc -w`
export OMP_NUM_THREADS=$NPROCS
. $MODULESHOME/../global/profile.modules
module load afni

bash inhib_ttest.sh > inhib_ttest_out.txt
