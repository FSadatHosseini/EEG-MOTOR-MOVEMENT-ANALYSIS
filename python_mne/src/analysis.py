# analysis.py
# EEG Analysis Functions

import numpy as np


def compute_psd(epochs, fmin=1, fmax=40):
    """Compute Power Spectral Density."""
    psd = epochs.compute_psd(fmin=fmin, fmax=fmax, verbose=False)
    freqs = psd.freqs
    psd_db = 10 * np.log10(psd.get_data().mean(axis=(0, 1)))
    return psd, freqs, psd_db


def compute_alpha_power(psd, fmin=8, fmax=13):
    """Compute mean alpha band power."""
    freqs = psd.freqs
    alpha_idx = (freqs >= fmin) & (freqs <= fmax)
    alpha_power = psd.get_data()[:, :, alpha_idx].mean()
    return alpha_power