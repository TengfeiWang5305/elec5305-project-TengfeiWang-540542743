# ELEC5305 Project – Adaptive Hybrid Speech Denoising

**Author:** Tengfei Wang (540542743)  
**Unit:** ELEC5305 – Audio Signal Processing, University of Sydney  

---## Example 1 – OSR\_us\_000\_0031\_8k (clean English speech)

**Input (clean speech):**

- [`input_OSR_us_000_0031_8k.wav`](examples/osr_0031/input_OSR_us_000_0031_8k.wav)

**Noisy and denoised outputs:**

- [`noisy.wav`](examples/osr_0031/noisy.wav)
- [`wiener.wav`](examples/osr_0031/wiener.wav)
- [`spectral.wav`](examples/osr_0031/spectral.wav)
- [`hybrid.wav`](examples/osr_0031/hybrid.wav)

**Waveform comparison:**

![Waveform comparison](examples/osr_0031/comparison_waveforms.png)

**Quick listening (in browsers that support HTML audio):**

<audio controls src="examples/osr_0031/noisy.wav"></audio> Noisy  
<audio controls src="examples/osr_0031/hybrid.wav"></audio> Hybrid

> The hybrid method audibly reduces background noise while preserving the speech structure more clearly than the baselines.


## 1. Project Overview

This project implements and evaluates several **classical speech enhancement methods** in MATLAB and proposes an **adaptive hybrid denoiser** that combines their strengths.

The goal is to reduce additive noise in real speech recordings (e.g. OSR open speech corpus) while preserving perceptual quality and intelligibility, using only traditional signal processing techniques (no deep learning, no pre-trained models).

### Implemented methods

1. **Wiener filter**  
   STFT-based Wiener filtering with noise power estimation from initial noise-dominated frames.

2. **Spectral subtraction**  
   Classical magnitude-domain spectral subtraction with noise tracking and spectral flooring.

3. **Proposed adaptive hybrid filter**  
   A *noise-adaptive* combination of Wiener and spectral subtraction, where the time–frequency weighting is controlled by an estimated SNR and noise statistics.  
   - At low SNR or strong noise, the filter leans towards Wiener behaviour.  
   - At higher SNR or stable regions, it behaves more like spectral subtraction to better preserve speech harmonics.

All implementations are **pure MATLAB code** without requiring additional toolboxes.

---

## 2. File Structure

```text
elec5305-project-TengfeiWang-540542743/
  data/                      # input clean speech files (e.g. OSR_us_000_0031_8k.wav)
  results/                   # demo outputs, figures, audio, experiment CSV
  examples/
    osr_0031/                # fixed example for GitHub (see Section 5)
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

  README.md



