"""
BIDS version: 1.0.1

TODO: Incorporate ASL and CBF scans.
"""
import os


def create_key(template, outtype=('nii.gz',), annotation_classes=None):
    if template is None or not template:
        raise ValueError('Template must be a valid format string')
    return template, outtype, annotation_classes


def infotodict(seqinfo):
    """Heuristic evaluator for determining which runs belong where

    allowed template fields - follow python string module:

    item: index within category
    subject: participant id
    seqitem: run number during scanning
    subindex: sub index within group
    """

    outtype = ('nii.gz')

    # functionals
    rs = create_key('sub-{subject}/func/sub-{subject}_task-rest_run-{item:02d}_bold',
                    outtype=outtype)
    eat = create_key('sub-{subject}/func/sub-{subject}_task-errorawareness_run-{item:02d}_bold',
                     outtype=outtype)

    # dwi-short
    dwis = create_key('sub-{subject}/dwi/sub-{subject}_acq-short_dwi',
                      outtype=outtype)

    # dwi-short
    dwil = create_key('sub-{subject}/dwi/sub-{subject}_acq-long_dwi',
                      outtype=outtype)

    # structurals
    t1 = create_key('sub-{subject}/anat/sub-{subject}_run-{item:02d}_T1w',
                    outtype=outtype)

    info = {rs: [], eat: [], dwis: [], dwil: [], t1: []}
    for i, s in enumerate(seqinfo):
        _, _, sl, nt = (s[6], s[7], s[8], s[9])

        # T1 structural scan(s)
        if (sl == 186) and ('3D_T1_Sag-Structural' in s[12]) and ('PU' not in s[12]):
            info[t1].append(s[2])
        # Resting state BOLD scan
        elif (sl in [10080, 10290]) and ('Resting_State' in s[12]):
            info[rs] = [s[2]]
        # Error awareness task BOLD scans
        elif (sl == 7098) and ('EAT' in s[12]):
            info[eat].append(s[2])
        # DTI scans
        elif (sl == 142) and ('DTI_30_Directions' in s[12]):
            info[dwis] = [s[2]]
        elif (sl == 2201) and ('DTI_30_Directions' in s[12]):
            info[dwil] = [s[2]]
        else:
            pass

    return info
