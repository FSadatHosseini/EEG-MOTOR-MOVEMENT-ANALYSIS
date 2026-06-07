# EEG Analysis Pipeline Overview

## MATLAB + EEGLAB Pipeline
1. Load raw EDF files
2. Assign channel locations (standard_1005)
3. Re-reference to average
4. Bandpass filter (1-40 Hz)
5. Notch filter (60 Hz)
6. Bad channel removal (kurtosis-based)
7. ICA decomposition (Infomax)
8. Artifact removal (ICLabel + visual inspection)
9. Fixed-length epoching (2 sec)
10. PSD and Topomap analysis

## Python + MNE Pipeline
1. Load raw EDF files
2. Clean channel names + set montage
3. Re-reference to average
4. Bandpass filter (1-40 Hz)
5. Notch filter (60 Hz)
6. ICA decomposition (FastICA)
7. Automated artifact removal (EOG detection)
8. Fixed-length epoching (2 sec)
9. PSD and Topomap analysis

## Key Finding
Alpha synchronization (~10 Hz) is clearly observed in the 
eyes closed condition (R02) compared to eyes open (R01),
consistent with established EEG literature.