#!/bin/bash

##########################################################################################
rois='dinsula_L dinsula_R vinsula_L vinsula_R pinsula_L pinsula_R'
masks='RS-group-mask-50'
cd /Users/jflanner/Documents/RESTING/group_level/
for roi in ${rois} ;
do
	for mask in ${masks} ;
	do
		3dttest++ -prefix s_group-${roi}-connect+tlrc \
			-mask /Users/jflanner/Documents/RESTING/group_mask/${mask}+tlrc \
			-clustsim \
			-setA \
					193-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					203-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					206-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					211-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					212-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					216-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					217-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					218-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					225-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					229-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					237-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					238-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					240-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					242-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					244-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					247-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					248-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					250-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					253-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					254-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					257-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					259-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					263-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					268-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					273-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					280-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					282-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					285-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					287-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					289-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					290-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					291-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					293-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					294-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					295-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					296-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					297-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					299-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					300-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					301-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					302-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					306-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					307-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					309-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					310-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					311-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					313-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					315-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					316-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					317-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					319-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					321-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					323-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					324-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					326-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					328-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					331-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					332-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					336-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					337-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					339-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					341-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					343-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					344-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					345-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					346-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					348-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					350-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					351-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					352-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					354-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					357-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					358-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					360-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					363-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					365-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					366-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					373-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					375-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					380-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					383-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					389-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					392-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					397-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					398-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					399-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					401-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					402-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					403-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					404-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					405-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					407-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
					410-${roi}-bucket_z_REML+tlrc.BRIK'[1]' \
				-resid group-${roi}-resid.nii
		done
done

echo "END Ttest"
