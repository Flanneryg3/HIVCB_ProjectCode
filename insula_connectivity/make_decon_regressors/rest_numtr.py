#!/usr/bin/env python3
"""
Based on
https://github.com/BIDS-Apps/example/blob/aa0d4808974d79c9fbe54d56d3b47bb2cf4e0a0d/run.py
"""
import os
import os.path as op
import shutil
import subprocess
from glob import glob
import argparse
import pandas as pd
import nibabel as nib
import seaborn as sns
import matplotlib.pyplot as plt


def run(command, env={}):
    merged_env = os.environ
    merged_env.update(env)
    process = subprocess.Popen(command, stdout=subprocess.PIPE,
                               stderr=subprocess.STDOUT, shell=True,
                               env=merged_env)
    while True:
        line = process.stdout.readline()
        #line = str(line).encode('utf-8')[:-1]
        line=str(line, 'utf-8')[:-1]
        print(line)
        if line == '' and process.poll() is not None:
            break

    if process.returncode != 0:
        raise Exception("Non zero return code: {0}\n"
                        "{1}\n\n{2}".format(process.returncode, command,
                                            process.stdout.read()))


def get_parser():
    parser = argparse.ArgumentParser(description='Run MRIQC on BIDS dataset.')
    parser.add_argument('-b', '--bidsdir', required=True, dest='bids_dir',
                        help=('Output directory for BIDS dataset and '
                              'derivatives.'))
    parser.add_argument('--derivative', required=True, dest='deriv',
                        help='Derivative folder containg the pre-processed resting-state data.', default=None)
    return parser


def main(argv=None):
    args = get_parser().parse_args(argv)
    
    subs = sorted(glob(op.join(args.bids_dir, 'sub-*')))
    
    for tmp_sub in subs:
    
        rs_files = sorted(glob(op.join(args.bids_dir, tmp_sub, 'func', '*rest*.nii.gz')))
        
    subs = os.listdir(op.join(args.bids_dir, 'derivatives', args.deriv))

    tr_df = pd.DataFrame()
    
    for tmp_sub in subs:
        
        rs_files = sorted(glob(op.join(args.bids_dir, 'derivatives', args.deriv, tmp_sub, '*-clean.nii.gz')))

        for tmp_rs_file in rs_files:
                
                img = nib.load(tmp_rs_file)
                tr_df = tr_df.append({"sub": tmp_sub, "num_tr": img.shape[3]}, ignore_index=True)
                
    tr_dist = tr_df['num_tr'].values.tolist()
    sns.distplot(tr_dist, bins=10, kde=False)
    plt.show()
    
if __name__ == '__main__':
    main()
