% epoching_04.m
% Fixed-length Epoching - S003 R01 & R02
% Dataset: EEG Motor Movement/Imagery - PhysioNet

clear; clc; close all;

%% Setup
eeglab_path = fileparts(which('eeglab.m'));
addpath(eeglab_path);
eeglab nogui;

data_path = 'C:\Users\Pentium\Desktop\EEG_Project\data\processed\';

%% R01 - Eyes Open
EEG_R01 = pop_loadset('filename', 'S003_R01_clean.set', 'filepath', data_path);
EEG_R01 = eeg_regepochs(EEG_R01, 'recurrence', 2, 'limits', [0 2]);
fprintf('R01 Epochs: %d\n', EEG_R01.trials);
pop_saveset(EEG_R01, 'filename', 'S003_R01_epoched.set', 'filepath', data_path);

%% R02 - Eyes Closed
EEG_R02 = pop_loadset('filename', 'S003_R02_clean.set', 'filepath', data_path);
EEG_R02 = eeg_regepochs(EEG_R02, 'recurrence', 2, 'limits', [0 2]);
fprintf('R02 Epochs: %d\n', EEG_R02.trials);
pop_saveset(EEG_R02, 'filename', 'S003_R02_epoched.set', 'filepath', data_path);

disp('=== Epoching Complete ===');