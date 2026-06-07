% artifact_removal_R02_03.m
% ICA Artifact Removal - S003 R02 (Eyes Closed Baseline)
% Dataset: EEG Motor Movement/Imagery - PhysioNet
% Criteria: Line Noise, Channel Noise, drift, flat power spectrum

clear; clc; close all;

%% Setup
eeglab_path = fileparts(which('eeglab.m'));
addpath(eeglab_path);
eeglab nogui;

%% Load ICA data
EEG = pop_loadset('filename', 'S003_R02_ica.set', ...
    'filepath', 'C:\Users\Pentium\Desktop\EEG_Project\data\processed\');

%% Rejected components based on ICLabel + visual inspection
% IC29 - Channel Noise 18.8% + drift + steep PSD
% IC37 - Line Noise 11.2% + steep PSD + noisy signal
% IC38 - drift + steep PSD
% IC48 - flat PSD + drift
% IC56 - flat PSD + large peaks + frontal topomap
% IC63 - Channel Noise 7.9% + steep PSD + horizontal line artifact
rejected = [29, 37, 38, 48, 56, 63];

EEG = pop_subcomp(EEG, rejected, 0);
fprintf('Removed %d components\n', length(rejected));
fprintf('Channels: %d | Duration: %.1f sec\n', EEG.nbchan, EEG.xmax);

%% Save
pop_saveset(EEG, 'filename', 'S003_R02_clean.set', ...
    'filepath', 'C:\Users\Pentium\Desktop\EEG_Project\data\processed\');

disp('=== R02 Artifact Removal Complete ===');