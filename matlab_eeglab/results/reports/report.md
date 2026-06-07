# EEG Signal Processing Report
## Subject S003 — Eyes Open (R01) & Eyes Closed (R02) Comparison

**Dataset:** EEG Motor Movement/Imagery Dataset — PhysioNet  
**Link:** https://physionet.org/content/eegmmidb/1.0.0/  
**Subject:** S003 | **Runs:** R01 (Eyes Open) & R02 (Eyes Closed)  
**Tools:** MATLAB R2025a + EEGLAB v2026.0.0  

---

## 1. Dataset Description

The EEG Motor Movement/Imagery dataset (PhysioNet) contains recordings from 109 subjects. This report focuses on Subject S003, comparing two resting-state conditions:

| Run | Condition | Duration |
|-----|-----------|----------|
| R01 | Eyes Open Baseline | ~61 sec |
| R02 | Eyes Closed Baseline | ~61 sec |

**Recording Parameters:**
- Channels: 64 (10-20 system)
- Sampling Rate: 160 Hz
- Reference: Average (applied during preprocessing)

---

## 2. Preprocessing Pipeline

Both runs underwent identical preprocessing steps:

### Step 1 — Channel Locations
Standard 10-05 electrode coordinates assigned using `standard_1005.elc`. Channel labels cleaned (trailing dots removed, converted to uppercase) before location assignment.

### Step 2 — Re-referencing
Data re-referenced to **average reference**.

### Step 3 — Bandpass Filter
Applied **1–40 Hz bandpass filter** (zero-phase FIR, firfilt plugin).

### Step 4 — Notch Filter
Applied **60 Hz notch filter** to remove US power line noise.

### Step 5 — Bad Channel Removal
Kurtosis-based detection:

| Run | Bad Channels Removed |
|-----|---------------------|
| R01 | 0 (all 64 passed) |
| R02 | 1 (PZ — kurtosis: 16.30) |

---

## 3. Independent Component Analysis (ICA)

### ICA Decomposition
Applied **Infomax ICA** (runica, extended mode) to both runs. Components classified using **ICLabel**.

### Rejected Components — R01 (Eyes Open)

| Component | Primary Reason | ICLabel Score |
|-----------|---------------|---------------|
| IC1  | Eye artifact | Eye: 47.1% |
| IC2  | Eye artifact | Eye artifact pattern |
| IC4  | Channel noise | Channel Noise: 32.9% |
| IC5  | Artifact | Visual inspection |
| IC11 | Artifact | Visual inspection |
| IC14 | Drift artifact | Signal drift |
| IC15 | Channel noise | Channel Noise: 26.8% |
| IC19 | Channel noise | Channel Noise: 29.6% |
| IC24 | Channel noise | Channel Noise: 14.2% + abnormal PSD ||
| IC30 | Eye artifact | Eye: 42.8% |
| IC32 | Noise | Flat power spectrum |
| IC37 | Channel noise | Channel Noise: 22.6% + steep PSD |
| IC45 | Eye artifact | Eye: 31.4% |
| IC47 | Noise | Steep PSD drop after 20Hz |

**Total removed R01:** 14 components | **Remaining:** 49 components

### Rejected Components — R02 (Eyes Closed)

| Component | Primary Reason | ICLabel Score |
|-----------|---------------|---------------|
| IC29 | Channel noise + drift | Channel Noise: 18.8% |
| IC37 | Line noise + steep PSD | Line Noise: 11.2% |
| IC38 | Drift + steep PSD | Signal drift |
| IC48 | Flat PSD + drift | Abnormal power spectrum |
| IC56 | Flat PSD + large peaks | Frontal topomap pattern |
| IC63 | Channel noise + artifact | Channel Noise: 7.9% |

**Total removed R02:** 6 components | **Remaining:** 56 components

---

## 4. Epoching

Fixed-length epoching applied to both runs:

| Run | Epoch Length | Total Epochs |
|-----|-------------|--------------|
| R01 | 2 seconds | 30 |
| R02 | 2 seconds | 30 |

---

## 5. Analysis Results

### 5.1 PSD Comparison — Eyes Open vs Eyes Closed

![PSD Comparison](../figures/comparison_PSD_R01_R02.png)

**Key Finding:** Eyes closed condition shows a prominent **alpha peak at ~10 Hz** absent in the eyes open condition. This is consistent with well-established EEG literature on alpha synchronization during rest with eyes closed.

### 5.2 Eyes Open (R01) — Power Spectral Density

![PSD R01](../figures/PSD_S003_R01.png)

- Characteristic 1/f slope
- No prominent alpha peak
- Clean signal after 40 Hz

### 5.3 Eyes Open (R01) — Topographic Map

![Topomap R01](../figures/Topomap_S003_R01.png)

- Relatively uniform distribution across scalp
- No strong posterior dominance

### 5.4 Eyes Closed (R02) — Power Spectral Density

![PSD R02](../figures/PSD_S003_R02.png)

- Clear **alpha peak at ~10 Hz**
- Higher overall power compared to R01
- Strong posterior activity

### 5.5 Eyes Closed (R02) — Topographic Map

![Topomap R02](../figures/Topomap_S003_R02.png)

- Posterior alpha dominance visible
- Occipital regions show highest activity

---

## 6. Summary

| Parameter | R01 (Eyes Open) | R02 (Eyes Closed) |
|-----------|----------------|-------------------|
| Channels | 64 | 63 (PZ removed) |
| ICA components removed | 14 | 6 |
| Epochs | 30 × 2 sec | 30 × 2 sec |
| Alpha peak (~10 Hz) | Absent | Present |
| Posterior dominance | Weak | Strong |

**Main conclusion:** The preprocessing pipeline successfully cleaned both resting-state conditions. The comparison confirms the expected **alpha synchronization** phenomenon — a well-established neurophysiological finding where closing the eyes leads to increased alpha power, particularly in posterior regions.

---

## 7. References

 - Schalk, G. (2009). EEG Motor Movement/Imagery Dataset (version 1.0.0). 
  PhysioNet. https://doi.org/10.13026/C28G6P
- Delorme A, Makeig S (2004). EEGLAB: an open source toolbox for analysis 
  of single-trial EEG dynamics including independent component analysis. 
  Journal of Neuroscience Methods, 134(1), 9-21. 
  https://doi.org/10.1016/j.jneumeth.2003.10.009
- Pion-Tonachini L, Kreutz-Delgado K, Makeig S (2019). ICLabel: An automated 
  electroencephalographic independent component classifier, dataset, and website. 
  NeuroImage, 198, 181-197. 
  https://doi.org/10.1016/j.neuroimage.2019.05.026