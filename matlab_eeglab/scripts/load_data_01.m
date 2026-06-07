% load_data_01.m
% Load EEG Data from PhysioNet EEG Motor Movement Dataset
% Subject: S003 | Runs: R01 (Eyes Open), R02 (Eyes Closed), R03 (Motor Task)
% Dataset: https://physionet.org/content/eegmmidb/1.0.0/

clear; clc; close all;

%% Setup
eeglab_path = fileparts(which('eeglab.m'));
addpath(eeglab_path);
eeglab nogui;

data_path = 'C:\Users\Pentium\Downloads';
save_path = 'C:\Users\Pentium\Desktop\EEG_Project\data\processed\';

%% Load R01 - Eyes Open Baseline
EEG_R01 = pop_biosig(fullfile(data_path, 'S003R01.edf'));
EEG_R01.setname = 'S003_EyesOpen';
EEG_R01 = eeg_checkset(EEG_R01);

%% Load R02 - Eyes Closed Baseline
EEG_R02 = pop_biosig(fullfile(data_path, 'S003R02.edf'));
EEG_R02.setname = 'S003_EyesClosed';
EEG_R02 = eeg_checkset(EEG_R02);

%% Load R03 - Motor Task
EEG_R03 = pop_biosig(fullfile(data_path, 'S003R03.edf'));
EEG_R03.setname = 'S003_MotorTask';
EEG_R03 = eeg_checkset(EEG_R03);

%% اطلاعات پایه
fprintf('\n=== Dataset Info ===\n');
fprintf('Channels : %d\n', EEG_R01.nbchan);
fprintf('Samp Rate: %d Hz\n', EEG_R01.srate);
fprintf('R01 Duration: %.1f sec\n', EEG_R01.xmax);
fprintf('R02 Duration: %.1f sec\n', EEG_R02.xmax);
fprintf('R03 Duration: %.1f sec\n', EEG_R03.xmax);

%% ذخیره
pop_saveset(EEG_R01, 'filename', 'S003_R01_raw.set', 'filepath', save_path);
pop_saveset(EEG_R02, 'filename', 'S003_R02_raw.set', 'filepath', save_path);
pop_saveset(EEG_R03, 'filename', 'S003_R03_raw.set', 'filepath', save_path);

disp('=== All Files Loaded and Saved ===');