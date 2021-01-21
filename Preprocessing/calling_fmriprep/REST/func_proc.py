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
    parser.add_argument('--n_procs', required=False, dest='n_procs',
                        help='Number of processes with which to run the job.',
                        default=1, type=int)
    return parser


def main(argv=None):
    args = get_parser().parse_args(argv)
    
    if not op.isdir(op.join(args.work_dir, 'dset')):
        os.makedirs(op.join(args.work_dir, 'dset'))
    else:
        shutil.rmtree(args.work_dir)
        
    if not op.isdir(op.join(args.work_dir, 'dset', args.sub)):
        shutil.copytree(op.join(args.bids_dir, args.sub), op.join(args.work_dir, 'dset', args.sub))
    
    dwidenoise_file = 'dwidenoise_latest-2019-05-21-59c5d3873bda.img'
    if not op.isfile(op.join(args.work_dir, dwidenoise_file)):
        shutil.copyfile(op.join('/home/data/cis/singularity-images', dwidenoise_file), op.join(args.work_dir, dwidenoise_file))
    
    if args.ses is not None:
        work_dir = op.join(args.work_dir, 'dset', args.sub, args.ses)
    else:
        work_dir = op.join(args.work_dir, 'dset', args.sub)
        
    if op.isdir(op.join(work_dir, 'dwi')):
        shutil.rmtree(op.join(work_dir, 'dwi'))
    
    func_files = glob(op.join(work_dir, 'func/*.nii.gz'))
    for tmp_func_file in func_files:
        cmd='singularity run {sing} -nthreads {n_proc} -force {tmp_func_file} {tmp_func_file}'.format(sing=op.join(args.work_dir, dwidenoise_file), n_proc=args.n_procs, tmp_func_file=tmp_func_file)
        run(cmd)
    
    fmriprep_file='poldracklab_fmriprep_1.5.0rc1.sif'
    if not op.isfile(op.join(args.work_dir, fmriprep_file)):
        shutil.copyfile(op.join('/home/data/cis/singularity-images', fmriprep_file), op.join(args.work_dir, fmriprep_file))
     
    fs_license_file='fs_license.txt'
    if not op.isfile(op.join(args.work_dir, fs_license_file)):
        shutil.copyfile(op.join('/home/data/cis/cis-processing', fs_license_file), op.join(args.work_dir, fs_license_file))
        
    if not op.isdir(op.join(args.work_dir, 'fmriprep-1.5.0')):
        os.makedirs(op.join(args.work_dir, 'fmriprep-1.5.0'))
    
    if not op.isdir(op.join(args.work_dir, 'templateflow')):
        shutil.copytree('/home/data/cis/templateflow', op.join(args.work_dir, 'templateflow'))
    
    username = getpass.getuser()
    if not op.isdir(op.join('/home', username, '.cache/templateflow')):
        os.makedirs(op.join('/home', username, '.cache/templateflow'))
        
    cmd='singularity run --cleanenv -B {templateflowdir}:$HOME/.cache/templateflow {sing} {work_dir_bids} {out_dir} participant --verbose -w {work_dir} --omp-nthreads {n_procs}  --fs-license-file {fs_license} --notrack --output-spaces MNI152NLin2009cAsym:res-2'.format(templateflowdir = op.join(args.work_dir, 'templateflow'), sing=op.join(args.work_dir, fmriprep_file), work_dir_bids=op.join(args.work_dir, 'dset'), out_dir=op.join(args.work_dir, 'fmriprep-1.5.0'), work_dir=op.join(args.work_dir, 'fmriprep-work'), n_procs=args.n_procs, fs_license=op.join(args.work_dir, fs_license_file)) #--use-syn-sdc
    run(cmd)
        
    if not op.isdir(op.join(args.bids_dir, 'derivatives', 'dwidenoise-05.21.2019_fmriprep-1.5.0')):
        os.makedirs(op.join(args.bids_dir, 'derivatives', 'dwidenoise-05.21.2019_fmriprep-1.5.0'))
    shutil.copytree(op.join(args.work_dir, 'fmriprep-1.5.0'), op.join(args.bids_dir, 'derivatives', 'dwidenoise-05.21.2019_fmriprep-1.5.0', args.sub))
    
    shutil.rmtree(args.work_dir)    
    
if __name__ == '__main__':
    main()
