%% RUN_BATCH_EXPERIMENTS
% Systematic evaluation over:
%   - multiple speech files
%   - multiple noise types
%   - multiple input SNR levels

clc; clear; close all;
addpath(genpath(pwd));

% === settings ===
speechFiles = { ...
    'data/OSR_us_000_0031_8k.wav', ...
    'data/OSR_us_000_0011_8k.wav' ...
};
noiseTypes  = {'whitehum', 'babble', 'highfreq'};
snrLevels   = [0 5 10 15];          % dB
maxDur      = 10;                   % use first 10 s of each file

results = struct([]);
idx = 1;

for f = 1:numel(speechFiles)
    filePath = speechFiles{f};
    if ~exist(filePath, 'file')
        warning('Speech file not found: %s (skipping)', filePath);
        continue;
    end

    [x, fs] = audioread(filePath);
    if size(x,2) > 1
        x = mean(x,2);
    end
    if length(x) > maxDur*fs
        x = x(1:maxDur*fs);
    end
    x = x(:);

    for n = 1:numel(noiseTypes)
        nt = noiseTypes{n};

        for s = 1:numel(snrLevels)
            inSNR = snrLevels(s);

            fprintf('File: %s | Noise: %s | SNR: %d dB\n', ...
                filePath, nt, inSNR);

            % --- add noise ---
            [xn, ~] = add_noise_with_snr(x, fs, nt, inSNR);

            % --- denoise ---
            y_w = wiener_filter_basic(xn, fs);
            y_s = spectral_subtraction_basic(xn, fs);
            y_h = adaptive_hybrid_filter(xn, fs);

            % --- SNR evaluation ---
            snr_noisy = evaluate_snr(x, xn);
            snr_wien  = evaluate_snr(x, y_w);
            snr_spec  = evaluate_snr(x, y_s);
            snr_hyb   = evaluate_snr(x, y_h);

            % --- store ---
            results(idx).speechFile = filePath;
            results(idx).noiseType  = nt;
            results(idx).inputSNR   = inSNR;
            results(idx).snrNoisy   = snr_noisy;
            results(idx).snrWiener  = snr_wien;
            results(idx).snrSpectral= snr_spec;
            results(idx).snrHybrid  = snr_hyb;

            idx = idx + 1;
        end
    end
end

if isempty(results)
    error('No experiments were run. Check file paths.');
end

T = struct2table(results);

if ~exist('results','dir'); mkdir('results'); end
save('results/experiment_results.mat', 'T');
writetable(T, 'results/experiment_results.csv');

fprintf('\nSaved experiment results to results/experiment_results.csv\n');

plot_experiment_results(T);
