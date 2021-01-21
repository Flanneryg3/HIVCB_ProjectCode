#!/bin/bash


##########################################################################################

rois='PCC mPFC'
subjects='193 203 206 211 212 216 217 218 225 229 237 238 240 242 244 247 248 250 253 254 257 259 263 268 273 273 280 282 285 287 289 290 291 293 294 295 296 297 299 300 301 302 306 307 309 310 311 313 315 316 317 319 321 323 324 326 328 331 332 336 337 339 341 343 344 345 346 348 350 351 352 354 357 358 360 363 365 366 373 375 380 383 389 392 397 398 399 401 402 403 404 405 407 410'
##########################################################################################
for sub in ${subjects}; do
	echo "subject: ${sub}"
	echo "################################"
	cd /Users/jflanner/Documents/RESTING/data_rs/sub-${sub}/


### STEP-0: CLEAN UP FILES FROM ANY PREVIOUS RUN OF THIS SCRIPT ###
	rm -f ${sub}-*-bucket_REML_6vox*+tlrc*
	rm -f X_*6vox*.jpg
	rm -f ${sub}-*-xmatrix_6vox*.1D
	rm -f 3dREMLfit.err
	rm -f 3dDeconvolve.err
	rm -f Decon.REML_cmd

#3dresample -prefix ./yeo_network_masks/yeo_VAN_func+tlrc -master ./data_rs/sub-273/sub-273_task-rest_run-01_space-MNI152NLin2009cAsym_desc-preproc_bold-clean.nii -inset ./yeo_network_masks/yeo_VAN-2mm+tlrc

### STEP-1: DECON
	for roi in ${rois} ;
	do
		echo "########## Decon ${sub}-${roi} START ##########"
		3dDeconvolve -input sub-${sub}_task-rest_run-01_space-MNI152NLin2009cAsym_desc-preproc_bold-clean.nii* \
	    	-x1D_stop \
	    	-mask ${sub}-mask+tlrc \
	    	-num_stimts 1 \
	    	-jobs 6 \
	    	-svd \
	    	-local_times \
	    	-basis_normall 1 \
	    	-stim_file 1 ${sub}-${roi}-6_voxels.txt \
	    	-stim_label 1 "ROI-${roi}" \
	    	-xjpeg X_norm_6vox-${roi}.jpg \
	    	-x1D ${sub}-${roi}-xmatrix_6vox.1D

		3dREMLfit -matrix ${sub}-${roi}-xmatrix_6vox.1D \
      		-input sub-${sub}_task-rest_run-01_space-MNI152NLin2009cAsym_desc-preproc_bold-clean.nii* \
	      	-mask ${sub}-mask+tlrc \
	      	-fout \
	      	-tout \
	      	-Rbuck ${sub}-${roi}-bucket_REML_6vox \
	        -verb
		done
done

for sub in ${subjects}; do
  	cd /Users/jflanner/Documents/RESTING/data_rs/sub-${sub}/
    for roi in ${rois} ;
    do
      3dcalc -a ${sub}-${roi}-bucket_REML_6vox+tlrc -expr 'atanh(a)' -prefix ${sub}-${roi}-bucket_z_REML_6vox+tlrc
    done
done

for sub in ${subjects}; do
	cd /Users/jflanner/Documents/RESTING/data_rs/sub-${sub}/
	cp *-bucket_z_REML_6vox+tlrc.* /Users/jflanner/Documents/RESTING/group_level/
done
### STEP-3: CLEAN UP
echo "########## CLEAN UP ##########"
