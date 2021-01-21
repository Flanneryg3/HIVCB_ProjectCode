#!/bin/bash
#---Number 0f core
#SBATCH -c 8

#---Job's name in LSF system
#SBATCH -J insula_MVM

#---Error file
#SBATCH -e insula_mvm_err

#---Output file
#SBATCH -o insula_mvm_out

#---Queue name
#SBATCH -q PQ_nbc

#SBATCH --account iacc_nbc

#---Partition
#SBATCH -p investor

##########################################################
# Setup envrionmental variable.
##########################################################
export NPROCS=`echo $LSB_HOSTS | wc -w`
export OMP_NUM_THREADS=$NPROCS
export R_LIBS='/home/data/nbc/tools/R'

. $MODULESHOME/../global/profile.modules
module load afni/17.3.06
module load gsl-blas/1.15
module load R/3.4.3
##########################################################

##########################################################
##########################################################

source insula_mvm.sh
