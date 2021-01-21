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


3dMVM -prefix inhib_group_correct \
-jobs 8 \
-bsVars 'hiv*cb' \
-SS_type 3 -mask /home/data/nbc/Sutherland_HIVCB/derivatives/afni-processing/group_effects/HIVCB_GroupMask+tlrc \
-dataTable @inhib_mvm_datatable.txt

