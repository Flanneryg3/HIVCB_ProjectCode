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
import getpass


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
    parser.add_argument('-w', '--workdir', required=False, dest='work_dir',
                        default=None,
                        help='Path to a working directory. Defaults to work '
                             'subfolder in dset_dir.')
    parser.add_argument('--sub', required=True, dest='sub',
                        help='The label of the subject to analyze.')
    parser.add_argument('--ses', required=False, dest='ses',
                        help='Session number', default=None)
    parser.add_argument('--deriv', required=False, dest='deriv',
                        help='Derivative name', default=None)
    return parser


def main(argv=None):
    args = get_parser().parse_args(argv)
    
    if not op.isdir(args.work_dir):
        os.makedirs(args.work_dir)
    else:
        shutil.rmtree(args.work_dir)
        
    if not op.isdir(op.join(args.work_dir, args.sub)):
        shutil.copytree(op.join(args.bids_dir, 'derivatives/dwidenoise-05.21.2019_fmriprep-1.5.0', args.sub, 'fmriprep', args.sub), op.join(args.work_dir, args.sub))

    if args.ses is not None:
        work_dir = op.join(args.work_dir, args.sub, args.ses)
    else:
        work_dir = op.join(args.work_dir, args.sub)

    if not op.isdir(op.join(args.work_dir, 'clean')):
        os.makedirs(op.join(args.work_dir, 'clean'))
        
    confound_script='make_confound_file.py'
    censoring_script='enhance_censoring.py'
    if not op.isfile(op.join(args.work_dir, confound_script)):
        shutil.copyfile(op.join(op.dirname(args.bids_dir), 'code', confound_script), op.join(args.work_dir, confound_script))
    if not op.isfile(op.join(args.work_dir, censoring_script)):
        shutil.copyfile(op.join('/home/data/nbc/tools/data-analysis', censoring_script), op.join(args.work_dir, censoring_script))
        
    rest_files = sorted(glob(op.join(work_dir, 'func',  '*rest*regressors.tsv')))
    
    for tmp_rs_file in rest_files:
        outfile=op.basename(tmp_rs_file)
        outfile=op.splitext(outfile)[0]
        outfile='{0}.1D'.format(outfile)
        cmd='python3 {confound_script} --input {confound_regressor_file} --output {output_regressor_file}'.format(confound_script=op.join(args.work_dir, confound_script), confound_regressor_file=tmp_rs_file, output_regressor_file=op.join(args.work_dir, 'clean', outfile))
        run(cmd)

        cmd='python3 {censoring_script} {input_regressor_file} {output_regressor_file} --between 0 --pre 1 --post 1'.format(censoring_script=op.join(args.work_dir, censoring_script), input_regressor_file=op.join(args.work_dir, 'clean', '{0}_fd+ss.1D'.format(op.splitext(outfile)[0])), output_regressor_file=op.join(args.work_dir, 'clean', '{0}_fd+ss_ec.1D'.format(op.splitext(outfile)[0])))
        run(cmd)
        
        niifile=op.basename(tmp_rs_file)
        niifile=niifile.rstrip('_desc-confounds_regressors.tsv')
        nii_fn=glob(op.join(work_dir, 'func', '{0}*MNI152NLin2009cAsym*preproc_bold*'.format(niifile)))[0]
        mask_fn=glob(op.join(work_dir, 'func', '{0}*MNI152NLin2009cAsym*brain_mask*'.format(niifile)))[0]
        
        out_fn = op.basename(nii_fn)
        out_fn='{0}-clean.nii'.format(out_fn.split('.')[0])
        cmd='3dTproject -input {input_file} -polort 1 -prefix {output_file} -ort {regressor_file} -censor {censor_file} -passband 0.01 0.10 -mask {mask_file}'.format(input_file=nii_fn, output_file=op.join(args.work_dir, 'clean', out_fn), regressor_file=op.join(args.work_dir, 'clean', outfile), censor_file=op.join(args.work_dir, 'clean', '{0}_fd+ss_ec.1D'.format(op.splitext(outfile)[0])), mask_file=mask_fn)
        run(cmd)
        cmd='fslmaths {out_fn} -add 10000 -mas {mask_fn} {out_fn} -odt float'.format(mask_fn=mask_fn, out_fn=op.join(args.work_dir, 'clean', out_fn))
        run(cmd)
        os.remove(op.join(args.work_dir, 'clean', out_fn))
        
    if rest_files:
        shutil.copytree(op.join(args.work_dir, 'clean'), op.join(args.bids_dir, 'derivatives', '{0}'.format(args.deriv), args.sub))
    
    shutil.rmtree(args.work_dir)    
    
if __name__ == '__main__':
    main()
