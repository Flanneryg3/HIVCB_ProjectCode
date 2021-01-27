
#inhibition

#vmPFC
3dmaskdump -dball 0 -53 -13 3 inhib-all-ttest+tlrc[] ./wholesample_ROI/vmpfc_inhib
#mPFC
3dmaskdump -dbox 0 -22 47 3 inhib-all-ttest+tlrc[] ./wholesample_ROI/mPFC_inhib
#Right Thalamus
3dmaskdump -dbox 10 18 10 3 inhib-all-ttest+tlrc[] ./wholesample_ROI/Rthal_inhib
#Right Anterior Insula
3dmaskdump -dbox 41 -21 -5 3 inhib-all-ttest+tlrc[] ./wholesample_ROI/RAI_inhib
#Left Anterior Insula
3dmaskdump -dbox -41 -21 -5 3 inhib-all-ttest+tlrc[] ./wholesample_ROI/LAI_inhib
#Right Putamen
3dmaskdump -dbox 18 -8 -9 3 inhib-all-ttest+tlrc[] ./wholesample_ROI/Rput_inhib
#Left Putamen
3dmaskdump -dbox -18 -8 -9 3 inhib-all-ttest+tlrc[] ./wholesample_ROI/Lput_inhib
#Right Inferior Frontal
3dmaskdump -dbox 34 -36 -12 3 inhib-all-ttest+tlrc[] ./wholesample_ROI/RIF_inhib
#Left inferior Frontal
3dmaskdump -dbox -31 -36 -14 3 inhib-all-ttest+tlrc[] ./wholesample_ROI/LIF_ihhib

#awareness

#medial motor area
3dmaskdump -dball -2 0 59 3 aware-all-ttest+tlrc[] ./wholesample_ROI/Mmotor_aware
#Right Putamen
3dmaskdump -dbox 29 2 3 3 aware-all-ttest+tlrc[] ./wholesample_ROI/Rput_aware
#Right posterior insula
3dmaskdump -dbox 48 -3 3 3 aware-all-ttest+tlrc[] ./wholesample_ROI/RPI_aware
#Left Posterior Insula
3dmaskdump -dbox -49 -11 1 3 aware-all-ttest+tlrc[] ./wholesample_ROI/LPI_aware
#Right Thalamus
3dmaskdump -dbox 14 22 9 3 aware-all-ttest+tlrc[] ./wholesample_ROI/LIF_aware
