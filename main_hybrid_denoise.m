%% Main Script: Adaptive Hybrid Speech Denoising
% Author: Tengfei Wang (540542743)
% Run this file to perform noise simulation, denoising, and result generation

clc; clear; close all;
addpath(genpath(pwd));

% === Choose Input Mode ===
useAutoSpeech = true;  % true = auto-generate speech, false = load from file
speechFile = 'data/input.wav';

if useAutoSpeech == true
    fprintf('🎤 Generating synthetic speech-like signal...\n');
    [x, fs] = generate_synthetic_speech();
elseif exist(speechFile, 'file')
    fprintf('🎧 Loading external speech file: %s\n', speechFile);
    [x, fs] = audioread(speechFile);
    if size(x,2) > 1
        x = mean(x,2);  % convert to mono
    end
else
    warning('⚠️ File not found. Using auto-generated signal.');
    [x, fs] = generate_synthetic_speech();
end


% === Add Noise ===
[xn, noise] = add_noise_simulation(x, fs);

% === Apply Denoising ===
y_wien = wiener_filter_basic(xn, fs);
y_spec = spectral_subtraction_basic(xn, fs);
y_hybrid = adaptive_hybrid_filter(xn, fs);

% === Evaluate SNR ===
snr_noisy = evaluate_snr(x, xn);
snr_wien  = evaluate_snr(x, y_wien);
snr_spec  = evaluate_snr(x, y_spec);
snr_hyb   = evaluate_snr(x, y_hybrid);

fprintf('\\nSNR Summary:\\n');
fprintf('  Noisy: %.2f dB\\n  Wiener: %.2f dB\\n  Spectral: %.2f dB\\n  Hybrid: %.2f dB\\n',...
    snr_noisy, snr_wien, snr_spec, snr_hyb);

% === Plot Results ===
plot_results(x, xn, y_wien, y_spec, y_hybrid, fs);

% === Save Audio ===
audiowrite('results/original.wav', x, fs);
audiowrite('results/noisy.wav', xn, fs);
audiowrite('results/hybrid_denoised.wav', y_hybrid, fs);

% === Generate Demo Video ===
generate_demo_video(x, xn, y_hybrid, fs);

fprintf('\\n✅ All processing complete. Results saved in /results.\\n');
soundsc(y_hybrid, fs);
audiowrite('results/test_output.wav', y_hybrid, fs);
