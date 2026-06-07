% artifact_removal_03.m
% ICA Artifact Removal
% Dataset: EEG Motor Movement/Imagery - PhysioNet
% Subject: S003 | Run: R01 (Eyes Open Baseline)

clear; clc; close all;

%% Setup
eeglab_path = fileparts(which('eeglab.m'));
addpath(eeglab_path);
eeglab nogui;

%% Load ICA data
EEG = pop_loadset('filename', 'S003_R01_ica.set', ...
    'filepath', 'C:\Users\Pentium\Desktop\EEG_Project\data\processed\');

%% Rejected components based on ICLabel + visual inspection
% Criteria: Eye > 30%, Channel Noise > 25%, flat power spectrum, drift
rejected = [1, 2, 4, 5, 11, 14, 15, 19, 24, 30, 32, 37, 45, 47];
EEG = pop_subcomp(EEG, rejected, 0);

fprintf('Removed %d components\n', length(rejected));
fprintf('Channels: %d | Duration: %.1f sec\n', EEG.nbchan, EEG.xmax);

%% Save
pop_saveset(EEG, 'filename', 'S003_R01_clean.set', ...
    'filepath', 'C:\Users\Pentium\Desktop\EEG_Project\data\processed\');

disp('=== Artifact Removal Complete ===');