# preprocessing.py
# EEG Preprocessing Pipeline using MNE-Python

import mne
from mne.preprocessing import ICA


def clean_channel_names(raw):
    """Remove trailing dots and convert to uppercase."""
    new_names = {ch: ch.rstrip('.').upper() for ch in raw.ch_names}
    raw.rename_channels(new_names)
    return raw


def set_montage(raw):
    """Set standard 10-05 electrode montage."""
    montage = mne.channels.make_standard_montage('standard_1005')
    raw.set_montage(montage, on_missing='ignore', verbose=False)
    return raw


def preprocess(raw):
    """
    Full preprocessing pipeline:
    - Average reference
    - Bandpass filter 1-40 Hz
    - Notch filter 60 Hz
    """
    raw.set_eeg_reference('average', projection=False, verbose=False)
    raw.filter(1., 40., fir_window='hamming', verbose=False)
    raw.notch_filter(60., verbose=False)
    return raw


def run_ica(raw, n_components=20, random_state=42):
    """Run ICA decomposition."""
    ica = ICA(n_components=n_components, random_state=random_state, verbose=False)
    ica.fit(raw, verbose=False)
    return ica


def remove_artifacts(raw, ica):
    """Remove eye artifacts using ICA."""
    eog_indices, _ = ica.find_bads_eog(
        raw, ch_name=['FP1', 'FP2'], verbose=False
    )
    print(f"Removed components: {eog_indices}")
    ica.exclude = eog_indices
    raw_clean = raw.copy()
    ica.apply(raw_clean, verbose=False)
    return raw_clean


def make_epochs(raw, duration=2.0):
    """Create fixed-length epochs."""
    return mne.make_fixed_length_epochs(
        raw, duration=duration, preload=True, verbose=False
    )