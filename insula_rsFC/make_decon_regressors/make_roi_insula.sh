#!/bin/bash

rois='dinsula_L dinsula_R pinsula_L pinsula_R vinsula_L vinsula_R'
#gunzip ./data_rs/sub-273/sub-273_task-rest_run-01_space-MNI152NLin2009cAsym_desc-preproc_bold-clean.nii.gz
for roi in ${rois}; do
	#rm -f ./data_rs/ROIs/${roi}-2mm+tlrc*
	3dresample -prefix /Users/jflanner/Documents/RESTING/data_rs/ROIs/${roi}+tlrc -master /Users/jflanner/Documents/RESTING/data_rs/sub-273/sub-273_task-rest_run-01_space-MNI152NLin2009cAsym_desc-preproc_bold-clean.nii -inset /Users/jflanner/Documents/RESTING/data_rs/ROIs/${roi}.nii.gz
	#align_epi_anat.py -anat2epi -anat ./data_rs/ROIs/${roi}+tlrc -epi ./data_rs/sub-273/sub-273_task-rest_run-01_space-MNI152NLin2009cAsym_desc-preproc_bold-clean.nii -epi_base 0 -volreg off -tshift off -anat_has_skull no -epi_strip None -master_anat BASE
done




subjects='193 203 206 211 212 216 217 218 225 229 237 238 240 242 244 247 248 250 253 254 257 259 263 268 273 273 280 282 285 287 289 290 291 293 294 295 296 297 299 300 301 302 306 307 309 310 311 313 315 316 317 319 321 323 324 326 328 331 332 336 337 339 341 343 344 345 346 348 350 351 352 354 357 358 360 363 365 366 373 375 380 383 389 392 397 398 399 401 402 403 404 405 407 410'

for sub in ${subjects}; do
	cd /Users/jflanner/Documents/RESTING/data_rs/sub-${sub}/
	for roi in ${rois}; do
			rm -f ${sub}-${roi}.txt
	#gunzip ./data_rs/ROIs/${roi}-2mm+tlrc.BRIK.gz
	#gunzip sub-${sub}_task-rest_run-01_space-MNI152NLin2009cAsym_desc-preproc_bold-clean.nii.gz
		3dmaskave -q -mask /Users/jflanner/Documents/RESTING/data_rs/ROIs/${roi}+tlrc sub-${sub}_task-rest_run-01_space-MNI152NLin2009cAsym_desc-preproc_bold-clean.nii* > ${sub}-${roi}.txt
	done
done
