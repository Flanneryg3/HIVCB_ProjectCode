#!/bin/bash
# DESCRIPTION/USEAGE: Create AFNI head and brick files, cat.1D (for deconvolution step), and cleanup files no longer needed in scratch.
#                     -There should be no need to edit anything in this file. Edits (e.g., to subject #, session, SCRATCHpath should be done in the 1_create_AFNI_files.sub file
#                      which calls this script.

##########################################################################################
project='MSUT_HIV_CB'
paradigm='EAT'
AFNIDIR='/home/applications/afni/abin/afni/'
sub=$1             #variable passed from .sub call
SCRATCHpath=$2     #variable passed from .sub call
SCRATHscriptDir=$3 #variable passed from .sub call
##########################################################################################


### STEP-1: CREATE AFNI FILES FOR FUNCT AND STRUCT ###
echo "subject: ${sub}"
cd ${SCRATCHpath}/${project}/${paradigm}/${sub}/
#FOR STRUCT
to3d -anat -prefix ${sub}-anat *Structural*/*

#FOR FUNCT
for run in 1 2 3 4 5 6
	do
	images=`ls *EAT_${run}*|wc -l`
	echo "subject: ${sub} run: ${run} images: ${images}"	
	to3d -epan -time:zt 42 $((images/42)) 2000 alt+z -skip_outliers -prefix ${sub}-$paradigm-${run} *EAT_${run}/*.dcm
done


### STEP-2: CREATE SUBJECT/SESSION SPECIFIC CAT.1D FILE FOR DECONVOLUTION STEP. AS SOME PARTICIPANTS HAVE DIFFERENT NUMBER OF TRS IN A RUN.
for run in 1 2 3 4 5 6
	do
	if [ $run -eq 1 ]; then
		echo "0" > $sub-cat_eat.1D
	else
		count=$((run - 1))
		totaltr=0
		while [ $count -gt 0 ]; do    #CODY updated small bug here July 18, 2016
			numTR=$(3dinfo -nt ${sub}-$paradigm-${count}) 
			totaltr=$((numTR + totaltr))
			count=$((count - 1))
		done
		echo "$totaltr" >> $sub-cat_eat.1D
	fi
done

###STEP-3: CLEAN UP FROM PREVIOUS STEPS (DICOM data copied to scratch no longer needed)
rm -rf *-EAT_* *Structural*


###SEND OUT REMINDER INSTRUCTIONS TO THE SCREEN ###
echo "***NEXT STEP: Run 2_EAT_LinearReg.sub"

###--------------------------------------------------------------------------------------------------------------------------------------------

