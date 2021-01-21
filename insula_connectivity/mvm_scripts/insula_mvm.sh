#!/bin/bash



##################### Dorsal Insula #################################
######################################################################

######################## partial ##################################

3dMVM -prefix dinsula_L_p \
-jobs 8 \
-bsVars 'hiv*cb*sex+nic+fd+age' \
-qVars 'nic,fd,age' \
-qVarCenters '66.36559,0.12083,34.83870'\
-SS_type 3 -mask ./RS-group-mask-50+tlrc \
-dataTable @dinsula_L_p_sex_nic_datatable.txt

3dMVM -prefix dinsula_R_p \
-jobs 8 \
-bsVars 'hiv*cb*sex+nic+fd+age' \
-qVars 'nic,fd,age' \
-qVarCenters '66.36559,0.12083,34.83870'\
-SS_type 3 -mask ./RS-group-mask-50+tlrc \
-dataTable @dinsula_R_p_sex_nic_datatable.txt


######################## separate ##################################

3dMVM -prefix dinsula_L_s \
-jobs 8 \
-bsVars 'hiv*cb*sex+nic+fd+age' \
-qVars 'nic,fd,age' \
-qVarCenters '66.36559,0.12083,34.83870'\
-SS_type 3 -mask ./RS-group-mask-50+tlrc \
-dataTable @dinsula_L_s_sex_nic_datatable.txt

3dMVM -prefix dinsula_R_s \
-jobs 8 \
-bsVars 'hiv*cb*sex+nic+fd+age' \
-qVars 'nic,fd,age' \
-qVarCenters '66.36559,0.12083,34.83870'\
-SS_type 3 -mask ./RS-group-mask-50+tlrc \
-dataTable @dinsula_R_s_sex_nic_datatable.txt

###############################################################
###############################################################


###############################################################
###############################################################

###################### Posterior Insula #######################

###############################################################
###############################################################

######################## partial ##################################

3dMVM -prefix pinsula_L_p \
-jobs 8 \
-bsVars 'hiv*cb*sex+nic+fd+age' \
-qVars 'nic,fd,age' \
-qVarCenters '66.36559,0.12083,34.83870'\
-SS_type 3 -mask ./RS-group-mask-50+tlrc \
-dataTable @pinsula_L_p_sex_nic_datatable.txt

3dMVM -prefix pinsula_R_p \
-jobs 8 \
-bsVars 'hiv*cb*sex+nic+fd+age' \
-qVars 'nic,fd,age' \
-qVarCenters '66.36559,0.12083,34.83870'\
-SS_type 3 -mask ./RS-group-mask-50+tlrc \
-dataTable @pinsula_R_p_sex_nic_datatable.txt

###############################################################
###############################################################
######################## separate ##################################

3dMVM -prefix pinsula_L_s \
-jobs 8 \
-bsVars 'hiv*cb*sex+nic+fd+age' \
-qVars 'nic,fd,age' \
-qVarCenters '66.36559,0.12083,34.83870'\
-SS_type 3 -mask ./RS-group-mask-50+tlrc \
-dataTable @pinsula_L_s_sex_nic_datatable.txt

3dMVM -prefix pinsula_R_s \
-jobs 8 \
-bsVars 'hiv*cb*sex+nic+fd+age' \
-qVars 'nic,fd,age' \
-qVarCenters '66.36559,0.12083,34.83870'\
-SS_type 3 -mask ./RS-group-mask-50+tlrc \
-dataTable @pinsula_R_s_sex_nic_datatable.txt

###############################################################
###############################################################

###################### Ventral Insula #######################

###############################################################
###############################################################

######################## partial ##################################

3dMVM -prefix vinsula_L_p \
-jobs 8 \
-bsVars 'hiv*cb*sex+nic+fd+age' \
-qVars 'nic,fd,age' \
-qVarCenters '66.36559,0.12083,34.83870'\
-SS_type 3 -mask ./RS-group-mask-50+tlrc \
-dataTable @vinsula_L_p_sex_nic_datatable.txt

3dMVM -prefix vinsula_R_p \
-jobs 8 \
-bsVars 'hiv*cb*sex+nic+fd+age' \
-qVars 'nic,fd,age' \
-qVarCenters '66.36559,0.12083,34.83870'\
-SS_type 3 -mask ./RS-group-mask-50+tlrc \
-dataTable @vinsula_R_p_sex_nic_datatable.txt

######################## separate ##################################

3dMVM -prefix vinsula_L_s \
-jobs 8 \
-bsVars 'hiv*cb*sex+nic+fd+age' \
-qVars 'nic,fd,age' \
-qVarCenters '66.36559,0.12083,34.83870'\
-SS_type 3 -mask ./RS-group-mask-50+tlrc \
-dataTable @vinsula_L_s_sex_nic_datatable.txt

3dMVM -prefix vinsula_R_s \
-jobs 8 \
-bsVars 'hiv*cb*sex+nic+fd+age' \
-qVars 'nic,fd,age' \
-qVarCenters '66.36559,0.12083,34.83870'\
-SS_type 3 -mask ./RS-group-mask-50+tlrc \
-dataTable @vinsula_R_s_sex_nic_datatable.txt
