#!/bin/bash

rois='dinsula_L dinsula_R vinsula_L vinsula_R pinsula_L pinsula_R'
subjects='193 203 206 211 212 216 217 218 225 229 237 238 240 242 244 247 248 250 253 254 257 259 263 268 273 273 280 282 285 287 289 290 291 293 294 295 296 297 299 300 301 302 306 307 309 310 311 313 315 316 317 319 321 323 324 326 328 331 332 336 337 339 341 343 344 345 346 348 350 351 352 354 357 358 360 363 365 366 373 375 380 383 389 392 397 398 399 401 402 403 404 405 407 410'
##########################################################################################



for sub in ${subjects}; do
  	cd /Users/jflanner/Documents/RESTING/data_rs/sub-${sub}/
    for roi in ${rois} ;
    do
      3dcalc -a ${sub}-${roi}-bucket_REML_norm_blur+tlrc -expr 'atanh(a)' -prefix ${sub}-${roi}-bucket_z_REML+tlrc
    done
done

for sub in ${subjects}; do
    for roi in ${rois} ; do
	     cd /Users/jflanner/Documents/RESTING/data_rs/sub-${sub}/
       cp *-${roi}-bucket_z_REML+tlrc.* /Users/jflanner/Documents/RESTING/group_level/
    done
done
