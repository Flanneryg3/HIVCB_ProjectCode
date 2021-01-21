proj_dir='/home/data/nbc/Sutherland_HIVCB'

#deriv=3dTproject_denoise_gsr+csf+wm+6mo
#deriv=3dTproject_denoise_csf+wm+12mo
#deriv=3dTproject_denoise_csf+wm+24mo
#behzadi et al., 2007
#deriv=3dTproject_denoise_acompcor+12mo
#muschelli et al., 2014
#deriv=3dTproject_denoise_acompcor_csfwm+12mo
deriv=3dTproject_denoise_acompcor_csfwm+12mo+0.35mm

if [ ! -d $proj_dir/dset/derivatives/$deriv/ ]; then
    mkdir -p $proj_dir/dset/derivatives/$deriv/
fi

subs=$(dir $proj_dir/dset/derivatives/dwidenoise-05.21.2019_fmriprep-1.5.0/)

for tmpsub in $subs; do
    if [[ $tmpsub == sub-* ]]; then
        
        if [ ! -d $proj_dir/dset/derivatives/$deriv/$tmpsub ]; then
            echo $tmpsub

            sbatch -J $tmpsub-3dtproject-denoise -e $proj_dir/code/errorfiles/$tmpsub-3dtproject-denoise -o $proj_dir/code/outfiles/$tmpsub-3dtproject-denoise -c 1 --qos pq_nbc -p investor --account acc_nbc --wrap="python3 $proj_dir/code/3dTproject_denoise.py -b $proj_dir/dset -w /scratch/$USER/$tmpsub-3dTproject-denoise --sub $tmpsub --deriv $deriv"

        fi
    fi
done
