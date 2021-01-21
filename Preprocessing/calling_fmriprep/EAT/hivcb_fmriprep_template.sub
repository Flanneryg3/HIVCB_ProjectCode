#!/bin/bash
#---Number of cores
#BSUB -n 8
#BSUB -R "span[ptile=8]"

#---Job's name in LSF system
#BSUB -J {sub}

#---Error file
#BSUB -eo /home/data/nbc/Sutherland_HIVCB/code/errorfiles/err_{sub}

#---Output file
#BSUB -oo /home/data/nbc/Sutherland_HIVCB/code/outfiles/out_{sub}

#---LSF Queue name
#BSUB -q PQ_nbc

##########################################################
# Set up environmental variables.
##########################################################
export NPROCS=`echo $LSB_HOSTS | wc -w`
export OMP_NUM_THREADS=$NPROCS

. $MODULESHOME/../global/profile.modules
module load singularity

##########################################################
##########################################################
# Set variables
# Data must be in scratch directory.
DSET_DIR="/scratch/tsalo006/Sutherland_HIVCB_dset"

# Clear Python path to prevent contamination
PYTHONPATH=""

# Run fMRIPrep
singularity run /scratch/tsalo006/poldracklab_fmriprep_1.1.1-2018-06-07-0e6d5a486b90.img \
    $DSET_DIR /scratch/tsalo006/Sutherland_HIVCB_derivatives/ participant \
    --participant_label {sub} --n_cpus $NPROCS \
    --output-space T1w template --template-resampling-grid native \
    --fs-license-file /scratch/tsalo006/freesurfer_license.txt \
    --resource-monitor --notrack \
    -w /scratch/tsalo006/work
