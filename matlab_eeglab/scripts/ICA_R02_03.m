% ICA_R02_03.m
% ICA - Independent Component Analysis - S003 R02 (Eyes Closed Baseline)
% Dataset: EEG Motor Movement/Imagery - PhysioNet

clear; clc; close all;

%% Setup
eeglab_path = fileparts(which('eeglab.m'));
addpath(eeglab_path);
eeglab nogui;

%% Load preprocessed data
EEG = pop_loadset('filename', 'S003_R02_preprocessed.set', ...
    'filepath', 'C:\Users\Pentium\Desktop\EEG_Project\data\processed\');

fprintf('Running ICA on %d channels...\n', EEG.nbchan);

%% Run ICA
EEG = pop_runica(EEG, 'icatype', 'runica', 'extended', 1);

%% ICLabel
EEG = iclabel(EEG, 'default');

fprintf('ICA complete. Components: %d\n', size(EEG.icawinv, 2));

%% Save
pop_saveset(EEG, 'filename', 'S003_R02_ica.set', ...
    'filepath', 'C:\Users\Pentium\Desktop\EEG_Project\data\processed\');

disp('=== R02 ICA Complete ===');