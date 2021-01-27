#!/bin/bash
# DESCRIPTION/USEAGE: Blur dataset....
#                     August, 2016 M.Sutherland, M. Riedel
#                     -There should be no need to edit anything in this file. Edits (e.g., to subject #, session, SCRATCHpath should be done in the .sub file
#                      which calls this script.

##########################################################################################
project='MSUT_HIV_CB'
paradigm='EAT'
sub=$1               #variable passed from .sub call
SCRATCHpath=$2       #variable passed from .sub call
SCRATHscriptDir=$3   #variable passed from .sub call
file_check_folder=$4 #variable passed from .sub call
censor_file=$5       #variable passed from .sub call
##########################################################################################
echo "subject: ${sub}"
cd ${SCRATCHpath}/${project}/${paradigm}/${sub}/


### STEP-0:CLEAN UP FILES FROM ANY PREVIOUS RUN OF THIS SCRIPT ###
echo "...........clean up old files..........."
rm -f  ${sub}-${paradigm}-errts+tlrc* ${sub}-${paradigm}-norm_blur?+tlrc* 3dDeconvolve.err decon_bucket* 2>/dev/null 


### STEP-1: DECON to get errts file (residual error time series)###
# if participant failed to responded to all items (i.e., there is a noRESP file)
echo "...........(pre)Deconvolution start..........."  
	# MTS: Alternative remove censor file from this decon which is just used to get the errts as input to 3dBlurToFWHM. If a censor file used here errts file is output with some TRs (i.e., those censored) with all zero values. In 3dBlurToFWHM if some TRs all zero, the detrend step is disabled. However the errts file is already a detrended file (Of course censor file used in the real decon which is the next processing script.

if [ -1 -eq 0 ]; then
	3dDeconvolve -input ${sub}-${paradigm}-norm+tlrc \
		-polort A \
		-mask ${sub}-${paradigm}-mask+tlrc \
		-concat ${sub}-cat_eat.1D \
		-censor ${sub}-${paradigm}_${censor_file} \
		-num_stimts 10 \
		-allzero_OK \
		-GOFORIT 9 \
		-jobs 6 \
		-svd \
		-local_times \
		-basis_normall 1 \
		-stim_times 1 aware-correct.txt SPMG \
		-stim_label 1 "aware" \
		-stim_times 2 aware-incorrect.txt SPMG \
		-stim_label 2 "unaware" \
		-stim_times 3 stop-correct.txt SPMG \
		-stim_label 3 "stop correct" \
		-stim_times 4 go-noresp.txt SPMG \
		-stim_label 4 "go no response" \
		-stim_file 5 ${sub}-${paradigm}-motion.1D'[0]' \
		-stim_label 5 "roll" \
		-stim_base 5 \
		-stim_file 6 ${sub}-${paradigm}-motion.1D'[1]' \
		-stim_label 6 "pitch" \
		-stim_base 6 \
		-stim_file 7 ${sub}-${paradigm}-motion.1D'[2]' \
		-stim_label 7 "yaw" \
		-stim_base 7 \
		-stim_file 8 ${sub}-${paradigm}-motion.1D'[3]' \
		-stim_label 8 "DS" \
		-stim_base 8 \
		-stim_file 9 ${sub}-${paradigm}-motion.1D'[4]' \
		-stim_label 9 "DL" \
		-stim_base 9 \
		-stim_file 10 ${sub}-${paradigm}-motion.1D'[5]' \
		-stim_label 10 "DP" \
		-stim_base 10 \
		-errts ${sub}-${paradigm}-errts \
		-bucket decon_bucket
fi
3dDeconvolve -input ${sub}-${paradigm}-norm+tlrc \
	-polort A \
	-mask ${sub}-${paradigm}-mask+tlrc \
	-concat ${sub}-cat_eat.1D \
	-censor ${sub}-${paradigm}_${censor_file} \
	-num_stimts 8 \
	-allzero_OK \
	-GOFORIT 9 \
	-jobs 6 \
	-svd \
	-local_times \
	-basis_normall 1 \
	-stim_times 1 stop-correct.txt SPMG \
	-stim_label 1 "stop-correct" \
	-stim_times 2 stop-incorrect.txt SPMG \
	-stim_label 2 "stop-incorrect" \
	-stim_file 3 ${sub}-${paradigm}-motion.1D'[0]' \
	-stim_label 3 "roll" \
	-stim_base 3 \
	-stim_file 4 ${sub}-${paradigm}-motion.1D'[1]' \
	-stim_label 4 "pitch" \
	-stim_base 4 \
	-stim_file 5 ${sub}-${paradigm}-motion.1D'[2]' \
	-stim_label 5 "yaw" \
	-stim_base 5 \
	-stim_file 6 ${sub}-${paradigm}-motion.1D'[3]' \
	-stim_label 6 "DS" \
	-stim_base 6 \
	-stim_file 7 ${sub}-${paradigm}-motion.1D'[4]' \
	-stim_label 7 "DL" \
	-stim_base 7 \
	-stim_file 8 ${sub}-${paradigm}-motion.1D'[5]' \
	-stim_label 8 "DP" \
	-stim_base 8 \
	-errts ${sub}-${paradigm}-errts \
	-bucket decon_bucket

echo "...........(pre)Deconvolution end..........."  


### STEP-2: Estimate the inherent blur already contained in the dataset before adding more###
echo "...........Estimate inherent blur (before adding more)..........."  
mkdir ${SCRATCHpath}/${project}/${paradigm}/${file_check_folder}/preBlur_est
3dFWHMx -dset ${sub}-${paradigm}-norm+tlrc -mask ${sub}-${paradigm}-mask+tlrc -unif -acf > ${SCRATCHpath}/${project}/${paradigm}/${file_check_folder}/preBlur_est/FWHM-norm-$sub.txt
#3dFWHMx -dset ${sub}-${sess}-${paradigm}-errts+tlrc -mask ${sub}-${sess}-${paradigm}-mask+tlrc -unif > ${SCRATCHpath}/${project}/${paradigm}/${file_check_folder}/preBlur_est/FWHM-errts-$sub-$sess.txt


### STEP-3: Apply additional blur using 3dBlurToFWHM. Output multiple FWHM for testing purposes###
echo "...........Additional Blur..........." 
cd ${SCRATCHpath}/${project}/${paradigm}/${sub}/
echo "...........7..........." #MTS: Output multiple FWHM for testing.
3dBlurToFWHM -FWHM 7 \
             -input ${sub}-${paradigm}-norm+tlrc \
             -prefix ${sub}-$paradigm-norm_blur7 \
	     -mask ${sub}-${paradigm}-mask+tlrc \
             -blurmaster ${sub}-${paradigm}-errts+tlrc  
             
if [ -1 -eq 0 ]; then             
	echo "...........8..........."      
	3dBlurToFWHM -FWHM 8 \
		     -input ${sub}-${paradigm}-norm+tlrc \
		     -prefix ${sub}-$paradigm-norm_blur8 \
		     -mask ${sub}-${paradigm}-mask+tlrc \
		     -blurmaster ${sub}-${paradigm}-errts+tlrc   
	echo "...........9..........." 	    
	3dBlurToFWHM -FWHM 9 \
		     -input ${sub}-${paradigm}-norm+tlrc \
		     -prefix ${sub}-$paradigm-norm_blur9 \
		     -mask ${sub}-${paradigm}-mask+tlrc \
		     -blurmaster ${sub}-${paradigm}-errts+tlrc  	    
fi

### STEP-4: Post-blur verification###
echo "...........Estimate post-blur (after adding more)..........."
mkdir ${SCRATCHpath}/${project}/${paradigm}/${file_check_folder}/postBlur_est  
3dFWHMx -dset ${sub}-${paradigm}-norm_blur7+tlrc -mask ${sub}-${paradigm}-mask+tlrc -unif -acf > ${SCRATCHpath}/${project}/${paradigm}/${file_check_folder}/postBlur_est/FWHM-norm7-$sub.txt

if [ -1 -eq 0 ]; then
	3dFWHMx -dset ${sub}-${paradigm}-norm_blur8+tlrc -mask ${sub}-${paradigm}-mask+tlrc -unif -acf > ${SCRATCHpath}/${project}/${paradigm}/${file_check_folder}/postBlur_est/FWHM-norm8-$sub.txt
	3dFWHMx -dset ${sub}-${paradigm}-norm_blur9+tlrc -mask ${sub}-${paradigm}-mask+tlrc -unif -acf > ${SCRATCHpath}/${project}/${paradigm}/${file_check_folder}/postBlur_est/FWHM-norm9-$sub.txt
fi

### STEP-5: Clean up###
echo "...........Delete errts file..........."  
rm  ${sub}-$paradigm-errts+tlrc*
rm decon_bucket*


### STEP-6: Combine all estimates of blur into a single file for easy visual inspection###
# see 4_MP_blur_out_estimates.sh for step 6

