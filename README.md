# 🎧 ELEC5305 – Adaptive Hybrid Speech Denoising
**Author:** Tengfei Wang (540542743)  
**Course:** ELEC5305 – Speech and Audio Signal Processing  
**University:** The University of Sydney  

---

## 📘 Project Overview
This project implements **classical speech denoising techniques** using MATLAB.  
It compares three traditional noise reduction methods and introduces a **custom adaptive hybrid approach**.

### Implemented Methods
1. **Wiener Filter** – Statistical denoising minimizing mean square error.  
2. **Spectral Subtraction** – Frequency-domain noise suppression via spectral magnitude estimation.  
3. **Adaptive Hybrid Filter (Proposed)** – Combines Wiener and Spectral Subtraction filters using adaptive weighting to balance noise suppression and speech quality.

The project evaluates each method quantitatively (via SNR) and qualitatively (via waveform visualization).

---

## ⚙️ System Flow

```

Data Input → Noise Simulation → STFT Analysis → Wiener/Spectral/Hybrid Denoising → SNR Evaluation → Results Visualization

---

## 🧩 Repository Structure

```

📁 elec5305-project-TengfeiWang-540542743
├── main_hybrid_denoise.m           # Main script for running the full pipeline
├── generate_synthetic_speech.m     # Synthetic speech generator (for testing)
├── add_noise_simulation.m          # Adds artificial noise (white/babble)
├── wiener_filter_basic.m           # Classical Wiener filter
├── spectral_subtraction_basic.m    # Frequency-domain spectral subtraction
├── adaptive_hybrid_filter.m        # Hybrid denoising algorithm (custom)
├── evaluate_snr.m                  # Signal-to-Noise Ratio evaluation
├── plot_results.m                  # Visualization of waveforms
├── generate_demo_video.m           # Automatically creates demo video
├── data/                           # Input audio files (optional)
└── results/                        # Denoised outputs and visual results

````

---

##  How to Run

1. Clone this repository:
   ```bash
   git clone https://github.com/TengfeiWang5305/elec5305-project-TengfeiWang-540542743.git
   cd elec5305-project-TengfeiWang-540542743
````

2. Open MATLAB and execute:

   ```matlab
   main_hybrid_denoise
   ```

3. The script will:

   * Auto-generate synthetic speech (or load from `/data/input.wav` if available)
   * Simulate environmental noise
   * Apply Wiener, Spectral, and Hybrid denoising
   * Evaluate SNR improvement
   * Plot results and save all outputs to `/results`

---

##  Visualization Results
###  Example Output (Waveforms)


| Signal Type         | Description                        |
| ------------------- | ---------------------------------- |
| **Clean Speech**    | Original synthetic or loaded audio |
| **Noisy Speech**    | With simulated white/babble noise  |
| **Wiener Denoised** | Classical filter output            |
| **Hybrid Denoised** | Proposed adaptive combination      |

### 📊 Example SNR Results

```
Noisy:    2.91 dB  
Wiener:   2.65 dB  
Spectral: 2.63 dB  
Hybrid:   2.63 dB
```

---

## 📽️ Demo Video

🎥 A short demonstration video showing input vs denoised speech is automatically generated at:

```
results/demo_denoising.mp4
```

You can embed or upload this file for a visual demonstration in your presentation.

---

## 🧠 Key Insights

* The **Hybrid Filter** dynamically adjusts weights between Wiener and Spectral Subtraction outputs.
* It achieves **better balance** between noise suppression and speech clarity than individual methods.
* Effective in moderate-noise scenarios where spectral distortion is significant.

---

## 🔧 Requirements

* **MATLAB R2023b** or later
* *(Optional)* Signal Processing Toolbox

---



