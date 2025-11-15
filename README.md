# ELEC5305 – Adaptive Hybrid Speech Denoising

> Classical speech enhancement in MATLAB with an adaptive hybrid denoiser.  
> Unit: **ELEC5305 – Audio Signal Processing**, The University of Sydney  
> Author: **Tengfei Wang (540542743)**

---

## 🔗 Quick Links

- 📝 **Project report (PDF)**: [`5305 project.pdf`](./5305%20project.pdf)
- 🎧 **Fixed example (OSR_us_000_0031_8k)**: [`examples/osr_0031`](./examples/osr_0031)
- 🎬 **Demo video**: [`results/demo_denoising.mp4`](./results/demo_denoising.mp4)

---

## 🌟 Example: OSR_us_000_0031_8k

This repository includes a complete “before/after” example using a real English speech recording from the Open Speech Repository.

**Input clean speech**

- [`examples/osr_0031/input_OSR_us_000_0031_8k.wav`](./examples/osr_0031/input_OSR_us_000_0031_8k.wav)

**Noisy and denoised outputs**

- [`examples/osr_0031/noisy.wav`](./examples/osr_0031/noisy.wav)  
- [`examples/osr_0031/wiener.wav`](./examples/osr_0031/wiener.wav)  
- [`examples/osr_0031/spectral.wav`](./examples/osr_0031/spectral.wav)  
- [`examples/osr_0031/hybrid.wav`](./examples/osr_0031/hybrid.wav)

**Waveform comparison**

- [`examples/osr_0031/comparison_waveforms.png`](./examples/osr_0031/comparison_waveforms.png)

---

## 1. Project Overview

This project implements several **classical speech enhancement** methods in MATLAB and proposes an **adaptive hybrid** denoiser that combines their strengths.

The goal is to reduce additive noise in real speech recordings (e.g. OSR open speech corpus) while preserving **perceptual quality** and **intelligibility**, using only traditional signal processing techniques:

- No deep learning  
- No pre-trained models  
- Fully transparent and reproducible algorithms

Implemented methods:

- **Wiener filter** – STFT-based Wiener filtering with noise power estimation.  
- **Spectral subtraction** – magnitude-domain subtraction with spectral flooring.  
- **Adaptive hybrid filter** – frame-wise logistic weighting between Wiener and spectral subtraction based on an SNR estimate.

All implementations are pure MATLAB code and do not require deep learning toolboxes.

---

## 2. File Structure

```text
elec5305-project-TengfeiWang-540542743/
  data/                      # input clean speech files (e.g. OSR_us_000_0031_8k.wav)
  results/                   # demo outputs, figures, audio, experiment CSV
    comparison_waveforms.png
    exp_whitehum_snr_improvement.png
    exp_highfreq_snr_improvement.png
    exp_babble_snr_improvement.png
    demo_denoising.mp4
    experiment_results.csv

  examples/
    osr_0031/                # fixed example for GitHub demo
      input_OSR_us_000_0031_8k.wav
      noisy.wav
      wiener.wav
      spectral.wav
      hybrid.wav
      comparison_waveforms.png

  % core processing
  generate_synthetic_speech.m
  add_noise_simulation.m
  add_noise_with_snr.m
  wiener_filter_basic.m
  spectral_subtraction_basic.m
  adaptive_hybrid_filter.m
  evaluate_snr.m
  plot_results.m
  generate_demo_video.m
  main_hybrid_denoise.m

  % experiments & utilities
  run_batch_experiments.m
  plot_experiment_results.m
  play_audio_demo.m

  % documentation
  5305 project.pdf
  README.md
Clean Speech  →  Noise Generation  →  STFT Analysis
             →  Wiener / Spectral / Hybrid Denoising
             →  SNR Evaluation     →  Plots + Audio + Demo Video
git clone https://github.com/TengfeiWang5305/elec5305-project-TengfeiWang-540542743.git
cd elec5305-project-TengfeiWang-540542743
main_hybrid_denoise
run_batch_experiments
plot_experiment_results




