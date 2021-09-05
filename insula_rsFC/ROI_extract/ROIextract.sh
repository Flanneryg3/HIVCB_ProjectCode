#!/bin/bash

rois='RV_roi'
dois='LD_roi'
subjects='193 203 206 211 212 216 217 218 225 229 237 238 240 242 244 247 248 250 253 254 257 259 263 268 273 273 280 282 285 287 289 290 291 293 294 295 296 297 299 300 301 302 306 307 309 310 311 313 315 316 317 319 321 323 324 326 328 331 332 336 337 339 341 343 344 345 346 348 350 351 352 354 357 358 360 363 365 366 373 375 380 383 389 392 397 398 399 401 402 403 404 405 407 410'
##########################################################################################
cd /Users/jflanner/Documents/RESTING/
for r in ${rois}
do
	for sub in ${subjects}
	do
		3dROIstats -mask /Users/jflanner/Documents/RESTING/insula_group_effects/part/group_ANOVA/${r}_mask+tlrc -nzmean ./group_level/${sub}-insula_R-bucket_z_REML+tlrc.BRIK'[7]' > ./ROIextract_out/${sub}-${r}-betas.txt
	done
done

for d in ${dois}
do
	for sub in ${subjects}
	do
		3dROIstats -mask /Users/jflanner/Documents/RESTING/insula_group_effects/part/group_ANOVA/${d}_mask+tlrc -nzmean ./group_level/${sub}-insula_L-bucket_z_REML+tlrc.BRIK'[1]' > ./ROIextract_out/${sub}-${d}-betas.txt
	done
done

cd /Users/jflanner/Documents/RESTING/ROIextract_out/
for r in ${rois}
do
	cat *${r}-betas.txt > CAT-${r}-betas.txt
done

cd /Users/jflanner/Documents/RESTING/ROIextract_out/
for d in ${dois}
do
	cat *${d}-betas.txt > CAT-${d}-betas.txt
done
