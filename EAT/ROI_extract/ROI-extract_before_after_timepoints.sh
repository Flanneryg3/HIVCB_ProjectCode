#!/bin/bash



subjects='193 194 198 211 212 216 218 225 229 237 238 240 242 244 247 248 250 254 257 258 259 263 266 268 273 279 280 282 283 285 287 289 290 291 293 294 295 297 299 301 302 306 307 309 310 311 313 314 315 316 317 318 319 320 321 323 324 326 328 331 332 333 334 336 337 339 340 341 342 343 344 345 346 348 350 351 352 354 357 360 363 365 366 370 373 375 378 383 387 388 389 392 397 398 399 401 402 403 404 405 407 409 410 300 358 253 380 206 217'

rois='hiv-inhib_mask'

for r in ${rois}; do
	for sub in ${subjects}; do
		3dROIstats -mask /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/group_effects/${r}+tlrc -nzmean /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/preprocessed-data/sub-${sub}/func/sub-${sub}-eat_threebefore.nii.gz_REML+tlrc[3] > /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/ROIextract/${sub}-${r}-threebefore-nogo-correct-betas.txt

		3dROIstats -mask /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/group_effects/${r}+tlrc -nzmean /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/preprocessed-data/sub-${sub}/func/sub-${sub}-eat_threebefore.nii.gz_REML+tlrc[5] > /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/ROIextract/${sub}-${r}-threebefore-nogo-incorrect-betas.txt

		3dROIstats -mask /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/group_effects/${r}+tlrc -nzmean /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/preprocessed-data/sub-${sub}/func/sub-${sub}-eat_threebefore.nii.gz_REML+tlrc[7] > /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/ROIextract/${sub}-${r}-threebefore-nogo-cor-err-betas.txt

	done
done



cd /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/ROIextract/
for r in ${rois}; do     
	cat *${r}-threebefore-nogo-correct-betas.txt > CAT-${r}-threebefore-nogo-correct-betas.txt
	cat *${r}-threebefore-nogo-incorrect-betas.txt > CAT-${r}-threebefore-nogo-incorrect-betas.txt
	cat *${r}-threebefore-nogo-cor-err-betas.txt > CAT-${r}-threebefore-nogo-cor-err-betas.txt
done

for r in ${rois}; do
	for sub in ${subjects}; do
		3dROIstats -mask /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/group_effects/${r}+tlrc -nzmean /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/preprocessed-data/sub-${sub}/func/sub-${sub}-eat_oneafter.nii.gz_REML+tlrc[3] > /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/ROIextract/${sub}-${r}-oneafter-nogo-correct-betas.txt

		3dROIstats -mask /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/group_effects/${r}+tlrc -nzmean /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/preprocessed-data/sub-${sub}/func/sub-${sub}-eat_oneafter.nii.gz_REML+tlrc[5] > /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/ROIextract/${sub}-${r}-oneafter-nogo-incorrect-betas.txt

		3dROIstats -mask /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/group_effects/${r}+tlrc -nzmean /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/preprocessed-data/sub-${sub}/func/sub-${sub}-eat_oneafter.nii.gz_REML+tlrc[7] > /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/ROIextract/${sub}-${r}-oneafter-nogo-cor-err-betas.txt

	done
done



cd /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/ROIextract/
for r in ${rois}; do     
	cat *${r}-oneafter-nogo-correct-betas.txt > CAT-${r}-oneafter-nogo-correct-betas.txt
	cat *${r}-oneafter-nogo-incorrect-betas.txt > CAT-${r}-oneafter-nogo-incorrect-betas.txt
	cat *${r}-oneafter-nogo-cor-err-betas.txt > CAT-${r}-oneafter-nogo-cor-err-betas.txt
done


for r in ${rois}; do
	for sub in ${subjects}; do
		3dROIstats -mask /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/group_effects/${r}+tlrc -nzmean /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/preprocessed-data/sub-${sub}/func/sub-${sub}-eat_twoafter.nii.gz_REML+tlrc[3] > /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/ROIextract/${sub}-${r}-twoafter-nogo-correct-betas.txt

		3dROIstats -mask /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/group_effects/${r}+tlrc -nzmean /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/preprocessed-data/sub-${sub}/func/sub-${sub}-eat_twoafter.nii.gz_REML+tlrc[5] > /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/ROIextract/${sub}-${r}-twoafter-nogo-incorrect-betas.txt

		3dROIstats -mask /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/group_effects/${r}+tlrc -nzmean /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/preprocessed-data/sub-${sub}/func/sub-${sub}-eat_twoafter.nii.gz_REML+tlrc[7] > /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/ROIextract/${sub}-${r}-twoafter-nogo-cor-err-betas.txt

	done
done



cd /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/ROIextract/
for r in ${rois}; do     
	cat *${r}-twoafter-nogo-correct-betas.txt > CAT-${r}-twoafter-nogo-correct-betas.txt
	cat *${r}-twoafter-nogo-incorrect-betas.txt > CAT-${r}-twoafter-nogo-incorrect-betas.txt
	cat *${r}-twoafter-nogo-cor-err-betas.txt > CAT-${r}-twoafter-nogo-cor-err-betas.txt
done

for r in ${rois}; do
	for sub in ${subjects}; do
		3dROIstats -mask /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/group_effects/${r}+tlrc -nzmean /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/preprocessed-data/sub-${sub}/func/sub-${sub}-eat_threeafter.nii.gz_REML+tlrc[3] > /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/ROIextract/${sub}-${r}-threeafter-nogo-correct-betas.txt

		3dROIstats -mask /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/group_effects/${r}+tlrc -nzmean /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/preprocessed-data/sub-${sub}/func/sub-${sub}-eat_threeafter.nii.gz_REML+tlrc[5] > /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/ROIextract/${sub}-${r}-threeafter-nogo-incorrect-betas.txt

		3dROIstats -mask /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/group_effects/${r}+tlrc -nzmean /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/preprocessed-data/sub-${sub}/func/sub-${sub}-eat_threeafter.nii.gz_REML+tlrc[7] > /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/ROIextract/${sub}-${r}-threeafter-nogo-cor-err-betas.txt

	done
done



cd /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/ROIextract/
for r in ${rois}; do     
	cat *${r}-threeafter-nogo-correct-betas.txt > CAT-${r}-threeafter-nogo-correct-betas.txt
	cat *${r}-threeafter-nogo-incorrect-betas.txt > CAT-${r}-threeafter-nogo-incorrect-betas.txt
	cat *${r}-threeafter-nogo-cor-err-betas.txt > CAT-${r}-threeafter-nogo-cor-err-betas.txt
done




