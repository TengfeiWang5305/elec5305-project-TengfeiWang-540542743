%% Main Script: Adaptive Hybrid Speech Denoising (v2.0)
% Author: Tengfei Wang (540542743)
% Run this file to perform noise simulation, denoising, and result generation.

clc; clear; close all;
addpath(genpath(pwd));

if ~exist('results','dir'); mkdir('results'); end

%% === Choose Input Mode ===
% true  = 自动生成类语音
% false = 从外部 WAV 文件读取
useAutoSpeech = false;                               % <<< 
speechFile    = 'data/OSR_us_000_0031_8k.wav';       % <<<

if useAutoSpeech
    fprintf(' Generating synthetic speech-like signal...\n');
    [x, fs] = generate_synthetic_speech();
elseif exist(speechFile, 'file')
    fprintf(' Loading external speech file: %s\n', speechFile);
    [x, fs] = audioread(speechFile);
    if size(x,2) > 1
        x = mean(x,2);                               % 立体声变单声道
    end

    % === 可选：只取前 30 秒，加快实验 ===
    maxDur = 30;                                     % 想用多少秒改这里
    if length(x) > maxDur*fs
        x = x(1:maxDur*fs);
    end

else
    warning('File not found. Using synthetic signal instead.');
    [x, fs] = generate_synthetic_speech();
end

%% === Add Noise ===
[xn, ~] = add_noise_simulation(x, fs);

%% === Denoising Methods ===
y_wien   = wiener_filter_basic(xn, fs);
y_spec   = spectral_subtraction_basic(xn, fs);
y_hybrid = adaptive_hybrid_filter(xn, fs);

%% === Evaluate SNRs ===
snr_noisy  = evaluate_snr(x, xn);
snr_wien   = evaluate_snr(x, y_wien);
snr_spec   = evaluate_snr(x, y_spec);
snr_hybrid = evaluate_snr(x, y_hybrid);

fprintf('\nSNR Summary (single scenario):\n');
fprintf('  Noisy:        %.2f dB\n', snr_noisy);
fprintf('  Wiener:       %.2f dB\n', snr_wien);
fprintf('  Spectral:     %.2f dB\n', snr_spec);
fprintf('  Hybrid (v2):  %.2f dB\n', snr_hybrid);

%% === Plot Results ===
plot_results(x, xn, y_wien, y_spec, y_hybrid, fs);

%% === Save Audio ===
audiowrite('results/original.wav',        x,         fs);
audiowrite('results/noisy.wav',           xn,        fs);
audiowrite('results/wiener_denoised.wav', y_wien,    fs);
audiowrite('results/spectral_denoised.wav', y_spec,  fs);
audiowrite('results/hybrid_denoised.wav', y_hybrid,  fs);

%% === Demo Video ===
generate_demo_video(x, xn, y_hybrid, fs);

fprintf('\n✅ All processing complete. Check the "results" folder.\n');
