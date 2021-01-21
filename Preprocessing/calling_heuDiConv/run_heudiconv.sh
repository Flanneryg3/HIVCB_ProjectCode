mapfile subArray < /home/data/nbc/Sutherland_HIVCB/code/sublist.txt
subjects=${subArray[@]}
echo ${subjects}
heudiconv -d /home/data/nbc/DICOM/MSUT_HIV_CB/{subject}/*/*/*.dcm \
	-s ${subjects} -f hiv_cb.py \
	-c dcm2niix -o /home/data/nbc/Sutherland_HIVCB/206_run6/ --bids
chmod -R 774 /home/data/nbc/Sutherland_HIVCB/206_run6/
