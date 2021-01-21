#!/usr/bin/env python3
"""
Based on
https://github.com/BIDS-Apps/example/blob/aa0d4808974d79c9fbe54d56d3b47bb2cf4e0a0d/run.py
"""

import os
import os.path as op
import argparse
import pandas as pd
import numpy as np
import json as js


def get_parser():
    parser = argparse.ArgumentParser(description='Create a confound regressor file from the FMRIPREP regressor file.')
    parser.add_argument('-i', '--input', required=True, dest='input',
                        help='Path to input file.')
    parser.add_argument('-o', '--output', required=True, dest='output',
                        help='Path to output file.')

    return parser


def main(argv=None):
    args = get_parser().parse_args(argv)

    df_in = pd.read_csv(args.input, sep='\t')
    
    #cols = ['global_signal', 'csf', 'white_matter', 'trans_x', 'trans_y', 'trans_z', 'rot_x',  'rot_y', 'rot_z']
    #cols = ['csf', 'white_matter', 'trans_x', 'trans_x_derivative1', 'trans_y', 'trans_y_derivative1', 'trans_z', 'trans_z_derivative1', 'rot_x', 'rot_x_derivative1',  'rot_y', 'rot_y_derivative1', 'rot_z', 'rot_z_derivative1']
    #cols = ['csf', 'white_matter', 'trans_x', 'trans_x_power2', 'trans_x_derivative1', 'trans_x_derivative1_power2', 'trans_y', 'trans_y_power2', 'trans_y_derivative1', 'trans_y_derivative1_power2', 'trans_z', 'trans_z_power2', 'trans_z_derivative1', 'trans_z_derivative1_power2', 'rot_x', 'rot_x_power2', 'rot_x_derivative1',  'rot_x_derivative1_power2', 'rot_y', 'rot_y_power2', 'rot_y_derivative1', 'rot_y_derivative1_power2', 'rot_z', 'rot_z_power2', 'rot_z_derivative1', 'rot_z_derivative1_power2']
    
    cols = ['trans_x', 'trans_x_derivative1', 'trans_y', 'trans_y_derivative1', 'trans_z', 'trans_z_derivative1', 'rot_x', 'rot_x_derivative1',  'rot_y', 'rot_y_derivative1', 'rot_z', 'rot_z_derivative1']
    regressfile = args.input
    with open('{0}.json'.format(regressfile.split('.')[0])) as json_file:
        data = js.load(json_file)
        acompcors = sorted([x for x in data.keys() if 'a_comp_cor' in x])
        #for behzadi 2007
        #acompcor_list = [x for x in acompcors if data[x]['Mask'] == 'combined']
        #acompcor_list = acompcor_list[0:6]
        # for muschelli 2014
        acompcor_list_CSF = [x for x in acompcors if data[x]['Mask'] == 'CSF']
        acompcor_list_CSF = acompcor_list_CSF[0:3]
        acompcor_list_WM = [x for x in acompcors if data[x]['Mask'] == 'WM']
        acompcor_list_WM = acompcor_list_WM[0:3]
        acompcor_list = []
        acompcor_list.extend(acompcor_list_CSF)
        acompcor_list.extend(acompcor_list_WM)
        
    cols.extend(acompcor_list)
    
    df_out = df_in[cols]
    df_out = df_out.replace('n/a', 0)
    
    df_out.to_csv(args.output, sep='\t', index=False, header=False)
    
    fd = df_in['framewise_displacement']
    fd = fd[1:,]
    fd_cens = np.ones(len(fd.index)+1)
    fd_list = []
    for i, tmp_fd in enumerate(fd):
        if float(tmp_fd) > 0.35:
            fd_list.append(i+1)
    fd_cens[fd_list] = 0
    
    out_fname = os.path.splitext(args.output)[0]
   
    ss_cols = [x for x in df_in.columns if 'non_steady_state' in x]
    ss_vals = df_in.as_matrix(ss_cols)
    
    ss_cens = np.sum(ss_vals, axis=1)
    ss_cens = (-ss_cens+1)
    
    fd_ss_cens = np.fmin(fd_cens, ss_cens)
    
    with open('{0}_fd+ss.1D'.format(out_fname), 'a') as fo:
        for tmp in fd_ss_cens:
            fo.write('{0}\n'.format(tmp))

if __name__ == '__main__':
    main()
