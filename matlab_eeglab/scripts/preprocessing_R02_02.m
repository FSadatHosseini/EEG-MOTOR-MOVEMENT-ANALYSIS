% preprocessing_R02_02.m
% Preprocessing Pipeline - S003 R02 (Eyes Closed Baseline)
% Dataset: EEG Motor Movement/Imagery - PhysioNet
% 63 channels (1 removed: PZ), 160 Hz, 61 sec

clear; clc; close all;

%% Setup
eeglab_path = fileparts(which('eeglab.m'));
addpath(eeglab_path);
eeglab nogui;

%% Load
EEG = pop_loadset('filename', 'S003_R02_raw.set', ...
    'filepath', 'C:\Users\Pentium\Desktop\EEG_Project\data\processed\');

fprintf('Loaded: %d channels, %d Hz, %.1f sec\n', ...
    EEG.nbchan, EEG.srate, EEG.xmax);

%% Channel locations
for i = 1:length(EEG.chanlocs)
    name = EEG.chanlocs(i).labels;
    name = strtrim(name);
    name = regexprep(name, '\.$', '');
    name = upper(name);
    EEG.chanlocs(i).labels = name;
end
elc_file = fullfile(eeglab_path, 'plugins', 'dipfit', ...
    'standard_BEM', 'elec', 'standard_1005.elc');
EEG = pop_chanedit(EEG, 'lookup', elc_file);
EEG = eeg_checkset(EEG);
fprintf('Step 1 done