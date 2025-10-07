# elec5305-project-TengfeiWang-540542743
5305 project
ELEC5305 Project Proposal (Draft)
1. Project Title
Speech Denoising and Enhancement using Classical Signal Processing Methods
2. Student Information
Full Name: Tengfei Wang
Student ID (SID): 540542743
GitHub Username: Tengfei Wang5305
GitHub Project Link:
https://tengfeiwang5305.github.io/elec5305-project-TengfeiWang-540542743/
3. Project Overview
This project addresses the problem of speech degradation in noisy acoustic
environments. Speech signals are frequently contaminated by environmental noise, leading to reduced intelligibility for human listeners and performance loss in
automatic speech recognition (ASR). The goal is to implement and evaluate classical
noise reduction methods that enhance noisy speech while preserving naturalness. The proposed solution is to design and compare several time–frequency domain
approaches, including spectral subtraction, Wiener filtering, and FIR low-pass
filtering. The project emphasizes both quantitative evaluation (SNR improvement)
and qualitative demonstrations (waveform, spectrum, and spectrogram visualizations). 4. Background and Motivation
Speech enhancement has been studied for decades, with classical approaches such as
Boll’s spectral subtraction (1979) and Ephraim and Malah’s MMSE estimator (1984)
forming the basis of modern research. While deep learning–based methods now
dominate, traditional signal processing remains widely used in low-resource
applications and provides valuable pedagogical insight. I selected this topic because it balances feasibility and relevance: it can be
implemented with MATLAB without requiring high computational resources, yet
addresses a core challenge in speech technology. Furthermore, it allows both
measurable outcomes (objective SNR gain) and perceptual demonstrations (listening
tests, spectrogram comparisons), aligning with the project’s emphasis on
communication and demonstration. 5. Proposed Methodology
Tools and platforms: MATLAB (no special toolboxes required), GitHub for version
control and documentation. Signal processing sequence:
Input clean speech (from Archive.org sine/speech samples ) and add synthetic noise at
controlled SNR levels (5, 15, 30 dB). Apply enhancement methods:
Spectral subtraction: estimate noise spectrum from silent segments, subtract from
noisy magnitude spectrum. Wiener filtering: estimate clean speech spectrum using SNR-dependent gain function. Low-pass FIR filtering: baseline approach for noise suppression. Reconstruct enhanced speech via inverse STFT. Evaluate outputs using objective metrics (SNR, log-spectral distance) and
visualizations (time-domain, FFT, spectrogram). Data sources: Archive.org free speech/sine samples (public domain), supplemented by
simple recordings if necessary. 6. Expected Outcomes
A MATLAB-based prototype that performs noise addition, speech enhancement, and
signal reconstruction. Clear visual demonstrations of noise suppression in time- and frequency-domain
plots.Quantitative results showing SNR improvement for different algorithms. A GitHub repository documenting code, plots, and explanations. A video presentation that includes waveform and spectrogram comparisons and plays
back clean vs. noisy vs. enhanced audio.
