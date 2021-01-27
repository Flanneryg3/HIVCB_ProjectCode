from __future__ import print_function
from glob import glob
from os import remove
from os.path import basename, join, isfile

import numpy as np
import pandas as pd
import convert_eprime as ce
from bids.layout import BIDSLayout


def p2f(x):
    """Convert percent string to float.
    """
    return float(x.strip('%')) / 100.


def convert_eat(in_file, sid, temp_dir, dset_dir):
    """Convert E-Prime text files to BIDS-format tsv files for error awareness
    task (EAT).
    """
    ce.text_to_csv(in_file, join(temp_dir, 'raw_{0}.csv'.format(sid)))
    df = pd.read_csv(join(temp_dir, 'raw_{0}.csv'.format(sid)))
    keep_cols = ['run', 'onset', 'duration', 'response_time',
                 'trial_type', 'trial_type_2', 'trial_type_3',
                 'stimulus_word', 'stimulus_color',
                 'trial_accuracy']

    # Fill columns with one value per run
    df['run'] = df['run'].fillna(method='ffill').astype(int)
    df['Wait4Scanner.RTTime'] = df['Wait4Scanner.RTTime'].fillna(method='ffill')
    df = df.dropna(subset=['word'])

    # Perform operations on columns
    df['onset'] = (df['stimulus.OnsetTime'] - df['Wait4Scanner.RTTime']) / 1000.
    df['duration'] = df['gotime'] / 1000.
    df['response_time'] = df['stimulus.RT'] / 1000.
    df['trial_type'] = df['trialtype'].map({'repeat': 'repeat',
                                            'word': 'congruent',
                                            'color': 'incongruent',
                                            'wod': 'congruent'})
    df['trial_type_2'] = df['trial_type']
    df['stimulus_word'] = df['word']
    df['stimulus_color'] = df['color']

    # stimulus accuracy is not correctly coded.
    # 2s on aware trials and stops on lure trials are coded as incorrect
    # to figure out accuracy, use lure_performance for the lures and
    # error_aware for the lure errors

    # stopaware mislabels no-responses as correct
    bad_stopaware_idx = (df['stopaware'] == 1) & (df['stimulus.RESP'].isnull())
    df.loc[bad_stopaware_idx, 'stopaware'] = -1
    # if lureperf is empty grabs value in stopaware
    df['temp_acc'] = df['lureperf'].combine(df['stopaware'],
                                            lambda x1, x2: x1 if not np.isnan(x1) else x2)
    df['trial_accuracy'] = df['temp_acc'].combine(df['stimulus.ACC'],
                                                  lambda x1, x2: x1 if not np.isnan(x1) else x2)
    df['trial_accuracy'] = df['trial_accuracy'].astype(int)

    df['temp_trial_type'] = 'go'
    df.loc[df['lure'] == 1, 'temp_trial_type'] = 'nogo'
    df.loc[df['awaretrial'] == 1, 'temp_trial_type'] = 'aware'

    df = df.reset_index(drop=True)

    # goCorrect
    idx1 = df.index.get_indexer_for(df[df['temp_trial_type'] == 'go'].index)
    idx2 = df.index.get_indexer_for(df[df['trial_accuracy'] == 1].index)
    cond_idx = np.intersect1d(idx1, idx2)
    df.loc[cond_idx, 'trial_type_2'] = 'goCorrect'

    # Also goCorrect
    idx1 = df.index.get_indexer_for(df[df['temp_trial_type'] == 'aware'].index)
    idx2 = df.index.get_indexer_for(df[df['trial_accuracy'] == 1].index)
    idx3 = df.index.get_indexer_for(df[df['temp_trial_type'] == 'nogo'].index) + 1
    idx4 = df.index.get_indexer_for(df[df['trial_accuracy'] == 1].index) + 1
    cond_idx = np.intersect1d(np.intersect1d(np.intersect1d(idx1, idx2), idx3), idx4)
    df.loc[cond_idx, 'trial_type_2'] = 'goCorrect'

    # goIncorrect
    idx1 = df.index.get_indexer_for(df[df['temp_trial_type'] == 'go'].index)
    idx2 = df.index.get_indexer_for(df[df['trial_accuracy'] == 0].index)
    cond_idx = np.intersect1d(idx1, idx2)
    df.loc[cond_idx, 'trial_type_2'] = 'goIncorrect'

    # Also goIncorrect
    idx1 = df.index.get_indexer_for(df[df['temp_trial_type'] == 'aware'].index)
    idx2 = df.index.get_indexer_for(df[df['trial_accuracy'] == 0].index)
    idx3 = df.index.get_indexer_for(df[df['temp_trial_type'] == 'nogo'].index) + 1
    idx4 = df.index.get_indexer_for(df[df['trial_accuracy'] == 1].index) + 1
    cond_idx = np.intersect1d(np.intersect1d(np.intersect1d(idx1, idx2), idx3), idx4)
    df.loc[cond_idx, 'trial_type_2'] = 'goIncorrect'

    # goAware
    idx1 = df.index.get_indexer_for(df[df['temp_trial_type'] == 'aware'].index)
    idx2 = df.index.get_indexer_for(df[df['trial_accuracy'] == 1].index)
    idx3 = df.index.get_indexer_for(df[df['temp_trial_type'] == 'nogo'].index) + 1
    idx4 = df.index.get_indexer_for(df[df['trial_accuracy'] == 0].index) + 1
    cond_idx = np.intersect1d(np.intersect1d(np.intersect1d(idx1, idx2), idx3), idx4)
    df.loc[cond_idx, 'trial_type_2'] = 'goAware'

    # goUnaware
    idx1 = df.index.get_indexer_for(df[df['temp_trial_type'] == 'aware'].index)
    idx2 = df.index.get_indexer_for(df[df['trial_accuracy'] == 0].index)
    idx3 = df.index.get_indexer_for(df[df['temp_trial_type'] == 'nogo'].index) + 1
    idx4 = df.index.get_indexer_for(df[df['trial_accuracy'] == 0].index) + 1
    cond_idx = np.intersect1d(np.intersect1d(np.intersect1d(idx1, idx2), idx3), idx4)
    df.loc[cond_idx, 'trial_type_2'] = 'goUnaware'

    # nogoCorrect
    idx1 = df.index.get_indexer_for(df[df['temp_trial_type'] == 'nogo'].index)
    idx2 = df.index.get_indexer_for(df[df['trial_accuracy'] == 1].index)
    cond_idx = np.intersect1d(idx1, idx2)
    df.loc[cond_idx, 'trial_type_2'] = 'nogoCorrect'

    # nogoIncorrectUnaware
    idx1 = df.index.get_indexer_for(df[df['temp_trial_type'] == 'aware'].index) - 1
    idx2 = df.index.get_indexer_for(df[df['trial_accuracy'] == 0].index) - 1
    idx3 = df.index.get_indexer_for(df[df['temp_trial_type'] == 'nogo'].index)
    idx4 = df.index.get_indexer_for(df[df['trial_accuracy'] == 0].index)
    cond_idx = np.intersect1d(np.intersect1d(np.intersect1d(idx1, idx2), idx3), idx4)
    df.loc[cond_idx, 'trial_type_2'] = 'nogoIncorrectUnaware'

    # nogoIncorrectAware
    idx1 = df.index.get_indexer_for(df[df['temp_trial_type'] == 'aware'].index) - 1
    idx2 = df.index.get_indexer_for(df[df['trial_accuracy'] == 1].index) - 1
    idx3 = df.index.get_indexer_for(df[df['temp_trial_type'] == 'nogo'].index)
    idx4 = df.index.get_indexer_for(df[df['trial_accuracy'] == 0].index)
    cond_idx = np.intersect1d(np.intersect1d(np.intersect1d(idx1, idx2), idx3), idx4)
    df.loc[cond_idx, 'trial_type_2'] = 'nogoIncorrectAware'

    #prenogoCorrect
    idx1 = df.index.get_indexer_for(df[df['temp_trial_type'] == 'nogo'].index) - 1
    idx2 = df.index.get_indexer_for(df[df['trial_accuracy'] == 1].index) - 1
    cond_idx = np.intersect1d(idx1, idx2)
    df.loc[cond_idx, 'trial_type_3'] = 'pre-nogoCorrect'

    #postnogoCorrect
    idx1 = df.index.get_indexer_for(df[df['temp_trial_type'] == 'nogo'].index) + 2
    idx2 = df.index.get_indexer_for(df[df['trial_accuracy'] == 1].index) + 2
    cond_idx = np.intersect1d(idx1, idx2)
    df.loc[cond_idx, 'trial_type_3'] = 'post-nogoCorrect'

    #prenogoIncorrectAware
    idx1 = df.index.get_indexer_for(df[df['temp_trial_type'] == 'aware'].index) - 2
    idx2 = df.index.get_indexer_for(df[df['trial_accuracy'] == 1].index) - 2
    idx3 = df.index.get_indexer_for(df[df['temp_trial_type'] == 'nogo'].index) - 1
    idx4 = df.index.get_indexer_for(df[df['trial_accuracy'] == 0].index) - 1
    cond_idx = np.intersect1d(np.intersect1d(np.intersect1d(idx1, idx2), idx3), idx4)
    df.loc[cond_idx, 'trial_type_3'] = 'preIncorrectAware'

    #onepostnogoIncorrectAware
    idx1 = df.index.get_indexer_for(df[df['temp_trial_type'] == 'aware'].index)
    idx2 = df.index.get_indexer_for(df[df['trial_accuracy'] == 1].index)
    idx3 = df.index.get_indexer_for(df[df['temp_trial_type'] == 'nogo'].index) + 1
    idx4 = df.index.get_indexer_for(df[df['trial_accuracy'] == 0].index) + 1
    cond_idx = np.intersect1d(np.intersect1d(np.intersect1d(idx1, idx2), idx3), idx4)
    df.loc[cond_idx, 'trial_type_3'] = 'onepostIncorrectAware'

    #postnogoIncorrectAware
    idx1 = df.index.get_indexer_for(df[df['temp_trial_type'] == 'aware'].index) + 1
    idx2 = df.index.get_indexer_for(df[df['trial_accuracy'] == 1].index) + 1
    idx3 = df.index.get_indexer_for(df[df['temp_trial_type'] == 'nogo'].index) + 2
    idx4 = df.index.get_indexer_for(df[df['trial_accuracy'] == 0].index) + 2
    cond_idx = np.intersect1d(np.intersect1d(np.intersect1d(idx1, idx2), idx3), idx4)
    df.loc[cond_idx, 'trial_type_3'] = 'postIncorrectAware'

    #prenogoIncorrectUnaware
    idx1 = df.index.get_indexer_for(df[df['temp_trial_type'] == 'aware'].index) - 2
    idx2 = df.index.get_indexer_for(df[df['trial_accuracy'] == 0].index) - 2
    idx3 = df.index.get_indexer_for(df[df['temp_trial_type'] == 'nogo'].index) - 1
    idx4 = df.index.get_indexer_for(df[df['trial_accuracy'] == 0].index) - 1
    cond_idx = np.intersect1d(np.intersect1d(np.intersect1d(idx1, idx2), idx3), idx4)
    df.loc[cond_idx, 'trial_type_3'] = 'preIncorrectUnaware'

    #postnogoIncorrectUnaware
    idx1 = df.index.get_indexer_for(df[df['temp_trial_type'] == 'aware'].index) + 1
    idx2 = df.index.get_indexer_for(df[df['trial_accuracy'] == 0].index) + 1
    idx3 = df.index.get_indexer_for(df[df['temp_trial_type'] == 'nogo'].index) + 2
    idx4 = df.index.get_indexer_for(df[df['trial_accuracy'] == 0].index) + 2
    cond_idx = np.intersect1d(np.intersect1d(np.intersect1d(idx1, idx2), idx3), idx4)
    df.loc[cond_idx, 'trial_type_3'] = 'postIncorrectUnaware'

    #onepostnogoIncorrectUnaware
    idx1 = df.index.get_indexer_for(df[df['temp_trial_type'] == 'aware'].index)
    idx2 = df.index.get_indexer_for(df[df['trial_accuracy'] == 0].index)
    idx3 = df.index.get_indexer_for(df[df['temp_trial_type'] == 'nogo'].index) + 1
    idx4 = df.index.get_indexer_for(df[df['trial_accuracy'] == 0].index) + 1
    cond_idx = np.intersect1d(np.intersect1d(np.intersect1d(idx1, idx2), idx3), idx4)
    df.loc[cond_idx, 'trial_type_3'] = 'onepostIncorrectUnaware'

    # repeatIncorrectAware
    idx1 = df.index.get_indexer_for(df[df['temp_trial_type'] == 'aware'].index) - 1
    idx2 = df.index.get_indexer_for(df[df['trial_accuracy'] == 1].index) - 1
    idx3 = df.index.get_indexer_for(df[df['temp_trial_type'] == 'nogo'].index)
    idx4 = df.index.get_indexer_for(df[df['trial_accuracy'] == 0].index)
    idx5 = df.index.get_indexer_for(df[df['trial_type'] == 'repeat'].index)
    cond_idx = np.intersect1d(np.intersect1d(np.intersect1d(np.intersect1d(idx1, idx2), idx3), idx4), idx5)
    df.loc[cond_idx, 'trial_type_3'] = 'repeatIncorrectAware'

    # stroopIncorrectAware
    idx1 = df.index.get_indexer_for(df[df['temp_trial_type'] == 'aware'].index) - 1
    idx2 = df.index.get_indexer_for(df[df['trial_accuracy'] == 1].index) - 1
    idx3 = df.index.get_indexer_for(df[df['temp_trial_type'] == 'nogo'].index)
    idx4 = df.index.get_indexer_for(df[df['trial_accuracy'] == 0].index)
    idx5 = df.index.get_indexer_for(df[df['trial_type'] == 'incongruent'].index)
    cond_idx = np.intersect1d(np.intersect1d(np.intersect1d(np.intersect1d(idx1, idx2), idx3), idx4), idx5)
    df.loc[cond_idx, 'trial_type_3'] = 'stroopIncorrectAware'

    # repeatIncorrectUnaware
    idx1 = df.index.get_indexer_for(df[df['temp_trial_type'] == 'aware'].index) - 1
    idx2 = df.index.get_indexer_for(df[df['trial_accuracy'] == 0].index) - 1
    idx3 = df.index.get_indexer_for(df[df['temp_trial_type'] == 'nogo'].index)
    idx4 = df.index.get_indexer_for(df[df['trial_accuracy'] == 0].index)
    idx5 = df.index.get_indexer_for(df[df['trial_type'] == 'repeat'].index)
    cond_idx = np.intersect1d(np.intersect1d(np.intersect1d(np.intersect1d(idx1, idx2), idx3), idx4), idx5)
    df.loc[cond_idx, 'trial_type_3'] = 'repeatIncorrectUnaware'

    # stroopIncorrectUnaware
    idx1 = df.index.get_indexer_for(df[df['temp_trial_type'] == 'aware'].index) - 1
    idx2 = df.index.get_indexer_for(df[df['trial_accuracy'] == 0].index) - 1
    idx3 = df.index.get_indexer_for(df[df['temp_trial_type'] == 'nogo'].index)
    idx4 = df.index.get_indexer_for(df[df['trial_accuracy'] == 0].index)
    idx5 = df.index.get_indexer_for(df[df['trial_type'] == 'incongruent'].index)
    cond_idx = np.intersect1d(np.intersect1d(np.intersect1d(np.intersect1d(idx1, idx2), idx3), idx4), idx5)
    df.loc[cond_idx, 'trial_type_3'] = 'stroopIncorrectUnaware'


    # no-responses following incorrect nogos
    idx1 = df.index.get_indexer_for(df[df['stopaware'] == -1].index) - 1
    df.loc[idx1, 'trial_type_2'] = 'nogoIncorrectNoResponse'

    idx1 = df.index.get_indexer_for(df[df['stopaware'] == -1].index)
    df.loc[idx1, 'trial_type_2'] = 'goUnawareNoResponse'
    # now label the accuracy for those no-reponses as 0
    df.loc[idx1, 'trial_accuracy'] = 0

    for run in sorted(df['run'].unique()):
        run_df = df.loc[df['run'] == run]
        run_df = run_df[keep_cols]

        fname = join(dset_dir, 'sub-{0}/func/sub-{0}_task-errorawareness_run-{1:02d}_events.tsv'.format(sid, run))
        run_df = run_df.drop(labels=['run'], axis=1)
        run_df.to_csv(fname, sep='\t', index=False)


def main():
    """Convert behavioral files for all of the subjects.
    """
    temp_dir = '/home/data/nbc/Sutherland_HIVCB/raw/converted-csv/'
    dset_dir = '/home/data/nbc/Sutherland_HIVCB/dset/'

    in_dir = '/home/data/nbc/DICOM/MSUT_HIV_CB/Behavioral/'
    layout = BIDSLayout(dset_dir)
    subjects = layout.get_subjects()
    for sid in subjects:
        events_files = glob(join(dset_dir, 'sub-{0}/func/sub-{0}_task-*_events.tsv'.format(sid)))
        for events_file in events_files:
            remove(events_file)

        file_ = join(in_dir, 'P{0}/EAT_SCAN/EAT_scanner_all-{0}-2.txt'.format(sid))
        if not isfile(file_):
            file_ = join(in_dir, 'P{0}/EAT_SCAN/EAT_scanner_all-{0}-1.txt'.format(sid))

        if isfile(file_):
            try:
                convert_eat(file_, sid, temp_dir, dset_dir)
            except:
                print('{} failed.'.format(sid))
        else:
            print('No file found for {0}'.format(sid))


if __name__ == "__main__":
    main()
