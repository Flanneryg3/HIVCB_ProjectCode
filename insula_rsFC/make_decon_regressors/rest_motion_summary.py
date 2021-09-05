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
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

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
                        help=('full path BIDS directory.'))
    parser.add_argument('-f', '--fmriprepdir', required=True, dest='fmriprep_dir',
                        help=('fMRIPREP derivatives folder name.'))
    return parser


def main(argv=None):
    args = get_parser().parse_args(argv)
        
    derivdir = op.join(args.bids_dir, 'derivatives', args.fmriprep_dir)
    subs = glob(op.join(derivdir,'sub-*'))
    
    fd_df = []
    
    for tmp_sub in subs:
        rest_files = glob(op.join(tmp_sub, 'fmriprep', op.basename(tmp_sub), 'func',  '*rest*regressors.tsv'))

        for tmp_rs_file in rest_files:
            tmp_df = pd.read_csv(tmp_rs_file, sep='\t')
            tmp_df = tmp_df['framewise_displacement']
            tmp_df = tmp_df.drop(tmp_df.index[0])
            tmp_df = tmp_df.astype(float)
            tmp_df = tmp_df.values.tolist()
            fd_df.extend(tmp_df)
    
    print(np.amax(fd_df))
    #n, bins, patches = plt.hist(x=fd_df, bins=1000)
    sns.distplot(fd_df, bins=100, kde=False)
    plt.show()
if __name__ == '__main__':
    main()
