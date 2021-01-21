"""
Run mri_deface on input data
"""
from bids.layout import BIDSLayout
from glob import glob
import os
from os.path import join
import nibabel as nib
import json
import subprocess


def run(command, env={}):
    merged_env = os.environ
    merged_env.update(env)
    process = subprocess.Popen(command, stdout=subprocess.PIPE,
                               stderr=subprocess.STDOUT, shell=True,
                               env=merged_env)
    while True:
        line = process.stdout.readline()
        line = str(line)[:-1]
        print(line)
        if line == '' and process.poll() is not None:
            break

    if process.returncode != 0:
        raise Exception("Non zero return code: {0}\n"
                        "{1}\n\n{2}".format(process.returncode, command,
                                            process.stdout.read()))


if __name__ == '__main__':
    dset_dir = '/home/data/nbc/Sutherland_HIVCB/dset/'
    layout = BIDSLayout(dset_dir)
    log_files = glob('*.log')
    log_niis = [lf.replace('.log', '') for lf in log_files]

    cmd = ('/home/data/nbc/tools/deface/mri_deface {0} '
           '/home/data/nbc/tools/deface/talairach_mixed_with_skull.gca '
           '/home/data/nbc/tools/deface/face.gca {0}')

    subjects = layout.get_subjects()
    for subj in subjects:
        # Anatomical scans
        scans = layout.get(subject=subj, extensions='nii.gz', type='T1w')
        for scan in scans:
            f = scan.filename
            if not any([ln in f for ln in log_niis]):
                scan_cmd = cmd.format(f)
                run(scan_cmd)
        
