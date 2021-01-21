#!/bin/bash


subjects='193 194 198 211 212 216 218 225 229 237 238 240 242 244 247 248 250 254 257 258 259 263 266 268 273 279 280 282 283 285 287 289 290 291 293 294 295 297 299 301 302 306 307 309 310 311 313 314 315 316 317 318 319 320 321 323 324 326 328 331 332 333 334 336 337 339 340 341 342 343 344 345 346 348 350 351 352 354 357 360 363 365 366 370 373 375 378 383 387 388 389 392 397 398 399 401 402 403 404 405 407 409 410 300 358 253 380 206 217'

#3dresample -prefix /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/group_effects/RECN_mask+tlrc -master /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/preprocessed-data/sub-198/func/sub-198-eat_inhib.nii.gz_REML+tlrc -inset /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/group_effects/RECN.nii

#3dresample -prefix /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/group_effects/LECN_mask+tlrc -master /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/preprocessed-data/sub-198/func/sub-198-eat_inhib.nii.gz_REML+tlrc -inset /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/group_effects/LECN.nii

#3dresample -prefix /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/group_effects/SN_mask+tlrc -master /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/preprocessed-data/sub-198/func/sub-198-eat_inhib.nii.gz_REML+tlrc -inset /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/group_effects/SN.nii

#3dresample -prefix /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/group_effects/DMN_mask+tlrc -master /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/preprocessed-data/sub-198/func/sub-198-eat_inhib.nii.gz_REML+tlrc -inset /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/group_effects/dDMN.nii


rois='RECN LECN SN DMN'

#for r in ${rois}; do
	#for sub in ${subjects}; do
		#3dROIstats -mask /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/group_effects/${r}_mask+tlrc -nzmean /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/preprocessed-data/sub-${sub}/func/sub-${sub}-eat_inhib.nii.gz_REML+tlrc[3] > /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/ROIextract/${sub}-${r}-nogo-correct-betas.txt

		#3dROIstats -mask /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/group_effects/${r}_mask+tlrc -nzmean /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/preprocessed-data/sub-${sub}/func/sub-${sub}-eat_inhib.nii.gz_REML+tlrc[5] > /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/ROIextract/${sub}-${r}-nogo-incorrect-betas.txt

		#3dROIstats -mask /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/group_effects/${r}+tlrc -nzmean /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/preprocessed-data/sub-${sub}/func/sub-${sub}-eat_onebefore.nii.gz_REML+tlrc[7] > /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/ROIextract/${sub}-${r}-onebefore-nogo-cor-err-betas.txt

	#done
#done



#cd /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/ROIextract/
#for r in ${rois}; do     
	#cat *${r}-nogo-correct-betas.txt > CAT-${r}-nogo-correct-betas.txt
	#cat *${r}-nogo-incorrect-betas.txt > CAT-${r}-nogo-incorrect-betas.txt
	#cat *${r}-onebefore-nogo-cor-err-betas.txt > CAT-${r}-onebefore-nogo-cor-err-betas.txt
#done

for r in ${rois}; do
	for sub in ${subjects}; do
		3dROIstats -mask /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/group_effects/${r}_mask+tlrc -nzmean /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/preprocessed-data/sub-${sub}/func/sub-${sub}-eat_aware.nii.gz_REML+tlrc[5] > /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/ROIextract/${sub}-${r}-aware-betas.txt

		3dROIstats -mask /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/group_effects/${r}_mask+tlrc -nzmean /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/preprocessed-data/sub-${sub}/func/sub-${sub}-eat_aware.nii.gz_REML+tlrc[7] > /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/ROIextract/${sub}-${r}-unaware-betas.txt

		3dROIstats -mask /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/group_effects/${r}_mask+tlrc -nzmean /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/preprocessed-data/sub-${sub}/func/sub-${sub}-eat_aware.nii.gz_REML+tlrc[9] > /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/ROIextract/${sub}-${r}-aware-unaware-betas.txt

	done
done



cd /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/ROIextract/
for r in ${rois}; do     
	cat *${r}-aware-betas.txt > CAT-${r}-aware-betas.txt
	cat *${r}-unaware-betas.txt > CAT-${r}-unaware-betas.txt
	cat *${r}-aware-unaware-betas.txt > CAT-${r}-aware-unaware-betas.txt
done






#for r in ${rois}; do
	#for sub in ${subjects}; do
		#3dROIstats -mask /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/group_effects/${r}+tlrc -nzmean /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/preprocessed-data/sub-${sub}/func/sub-${sub}-eat_inhib.nii.gz_REML+tlrc[3] > /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/ROIextract/${sub}-${r}-inhib-nogo-correct-betas.txt

		#3dROIstats -mask /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/group_effects/${r}+tlrc -nzmean /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/preprocessed-data/sub-${sub}/func/sub-${sub}-eat_inhib.nii.gz_REML+tlrc[5] > /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/ROIextract/${sub}-${r}-inhib-nogo-incorrect-betas.txt

		#3dROIstats -mask /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/group_effects/${r}+tlrc -nzmean /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/preprocessed-data/sub-${sub}/func/sub-${sub}-eat_inhib.nii.gz_REML+tlrc[7] > /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/ROIextract/${sub}-${r}-inhib-nogo-cor-err-betas.txt

	#done
#done



#cd /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/ROIextract/
#for r in ${rois}; do     
	#cat *${r}-inhib-nogo-correct-betas.txt > CAT-${r}-inhib-nogo-correct-betas.txt
	#cat *${r}-inhib-nogo-incorrect-betas.txt > CAT-${r}-inhib-nogo-incorrect-betas.txt
	#cat *${r}-inhib-nogo-cor-err-betas.txt > CAT-${r}-inhib-nogo-cor-err-betas.txt
#done

