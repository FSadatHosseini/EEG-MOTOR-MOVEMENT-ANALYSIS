% analysis_05.m
% EEG Analysis & Visualization - S003 R01 & R02
% Dataset: EEG Motor Movement/Imagery - PhysioNet

clear; clc; close all;

%% Setup
eeglab_path = fileparts(which('eeglab.m'));
addpath(eeglab_path);
eeglab nogui;

data_path = 'C:\Users\Pentium\Desktop\EEG_Project\data\processed\';
results_path = 'C:\Users\Pentium\Desktop\EEG_Project\matlab_eeglab\results\figures\';

%% Load
EEG_R01 = pop_loadset('filename', 'S003_R01_epoched.set', 'filepath', data_path);
EEG_R02 = pop_loadset('filename', 'S003_R02_epoched.set', 'filepath', data_path);

%% R01 - PSD
figure('Visible', 'on');
pop_spectopo(EEG_R01, 1, [], 'EEG', 'percent', 50, 'freq', [8 13 30]);
title('Power Spectral Density - S003 R01 (Eyes Open)');
saveas(gcf, fullfile(results_path, 'PSD_S003_R01.png'));

%% R01 - Topomap
figure('Visible', 'on');
pop_topoplot(EEG_R01, 1, [8 13 30], 'Topomap - R01 Eyes Open', [1 3]);
saveas(gcf, fullfile(results_path, 'Topomap_S003_R01.png'));

%% R02 - PSD
figure('Visible', 'on');
pop_spectopo(EEG_R02, 1, [], 'EEG', 'percent', 50, 'freq', [8 13 30]);
title('Power Spectral Density - S003 R02 (Eyes Closed)');
saveas(gcf, fullfile(results_path, 'PSD_S003_R02.png'));

%% R02 - Topomap
figure('Visible', 'on');
pop_topoplot(EEG_R02, 1, [8 13 30], 'Topomap - R02 Eyes Closed', [1 3]);
saveas(gcf, fullfile(results_path, 'Topomap_S003_R02.png'));

disp('=== Analysis Complete ===');