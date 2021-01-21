#!/bin/bash


##########################################################################################

hem='L R'
subjects='273'
#203 206 211 212 216 217 218 225 193 229 237 238 240 242 244 247 248 250 253 254 257 259 263 268 273 273 280 282 285 287 289 290 291 293 294 295 296 297 299 300 301 302 306 307 309 310 311 313 315 316 317 319 321 323 324 326 328 331 332 336 337 339 341 343 344 345 346 348 350 351 352 354 357 358 360 363 365 366 373 375 380 383 389 392 397 398 399 401 402 403 404 405 407 410'
##########################################################################################
for sub in ${subjects}; do
	echo "subject: ${sub}"
	echo "################################"
	cd /Users/jflanner/Documents/RESTING/data_rs/sub-${sub}/


### STEP-0: CLEAN UP FILES FROM ANY PREVIOUS RUN OF THIS SCRIPT ###
	#rm -f ${sub}-*-bucket_REML_insula*+tlrc*
	#rm -f X_*insula*.jpg
	#rm -f ${sub}-*-xmatrix_insula*.1D
	#rm -f 3dREMLfit.err
	#rm -f 3dDeconvolve.err
	#rm -f Decon.REML_cmd

#3dresample -prefix ./yeo_network_masks/yeo_VAN_func+tlrc -master ./data_rs/sub-273/sub-273_task-rest_run-01_space-MNI152NLin2009cAsym_desc-preproc_bold-clean.nii -inset ./yeo_network_masks/yeo_VAN-2mm+tlrc

### STEP-1: DECON
	for h in ${hem} ;
	do
		echo "########## Decon ${sub}-${h} START ##########"
		3dDeconvolve -input sub-${sub}_task-rest_run-01_space-MNI152NLin2009cAsym_desc-preproc_bold-clean-smoothed-8+tlrc \
	    	-x1D_stop \
	    	-mask /Users/jflanner/Documents/RESTING/group_mask/${sub}-mask-2mm+tlrc \
	    	-num_stimts 3 \
	    	-jobs 6 \
	    	-svd \
	    	-local_times \
	    	-basis_normall 1 \
	    	-stim_file 1 ${sub}-dinsula_${h}.txt \
				-stim_file 2 ${sub}-pinsula_${h}.txt \
				-stim_file 3 ${sub}-vinsula_${h}.txt \
	    	-stim_label 1 "ROI-dinsula_${h}" \
				-stim_label 2 "ROI-pinsula_${h}" \
				-stim_label 3 "ROI-vinsula_${h}" \
	    	-x1D ${sub}-sm8-insula_${h}-xmatrix.1D

		3dREMLfit -matrix ${sub}-sm8-insula_${h}-xmatrix.1D \
      		-input sub-${sub}_task-rest_run-01_space-MNI152NLin2009cAsym_desc-preproc_bold-clean-smoothed-8+tlrc \
	      	-mask /Users/jflanner/Documents/RESTING/group_mask/${sub}-mask-2mm+tlrc \
	      	-fout \
	      	-tout \
	      	-Rbuck ${sub}-sm8-insula_${h}-bucket_REML \
	        -verb
		done
done

for sub in ${subjects}; do
  	cd /Users/jflanner/Documents/RESTING/data_rs/sub-${sub}/
    for h in ${hem} ;
    do
      3dcalc -a ${sub}-sm8-insula_${h}-bucket_REML+tlrc -expr 'atanh(a)' -prefix ${sub}-sm8-insula_${h}-bucket_z_REML+tlrc
    done
done

for sub in ${subjects}; do
	cd /Users/jflanner/Documents/RESTING/data_rs/sub-${sub}/
	cp *-sm8-insula_*-bucket_z_REML+tlrc.* /Users/jflanner/Documents/RESTING/group_level/
done
### STEP-3: CLEAN UP
echo "########## CLEAN UP ##########"
