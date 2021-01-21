"""Manually add in some fields that are necessary, but aren't
automatically added by heudiconv.
"""
from bids.grabbids import BIDSLayout
import dicom
from glob import glob
from os.path import join
import nibabel as nib
import json

dicom_dir = '/home/data/nbc/DICOM/MSUT_HIV_CB/'
dset_dir = '/home/data/nbc/Sutherland_HIVCB/dset/'
layout = BIDSLayout(dset_dir)

keep_keys = ['CogAtlasID', 'ConversionSoftware', 'ConversionSoftwareVersion',
             'EchoTime', 'FlipAngle', 'ImageType', 'InversionTime',
             'MagneticFieldStrength',
             'Manufacturer', 'ManufacturersModelName',
             'ProtocolName', 'RepetitionTime',
             'ScanOptions', 'ScanningSequence',
             'SequenceVariant', 'SeriesNumber',
             'SoftwareVersions',
             'TaskName']
slice_times = [0.0023, 1.0023, 0.0499, 1.0499, 0.0975,
               1.0975, 0.1451, 1.1451, 0.1927, 1.1928,
               0.2404, 1.2404, 0.288, 1.288, 0.3356,
               1.3356, 0.3832, 1.3832, 0.4308, 1.4309,
               0.4785, 1.4785, 0.5261, 1.5261, 0.5737,
               1.5737, 0.6213, 1.6213, 0.6689, 1.6689,
               0.7166, 1.7166, 0.7642, 1.7642, 0.8118,
               1.8118, 0.8594, 1.8594, 0.907, 1.907,
               0.9547, 1.9546]

subjects = layout.get_subjects()
for subj in subjects:
    # Functional scans
    scans = layout.get(subject=subj, extensions='nii.gz', type='bold')
    for scan in scans:
        json_file = layout.get_nearest(scan.filename, extensions='json')
        metadata = layout.get_metadata(scan.filename)
        if 'dcmmeta_shape' in metadata.keys() or not metadata:
            metadata2 = {key: metadata[key] for key in keep_keys if key in metadata.keys()}
            for key in keep_keys:
                if key not in metadata.keys() and key in metadata['global']['const'].keys():
                    metadata2[key] = metadata['global']['const'][key]
            metadata2['SliceTiming'] = slice_times

            if 'EAT' in metadata['ProtocolName']:
                metadata2['TaskName'] = 'error awareness'
            else:
                metadata2['TaskName'] = 'resting state'
                if subj == '193':
                    metadata2['NumberOfVolumesDiscardedByScanner'] = 0
                else:
                    metadata2['NumberOfVolumesDiscardedByScanner'] = 5

            with open(json_file, 'w') as fo:
                json.dump(metadata2, fo, sort_keys=True, indent=4)
        else:
            print('Skipping {0}'.format(scan.filename))

    # Anatomical scans
    scans = layout.get(subject=subj, extensions='nii.gz', type='T1w')
    for scan in scans:
        json_file = layout.get_nearest(scan.filename, extensions='json')
        metadata = layout.get_metadata(scan.filename)
        if 'dcmmeta_shape' in metadata.keys() or not metadata:
            metadata2 = {key: metadata[key] for key in keep_keys if key in metadata.keys()}
            for key in keep_keys:
                if key not in metadata.keys() and key in metadata['global']['const'].keys():
                    metadata2[key] = metadata['global']['const'][key]

            with open(json_file, 'w') as fo:
                json.dump(metadata2, fo, sort_keys=True, indent=4)
        else:
            print('Skipping {0}'.format(scan.filename))

    # DWI scans
    scans = layout.get(subject=subj, extensions='nii.gz', type='dwi')
    for scan in scans:
        json_file = layout.get_nearest(scan.filename, extensions='json')
        metadata = layout.get_metadata(scan.filename)
        if 'dcmmeta_shape' in metadata.keys() or not metadata:
            metadata2 = {key: metadata[key] for key in keep_keys if key in metadata.keys()}
            for key in keep_keys:
                if key not in metadata.keys() and key in metadata['global']['const'].keys():
                    metadata2[key] = metadata['global']['const'][key]

            with open(json_file, 'w') as fo:
                json.dump(metadata2, fo, sort_keys=True, indent=4)
        else:
            print('Skipping {0}'.format(scan.filename))
