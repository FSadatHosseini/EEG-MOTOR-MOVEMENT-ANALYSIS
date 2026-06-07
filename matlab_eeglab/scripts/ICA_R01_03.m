% ica_03.m
% ICA - Independent Component Analysis
% For artifact removal (eye blinks, muscle noise)

clear; clc; close all;

%% Setup
eeglab_path = fileparts(which('eeglab.m'));
addpath(eeglab_path);
eeglab nogui;