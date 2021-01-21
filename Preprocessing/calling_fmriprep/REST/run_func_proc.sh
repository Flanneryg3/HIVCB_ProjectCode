proj_dir='/home/data/nbc/Sutherland_HIVCB'

if [ ! -d $proj_dir/dset/derivatives/dwidenoise-05.21.2019_fmriprep-1.5.0/ ]; then
    mkdir -p $proj_dir/dset/derivatives/dwidenoise-05.21.2019_fmriprep-1.5.0/
fi

subs=$(dir $proj_dir/dset/)
subs=sub-333
for tmpsub in $subs; do
    if [[ $tmpsub == sub-* ]]; then
        if [ ! -d $proj_dir/dset/derivatives/dwidenoise-05.21.2019_fmriprep-1.5.0/$tmpsub ]; then
            echo $tmpsub
            #while [ $(squeue -u miriedel | wc -l) -gt 22 ]; do
            #    sleep 30m
            #done
            sbatch -J $tmpsub-func-proc -e $proj_dir/code/errorfiles/$tmpsub-func-proc -o $proj_dir/code/outfiles/$tmpsub-func-proc -c 4 --qos pq_nbc -p centos7 --account acc_nbc --wrap="python3 $proj_dir/code/func_proc.py -b $proj_dir/dset -w /scratch/$USER/$tmpsub-func-proc --sub $tmpsub --n_procs 4"
        fi
    fi
done
