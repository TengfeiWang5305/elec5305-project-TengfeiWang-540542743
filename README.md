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

- **Wiener filter** – STFT-based Wiener filtering with noise power estimation from initial noise-dominated frames.  
- **Spectral subtraction** – magnitude-domain subtraction with noise tracking and spectral flooring.  
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
3. System Flow
text
复制代码
Clean Speech  →  Noise Generation  →  STFT Analysis
             →  Wiener / Spectral / Hybrid Denoising
             →  SNR Evaluation     →  Plots + Audio + Demo Video
4. How to Run (Single Experiment)
bash
复制代码
# 1. Clone the repository
git clone https://github.com/TengfeiWang5305/elec5305-project-TengfeiWang-540542743.git
cd elec5305-project-TengfeiWang-540542743
matlab
复制代码
% 2. In MATLAB, set current folder to the repo root
% 3. Run the main script
main_hybrid_denoise

% This will:
% - load a speech file from data/ (or generate synthetic speech





你说：

为啥要这样单独写3和4 所有的一起写你能明白么


ChatGPT 说：

已思考 24s
markdown
复制代码
# ELEC5305 – Adaptive Hybrid Speech Denoising

> Classical speech enhancement in MATLAB with an adaptive hybrid denoiser.  
> Unit: **ELEC5305 – Audio Signal Processing**, The University of Sydney  
> Author: **Tengfei Wang (540542743)**

---

## 🔗 Quick Links

- 📝 **Project report (PDF)**: `5305 project.pdf`
- 🎧 **Fixed example (OSR_us_000_0031_8k)**: `examples/osr_0031/`
- 🎬 **Demo video**: `results/demo_denoising.mp4`

---

## 🌟 Example: OSR_us_000_0031_8k

This repository includes a complete “before/after” example using a real English speech recording from the Open Speech Repository.

**Input clean speech**

- `examples/osr_0031/input_OSR_us_000_0031_8k.wav`

**Noisy and denoised outputs**

- `examples/osr_0031/noisy.wav`  
- `examples/osr_0031/wiener.wav`  
- `examples/osr_0031/spectral.wav`  
- `examples/osr_0031/hybrid.wav`

**Waveform comparison**

- `examples/osr_0031/comparison_waveforms.png`

---

## 1. Project Overview

This project implements several classical speech enhancement methods in MATLAB and proposes an adaptive hybrid denoiser that combines their strengths.

The goal is to reduce additive noise in real speech recordings (e.g., OSR open speech corpus) while preserving perceptual quality and intelligibility, using only traditional signal processing techniques:

- no deep learning  
- no pre-trained models  
- fully transparent and reproducible algorithms

Implemented methods:

- **Wiener filter** – STFT-based Wiener filtering with noise power estimation from initial noise-dominated frames.  
- **Spectral subtraction** – magnitude-domain subtraction with noise tracking and spectral flooring.  
- **Adaptive hybrid filter** – frame-wise logistic weighting between Wiener and spectral subtraction based on an SNR estimate.

All implementations are pure MATLAB code and do not require deep learning toolboxes.

---

## 2. File Structure

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

---

## 3. System Flow

    Clean Speech  →  Noise Generation  →  STFT Analysis
                 →  Wiener / Spectral / Hybrid Denoising
                 →  SNR Evaluation     →  Plots + Audio + Demo Video

---

## 4. How to Run (Single Experiment)

    # 1. Clone the repository
    git clone https://github.com/TengfeiWang5305/elec5305-project-TengfeiWang-540542743.git
    cd elec5305-project-TengfeiWang-540542743

In MATLAB:

    % 2. Set current folder to the repo root
    % 3. Run the main script
    main_hybrid_denoise

This will:

- load a speech file from `data/` (or generate synthetic speech)  
- add noise (`whitehum` / `highfreq` / `babble`)  
- run Wiener, spectral subtraction and hybrid denoising  
- compute SNR and print a summary  
- save audio + figures into `results/`

---

## 5. Batch Experiments and Plots

In MATLAB:

    % Run all combinations of speech files, noise types and input SNRs
    run_batch_experiments

    % Generate bar plots of SNR improvement for each noise type
    plot_experiment_results

Outputs:

- `results/experiment_results.csv`  
- `results/exp_whitehum_snr_improvement.png`  
- `results/exp_highfreq_snr_improvement.png`  
- `results/exp_babble_snr_improvement.png`

---

## 6. Demo Video

In MATLAB:

    % Example workflow for generating the demo video

    % Step 1: run a single experiment (e.g. OSR + whitehum noise)
    main_hybrid_denoise

    % Step 2: create a simple time-domain comparison video
    generate_demo_video

The video will be saved as:

- `results/demo_denoising.mp4`

---




