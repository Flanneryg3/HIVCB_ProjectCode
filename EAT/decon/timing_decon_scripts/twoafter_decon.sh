#!/bin/bash

subjects='193 194 198 211 212 216 218 225 229 237 238 240 242 244 247 248 250 254 257 258 259 263 266 268 273 279 280 282 283 285 287 289 290 291 293 294 295 297 299 301 302 306 307 309 310 311 313 314 315 316 317 318 319 320 321 323 324 326 328 331 332 333 334 336 337 339 340 341 342 343 344 345 346 348 350 351 352 354 357 360 363 365 366 370 373 375 378 383 387 388 389 392 397 398 399 401 402 403 404 405 407 409 410 300 358 253 380 206 217'


#'193 194 198 211 212 216 218 225 229 237 238 240 242 244 247 248 250 254 257 258 259 263 266 268 273 279 280 282 283 285 287 289 290 291 293 294 295 296 297 299 301 302 306 307 309 310 311 313 314 315 316 317 318 319 320 321 323 324 326 328 331 332 333 334 336 337 339 340 341 342 343 344 345 346 348 350 351 352 354 357 360 363 365 366 370 373 375 378 380 383 387 388 389 392 398 399 401 402 403 404 405 407 409 410'

for sub in ${subjects}; do
	cd /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/preprocessed-data/sub-${sub}/func
	#rm *${sub}-inhib-x1D*
	#rm *${sub}-eat_inhib*
	3dDeconvolve \
	-jobs 6 \
	-allzero_OK \
	-GOFORIT 3 \
	-mask sub-${sub}_task-errorawareness_run-01_bold_space-MNI152NLin2009cAsym_brainmask.nii.gz \
	-polort A \
	-force_TR 2 \
	-input sub-${sub}_scaled_run_01.nii.gz sub-${sub}_scaled_run_02.nii.gz sub-${sub}_scaled_run_03.nii.gz sub-${sub}_scaled_run_04.nii.gz sub-${sub}_scaled_run_05.nii.gz sub-${sub}_scaled_run_06.nii.gz \
	-censor censor_cat.1D \
	-ortvec motion_cat.1D mopars \
	-local_times \
	-stim_times_subtract 10 \
	-num_stimts 3 \
	-stim_times 1 go_incorrect.1D SPMG1 -stim_label 1 go_incorrect \
	-stim_times 2 nogo_correct.1D SPMG1 -stim_label 2 nogo_correct \
	-stim_times 3 twoafter_error.1D SPMG1 -stim_label 3 twoafter_error \
	-num_glt 1 \
	-gltsym 'SYM: +nogo_correct -twoafter_error' -glt_label 1 correct-twoafter_error \
	-tout -xsave -xjpeg sub-${sub}-twoafter-xjpeg -x1D sub-${sub}-twoafter-x1D -allzero_OK \
	-bucket sub-${sub}-eat_twoafter.nii.gz

	3dREMLfit -matrix sub-${sub}-twoafter-x1D \
	 -input "sub-${sub}_scaled_run_01.nii.gz sub-${sub}_scaled_run_02.nii.gz sub-${sub}_scaled_run_03.nii.gz sub-${sub}_scaled_run_04.nii.gz sub-${sub}_scaled_run_05.nii.gz sub-${sub}_scaled_run_06.nii.gz" \
	 -mask sub-${sub}_task-errorawareness_run-01_bold_space-MNI152NLin2009cAsym_brainmask.nii.gz \
	 -GOFORIT 3 \
	 -tout -Rbuck sub-${sub}-eat_twoafter.nii.gz_REML -Rvar sub-${sub}-eat_twoafter.nii.gz_REMLvar -verb $*
done
