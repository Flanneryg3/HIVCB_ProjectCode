#!/bin/bash

subjects='193 194 198 203 206 211 212 216 217 218 225 229 237 238 240 242 244 247 248 250 253 254 257 258 259 263 266 268 273 279 280 282 283 285 287 289 290 291 293 294 295 297 299 300 301 302 306 307 309 310 311 313 314 315 316 317 318 319 320 321 323 324 326 328 331 332 333 334 336 337 339 340 341 342 343 344 345 346 348 350 351 352 354 357 358 360 363 365 366 370 373 375 378 380 383 387 388 389 392 397 398 399 401 402 403 404 405 407 409 410'

#no events for go_incorrect requiring GOFORIT 3: 250 254 282 311 332 350 389
#missing run 6: 300 358 (only 5 tsv files, censor file missing run 6): 206 253

#thrown out
#no events for nogo_unaware: 273 268 326 331
#no events for nogo_aware: 294
#other issues: 203: only 3 tsv files, 217: only 4 tsv files, 397: censor, 380


for sub in ${subjects}; do
	cd /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/preprocessed-data/sub-${sub}/func
	rm *${sub}-eat_aware*
	rm *aware-xjpeg*
	rm *aware-x1D*
	3dDeconvolve \
	-allzero_OK \
	-jobs 6 \
	-mask sub-${sub}_task-errorawareness_run-01_bold_space-MNI152NLin2009cAsym_brainmask.nii.gz \
	-polort A \
	-force_TR 2 \
	-input sub-${sub}_scaled_run_01.nii.gz sub-${sub}_scaled_run_02.nii.gz sub-${sub}_scaled_run_03.nii.gz sub-${sub}_scaled_run_04.nii.gz sub-${sub}_scaled_run_05.nii.gz sub-${sub}_scaled_run_06.nii.gz \
	-censor censor_cat.1D \
	-ortvec motion_cat.1D mopars \
	-local_times \
	-stim_times_subtract 10 \
	-num_stimts 4 \
	-GOFORIT 3 \
	-stim_times 1 go_incorrect.1D SPMG1 -stim_label 1 go_incorrect \
	-stim_times 2 nogo_correct.1D SPMG1 -stim_label 2 nogo_correct \
	-stim_times 3 nogo_aware.1D SPMG1 -stim_label 3 nogo_aware \
	-stim_times 4 nogo_unaware.1D SPMG1 -stim_label 4 nogo_unaware \
	-num_glt 1 \
	-gltsym 'SYM: +nogo_aware -nogo_unaware' -glt_label 1 nogo_aware-unaware \
	-tout -xsave -xjpeg sub-${sub}-aware-xjpeg -x1D sub-${sub}-aware-x1D -allzero_OK \
	-bucket sub-${sub}-eat_aware.nii.gz

	3dREMLfit -matrix sub-${sub}-aware-x1D \
	 -input "sub-${sub}_scaled_run_01.nii.gz sub-${sub}_scaled_run_02.nii.gz sub-${sub}_scaled_run_03.nii.gz sub-${sub}_scaled_run_04.nii.gz sub-${sub}_scaled_run_05.nii.gz sub-${sub}_scaled_run_06.nii.gz" \
	 -GOFORIT 3 \
	 -mask sub-${sub}_task-errorawareness_run-01_bold_space-MNI152NLin2009cAsym_brainmask.nii.gz \
	 -tout -Rbuck sub-${sub}-eat_aware.nii.gz_REML -Rvar sub-${sub}-eat_aware.nii.gz_REMLvar -verb $*
done
