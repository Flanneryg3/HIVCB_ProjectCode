# coding: utf-8
from glob import glob
import os.path as op
import pandas as pd
import numpy as np
from bids.layout import BIDSLayout

out_dir = '/home/data/nbc/Sutherland_HIVCB/EAT-behavioral/'
dset_dir = '/home/data/nbc/Sutherland_HIVCB/dset/'
layout = BIDSLayout(dset_dir)
subjects = layout.get_subjects()
#subjects = subjects[:5]
#subjects.remove('283')
#subjects.remove('397')
#subjects.remove('406')

out_df = pd.DataFrame(
    columns=['n_correct_incongruent', 'n_incorrect_incongruent', 'n_incongruent',
             'n_correct_repeat', 'n_incorrect_repeat', 'n_repeat',
             'n_correct_nogo', 'n_incorrect_nogo', 'n_nogo',
             'n_correct_go', 'n_incorrect_go', 'n_go', 'n_nogo_aware', 
             'n_nogo_unaware', 'mean_nogo_aware_rt', 'mean_nogo_unaware_rt', 
             'mean_incorrect_incongruent_rt', 'std_incorrect_incongruent_rt',
             'mean_incongruent_rt', 'std_incongruent_rt',
             'mean_incorrect_repeat_rt', 'std_incorrect_repeat_rt',
             'mean_repeat_rt', 'std_repeat_rt',
             'mean_incorrect_nogo_rt', 'std_incorrect_nogo_rt',
             'mean_nogo_rt', 'std_nogo_rt',
             'mean_correct_go_rt', 'std_correct_go_rt',
             'mean_incorrect_go_rt', 'std_incorrect_go_rt',
             'mean_go_rt', 'std_go_rt'],
    index=subjects)

for subject in subjects:
    files = sorted(glob(op.join(dset_dir, 'sub-'+subject+'/func/sub-*_task-errorawareness*events.tsv')))
    if not files:
        print('{0} failed'.format(subject))
        continue
    else:
        print('{0} running'.format(subject))

    dfs = [pd.read_csv(f, sep='\t') for f in files]
    df = pd.concat(dfs)
    df['go'] = df['trial_type_2'].str.startswith('go').astype(int)
    #df['nogo_error'] = df['trial_type_2'].str.startswith('nogoIncorrect').astype(int)

    acc_df1 = df.groupby(['trial_type', 'trial_accuracy']).count()
    acc_df2 = df.groupby(['trial_type']).count()
    acc_df3 = df.groupby(['go', 'trial_accuracy']).count()
    acc_df4 = df.groupby(['go']).count()
    acc_df5 = df.groupby(['trial_type_2']).count() 

    rt_df1 = df.groupby(['trial_type', 'trial_accuracy']).mean()
    rt_df2 = df.groupby(['trial_type']).mean()
    rt_df3 = df.groupby(['go', 'trial_accuracy']).mean()
    rt_df4 = df.groupby(['go']).mean()
    rt_df5 = df.groupby(['trial_type', 'trial_accuracy']).std()
    rt_df6 = df.groupby(['trial_type']).std()
    rt_df7 = df.groupby(['go', 'trial_accuracy']).std()
    rt_df8 = df.groupby(['go']).std()
    rt_df9 = df.groupby(['trial_type_2']).mean()

    try:
        out_df.loc[subject, 'n_correct_incongruent'] = acc_df1.loc[('incongruent', 1), 'onset']
    except:
        out_df.loc[subject, 'n_correct_incongruent'] = 0

    try:
        out_df.loc[subject, 'n_incorrect_incongruent'] = acc_df1.loc[('incongruent', 0), 'onset']
        out_df.loc[subject, 'mean_incorrect_incongruent_rt'] = rt_df1.loc[('incongruent', 0), 'response_time']
        out_df.loc[subject, 'std_incorrect_incongruent_rt'] = rt_df5.loc[('incongruent', 0), 'response_time']
    except:
        out_df.loc[subject, 'n_correct_incongruent'] = 0
        out_df.loc[subject, 'mean_incorrect_incongruent_rt'] = np.NaN
        out_df.loc[subject, 'std_incorrect_incongruent_rt'] = np.NaN

    try:
        out_df.loc[subject, 'n_correct_repeat'] = acc_df1.loc[('repeat', 1), 'onset']
    except:
        out_df.loc[subject, 'n_correct_repeat'] = 0

    try:
        out_df.loc[subject, 'n_incorrect_repeat'] = acc_df1.loc[('repeat', 0), 'onset']
        out_df.loc[subject, 'mean_incorrect_repeat_rt'] = rt_df1.loc[('repeat', 0), 'response_time']
        out_df.loc[subject, 'std_incorrect_repeat_rt'] = rt_df5.loc[('repeat', 0), 'response_time']
    except:
        out_df.loc[subject, 'n_incorrect_repeat'] = 0
        out_df.loc[subject, 'mean_incorrect_repeat_rt'] = np.NaN
        out_df.loc[subject, 'std_incorrect_repeat_rt'] = np.NaN

    try:
        out_df.loc[subject, 'n_correct_nogo'] = acc_df5.loc['nogoCorrect', 'onset']
    except:
        out_df.loc[subject, 'n_correct_nogo'] = 0

    try:
        out_df.loc[subject, 'n_incorrect_nogo'] = acc_df5.loc['nogoIncorrect', 'onset']
        out_df.loc[subject, 'mean_incorrect_nogo_rt'] = rt_df3.loc[(0, 0), 'response_time']
        out_df.loc[subject, 'std_incorrect_nogo_rt'] = rt_df7.loc[(0, 0), 'response_time']
    except:
        out_df.loc[subject, 'n_incorrect_nogo'] = 0
        out_df.loc[subject, 'mean_incorrect_nogo_rt'] = np.NaN
        out_df.loc[subject, 'std_incorrect_nogo_rt'] = np.NaN

    try:
        out_df.loc[subject, 'n_correct_go'] = acc_df3.loc[(1, 1), 'onset']
        out_df.loc[subject, 'mean_correct_go_rt'] = rt_df3.loc[(1, 1), 'response_time']
        out_df.loc[subject, 'std_correct_go_rt'] = rt_df7.loc[(1, 1), 'response_time']
    except:
        out_df.loc[subject, 'n_correct_go'] = 0
        out_df.loc[subject, 'mean_correct_go_rt'] = np.NaN
        out_df.loc[subject, 'std_correct_go_rt'] = np.NaN

    try:
        out_df.loc[subject, 'n_incorrect_go'] = acc_df5.loc['goIncorrect', 'onset']
        out_df.loc[subject, 'mean_incorrect_go_rt'] = rt_df3.loc[(1, 0), 'response_time']
        out_df.loc[subject, 'std_incorrect_go_rt'] = rt_df7.loc[(1, 0), 'response_time']
    except:
        out_df.loc[subject, 'n_incorrect_go'] = 0
        out_df.loc[subject, 'mean_incorrect_go_rt'] = np.NaN
        out_df.loc[subject, 'std_incorrect_go_rt'] = np.NaN
        
    try:
        out_df.loc[subject, 'n_nogo_aware'] = acc_df5.loc['nogoIncorrectAware', 'onset']
        out_df.loc[subject, 'mean_nogo_aware_rt'] = rt_df9.loc['nogoIncorrectAware', 'response_time']
    except:
        out_df.loc[subject, 'n_nogo_aware'] = 0
        out_df.loc[subject, 'mean_nogo_aware_rt'] = np.NaN
        
    try:
        out_df.loc[subject, 'n_nogo_unaware'] = acc_df5.loc['nogoIncorrectUnaware', 'onset']
        out_df.loc[subject, 'mean_nogo_unaware_rt'] = rt_df9.loc['nogoIncorrectUnaware', 'response_time']
    except:
        out_df.loc[subject, 'n_nogo_unaware'] = 0
        out_df.loc[subject, 'mean_nogo_unaware_rt'] = np.NaN    

    out_df.loc[subject, 'n_incongruent'] = acc_df2.loc['incongruent', 'onset']
    out_df.loc[subject, 'mean_incongruent_rt'] = rt_df2.loc['incongruent', 'response_time']
    out_df.loc[subject, 'std_incongruent_rt'] = rt_df6.loc['incongruent', 'response_time']

    out_df.loc[subject, 'n_repeat'] = acc_df2.loc['repeat', 'onset']
    out_df.loc[subject, 'mean_repeat_rt'] = rt_df2.loc['repeat', 'response_time']
    out_df.loc[subject, 'std_repeat_rt'] = rt_df6.loc['repeat', 'response_time']

    out_df.loc[subject, 'n_nogo'] = acc_df4.loc[0, 'onset']
    out_df.loc[subject, 'mean_nogo_rt'] = rt_df4.loc[0, 'response_time']
    out_df.loc[subject, 'std_nogo_rt'] = rt_df8.loc[0, 'response_time']

    out_df.loc[subject, 'n_go'] = acc_df4.loc[1, 'onset']
    out_df.loc[subject, 'mean_go_rt'] = rt_df4.loc[1, 'response_time']
    out_df.loc[subject, 'std_go_rt'] = rt_df8.loc[1, 'response_time']

out_df.to_csv(op.join(out_dir, 'eat_performance.csv'), index_label='subject_id')