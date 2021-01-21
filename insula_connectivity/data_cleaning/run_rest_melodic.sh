proj_dir='/home/data/nbc/Sutherland_HIVCB'

deriv=3dTproject_denoise_acompcor_csfwm+12mo+0.35mm+ica

sbatch -J msuthivcb-rest-ica -e $proj_dir/code/errorfiles/rest-ica -o $proj_dir/code/outfiles/rest-ica -n 12 --qos pq_nbc --account acc_nbc -p investor --wrap="melodic -i $proj_dir/dset/derivatives/$deriv/resting-state_filenames.txt -o $proj_dir/dset/derivatives/$deriv/groupICA_d30 --tr=2 --nobet --bgthreshold=1 -a concat --bgimage=/home/data/cis/templateflow/tpl-MNI152NLin2009cAsym/tpl-MNI152NLin2009cAsym_res-02_desc-brain_T1w.nii.gz -m /home/data/cis/templateflow/tpl-MNI152NLin2009cAsym/tpl-MNI152NLin2009cAsym_res-02_desc-brain_mask.nii.gz --report --Oall -d 30"
