#!/bin/bash

subjects='273'
#193 203 206 211 212 216 217 218 225 229 237 238 240 242 244 247 248 250 253 254 257 259 263 268 273 273 280 282 285 287 289 290 291 293 294 295 296 297 299 300 301 302 306 307 309 310 311 313 315 316 317 319 321 323 324 326 328 331 332 336 337 339 341 343 344 345 346 348 350 351 352 354 357 358 360 363 365 366 373 375 380 383 389 392 397 398 399 401 402 403 404 405 407 410'


for sub in ${subjects} ;do
  cd /Users/jflanner/Documents/RESTING/data_rs/sub-${sub}/
  3dBlurToFWHM -prefix sub-${sub}_task-rest_run-01_space-MNI152NLin2009cAsym_desc-preproc_bold-clean-smoothed-8 -mask sub-${sub}_task-rest_run-01_space-MNI152NLin2009cAsym_desc-preproc_bold-clean.nii* -FWHM 8 -detrend -input sub-${sub}_task-rest_run-01_space-MNI152NLin2009cAsym_desc-preproc_bold-clean.nii* -blurmaster sub-${sub}_task-rest_run-01_space-MNI152NLin2009cAsym_desc-preproc_bold-clean.nii*

  #3dTstat -prefix sub-${sub}_task-rest_run-01_space-MNI152NLin2009cAsym_desc-preproc_bold-clean-smoothed-8-mean -mean sub-${sub}_task-rest_run-01_space-MNI152NLin2009cAsym_desc-preproc_bold-clean-smoothed-8+tlrc

  #3dcalc -prefix sub-${sub}_task-rest_run-01_space-MNI152NLin2009cAsym_desc-preproc_bold-clean-smoothed-8-scaled -a sub-${sub}_task-rest_run-01_space-MNI152NLin2009cAsym_desc-preproc_bold-clean-smoothed-8+tlrc -expr 'a-1000'

  #3dcalc -prefix sub-${sub}_task-rest_run-01_space-MNI152NLin2009cAsym_desc-preproc_bold-clean-smoothed-8-scaled -a sub-${sub}_task-rest_run-01_space-MNI152NLin2009cAsym_desc-preproc_bold-clean-smoothed-8 -b sub-${sub}_task-rest_run-01_space-MNI152NLin2009cAsym_desc-preproc_bold-clean-smoothed-8-mean -expr 'a/b*100'

done
