# visualization.py
# EEG Visualization Functions

import matplotlib.pyplot as plt
import os


def plot_psd_comparison(freqs, psd_R01_db, psd_R02_db, save_path=None):
    """Plot PSD comparison between Eyes Open and Eyes Closed."""
    fig, ax = plt.subplots(figsize=(10, 6))
    ax.plot(freqs, psd_R01_db, 'b', linewidth=2, label='Eyes Open (R01)')
    ax.plot(freqs, psd_R02_db, 'r', linewidth=2, label='Eyes Closed (R02)')
    ax.axvspan(8, 13, alpha=0.2, color='yellow', label='Alpha band')
    ax.set_xlabel('Frequency (Hz)')
    ax.set_ylabel('Power (dB)')
    ax.set_title('PSD Comparison - Eyes Open vs Eyes Closed\nSubject S003')
    ax.legend()
    ax.grid(True)
    plt.tight_layout()
    if save_path:
        plt.savefig(save_path, dpi=150)
    plt.show()


def plot_topomap(psd_R01, psd_R02, save_path=None):
    """Plot alpha band topographic maps."""
    problematic = ['FCZ', 'CZ', 'CPZ', 'FP1', 'FPZ', 'FP2',
                   'AFZ', 'FZ', 'PZ', 'POZ', 'OZ', 'IZ']

    psd_R01_topo = psd_R01.copy().drop_channels(
        [ch for ch in problematic if ch in psd_R01.ch_names]
    )
    psd_R02_topo = psd_R02.copy().drop_channels(
        [ch for ch in problematic if ch in psd_R02.ch_names]
    )

    fig, axes = plt.subplots(1, 2, figsize=(12, 5))
    psd_R01_topo.plot_topomap(
        bands={'Alpha (8-13 Hz)': (8, 13)}, axes=axes[0], show=False
    )
    axes[0].set_title('Eyes Open (R01)\nAlpha Power')
    psd_R02_topo.plot_topomap(
        bands={'Alpha (8-13 Hz)': (8, 13)}, axes=axes[1], show=False
    )
    axes[1].set_title('Eyes Closed (R02)\nAlpha Power')
    plt.suptitle('Alpha Band Topography - S003', fontsize=14)
    plt.tight_layout()
    if save_path:
        plt.savefig(save_path, dpi=150)
    plt.show()