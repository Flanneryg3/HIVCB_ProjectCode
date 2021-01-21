#!/bin/bash

#
# sub-409 was scrubbed for motion
# sub-283 has no stim_times in #$%^
# sub-287 has no stim_times in #$%^
# sub-296 has no stim_times in #$%^
# sub-319 has no stim_times in #$%^
# sub-268 never made an unaware error, so no stim file
# sub-273 never made an unaware error, so no stim file
# sub-331 never made an unaware error, so no stim file
# sub-294 never made aware erros, so no stim file
# sub-405 has no events.tsv file , so no stim_times
# sub-397 has no trial onsets in stim file
# sub-326 has only 1-2 runs, so they're scrubbed


3dMVM -prefix inhib_covar \
-jobs 8 \
-bsVars 'hiv*cb*sex+age+IQ' \
-qVars 'age,IQ' \
-qVarCenters '35.58,101.25'\
-SS_type 3 -mask /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/HIVCB_GroupMask+tlrc \
-num_glt 3 \
-gltLabel 1 hiv_by_sex -gltCode 1 'hiv : 1*pos -1*neg sex : 1*m -1*f' \
-gltLabel 2 cb_by_sex -gltCode 2 'cb : 1*pos -1*neg sex : 1*m -1*f' \
-gltLabel 3 hiv_cb_sex -gltCode 3 'hiv : 1*pos -1*neg cb : 1*pos -1*neg sex : 1*m -1*f' \
-dataTable @inhib_covar_datatable.txt
