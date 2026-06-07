% comparison_06.m
% PSD Comparison - Eyes Open (R01) vs Eyes Closed (R02)
% Dataset: EEG Motor Movement/Imagery - PhysioNet
% Subject: S003

clear; clc; close all;

%% Setup
eeglab_path = fileparts(which('eeglab.m'));
addpath(eeglab_path);
eeglab nogui;

results_path = 'C:\Users\Pentium\Desktop\EEG_Project\matlab_eeglab\results\figures\';

%% Load epoched data
EEG_R01 = pop_loadset('filename', 'S003_R01_epoched.set', ...
    'filepath', 'C:\Users\Pentium\Desktop\EEG_Project\data\processed\');

EEG_R02 = pop_loadset('filename', 'S003_R02_epoched.set', ...
    'filepath', 'C:\Users\Pentium\Desktop\EEG_Project\data\processed\');

%% محاسبه PSD
[psd_R01, freqs] = spectopo(EEG_R01.data(:,:), EEG_R01.pnts, EEG_R01.srate, 'plot', 'off');
[psd_R02, ~] = spectopo(EEG_R02.data(:,:), EEG_R02.pnts, EEG_R02.srate, 'plot', 'off');

%% مقایسه PSD
figure('Visible', 'on');
plot(freqs, mean(psd_R01, 1), 'b', 'LineWidth', 2); hold on;
plot(freqs, mean(psd_R02, 1), 'r', 'LineWidth', 2);
xlim([1 40]);
xlabel('Frequency (Hz)');
ylabel('Power (10*log_{10}(\muV^2/Hz))');
title('PSD Comparison - Eyes Open vs Eyes Closed');
legend('Eyes Open (R01)', 'Eyes Closed (R02)');
grid on;
saveas(gcf, fullfile(results_path, 'comparison_PSD_R01_R02.png'));

disp('=== Comparison Complete ===');
