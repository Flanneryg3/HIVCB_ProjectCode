#!/usr/bin/env python
# coding: utf-8

# In[7]:


import nilearn
from nilearn import datasets
from os import listdir
import os.path as op
from glob import glob
from nilearn import plotting
from nilearn import image
from nilearn import datasets
from nilearn.input_data import NiftiLabelsMasker
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np
import random
import pandas as pd
import itertools
import importlib
from nilearn.connectome import ConnectivityMeasure
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error, r2_score
from sklearn.linear_model import LinearRegression
from sklearn.pipeline import Pipeline
from sklearn.linear_model import Lasso
from sklearn import linear_model
import csv
from nilearn.input_data import NiftiLabelsMasker
from nilearn.input_data import NiftiMapsMasker


# In[3]:


mask_filename = '/Users/jflanner/Documents/RESTING/G_networks/g_networks.nii'
plotting.plot_roi(mask_filename)

SN_filename = '/Users/jflanner/Documents/RESTING/G_networks/a_salience-2mm.nii'
plotting.plot_roi(SN_filename)

DMN_filename = '/Users/jflanner/Documents/RESTING/G_networks/dDMN-2mm.nii'
plotting.plot_roi(DMN_filename)

RECN_filename = '/Users/jflanner/Documents/RESTING/G_networks/RECN-2mm.nii'
plotting.plot_roi(RECN_filename)

LECN_filename = '/Users/jflanner/Documents/RESTING/G_networks/LECN-2mm.nii'
plotting.plot_roi(LECN_filename)


# In[5]:


network_mask = nilearn.image.concat_imgs([SN_filename, DMN_filename, RECN_filename, LECN_filename])
network_mask.to_filename('./four_networks.nii')


# In[8]:


#lables = {1: 'a_salience', 2: 'dDMN', 3: 'Right ECN', 4: 'Left ECN'}
        
network_masker = NiftiMapsMasker(maps_img=network_mask, standardize=True, verbose=5)

SN_masker = NiftiLabelsMasker(labels_img=SN_filename, background_label=0, detrend=False, standardize=True)

DMN_masker = NiftiLabelsMasker(labels_img=DMN_filename, background_label=0, detrend=False, standardize=True)

RECN_masker = NiftiLabelsMasker(labels_img=RECN_filename, background_label=0, detrend=False, standardize=True)

LECN_masker = NiftiLabelsMasker(labels_img=LECN_filename, background_label=0, detrend=False, standardize=True)

correlation_measure = ConnectivityMeasure(kind='correlation', vectorize=False, discard_diagonal=True)


# In[9]:


network_vectorized_conmats = []

in_folder = '/Users/jflanner/Documents/RESTING/data_rs'
subject_folders = sorted(glob(op.join(in_folder, 'sub-*')))
subject_folders = [sf for sf in subject_folders if op.isdir(sf)]

df = pd.DataFrame({'SN-DMN': np.empty([len(subject_folders),], dtype=float), 
                   'SN-RECN': np.empty([len(subject_folders),], dtype=float), 
                   'SN-LECN': np.empty([len(subject_folders),], dtype=float),
                   'DMN-RECN': np.empty([len(subject_folders),], dtype=float),
                   'DMN-LECN': np.empty([len(subject_folders),], dtype=float)})


for subject_folder in subject_folders:
    img = image.load_img(glob(op.join(subject_folder, 'sub-*_task-rest_run-01_space-MNI152NLin2009cAsym_desc-preproc_bold-clean.nii*')))
    
    #average timeseries extracted from each network
    network_time_series = network_masker.fit_transform(img)
    
    #calculate connectivity matrix from each subject
    network_conmat = correlation_measure.fit_transform([network_time_series])[0]
    
    #grab connectivity values from locations in matrix
    df.at[subject_folder, 'SN-DMN'] = network_conmat[0, 1]
    df.at[subject_folder, 'SN-RECN'] = network_conmat[0, 2]
    df.at[subject_folder, 'SN-LECN'] = network_conmat[0, 3]
    df.at[subject_folder, 'DMN-RECN'] = network_conmat[1, 2]
    df.at[subject_folder, 'DMN-LECN'] = network_conmat[1, 3]
    
    #Add to the list of vectorized connectivity matrices
    print (subject_folder)
    print(network_conmat)
    network_vectorized_conmats.append(network_conmat)


# In[10]:


df.to_csv("./network_connectivity.csv", sep=',', index=True)


# In[ ]:





# In[ ]:




