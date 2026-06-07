% preprocessing_02.m
% Preprocessing Pipeline - S003 R01 (Eyes Open Baseline)
% Dataset: EEG Motor Movement/Imagery - PhysioNet
% 64 channels | 160 Hz | 60 sec

clear; clc; close all;

%% Setup
eeglab_path = fileparts(which('eeglab.m'));
addpath(eeglab_path);
eeglab nogui;

%% Load داده با channel locations
EEG = pop_loadset('filename', 'S003_R01_chanlocs.set', ...
    'filepath', 'C:\Users\Pentium\Desktop\EEG_Project\data\processed\');

fprintf('Loaded: %d channels, %d Hz, %.1f sec\n', ...
    EEG.nbchan, EEG.srate, EEG.xmax);

%% 1. Re-reference به average
EEG = pop_reref(EEG, []);
fprintf('Step 1 done: Re-reference to average\n');

%% 2. Bandpass filter: 1-40 Hz
EEG = pop_eegfiltnew(EEG, 1, 40);
fprintf('Step 2 done: Bandpass filter 1-40 Hz\n');

%% 3. Notch filter: 60 Hz (dataset آمریکاییه)
EEG = pop_eegfiltnew(EEG, 58, 62, [], 1);
fprintf('Step 3 done: Notch filter 60 Hz\n');

%% 4. Bad channel removal
EEG_before = EEG;
EEG = pop_rejchan(EEG, 'elec', 1:EEG.nbchan, ...
    'threshold', 5, 'norm', 'on', 'measure', 'kurt');
fprintf('Step 4 done: Removed %d bad channels\n', ...
    EEG_before.nbchan - EEG.nbchan);

%% ذخیره
pop_saveset(EEG, 'filename', 'S003_R01_preprocessed.set', ...
    'filepath', 'C:\Users\Pentium\Desktop\EEG_Project\data\processed\');

disp('=== Preprocessing Complete ===');