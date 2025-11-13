function plot_experiment_results(T)
% PLOT_EXPERIMENT_RESULTS  Visualise SNR improvements for each method.

    if ~exist('results','dir'); mkdir('results'); end

    noiseTypes = unique(T.noiseType);
    snrLevels  = unique(T.inputSNR);
    methods    = {'Wiener','Spectral','Hybrid'};

    for n = 1:numel(noiseTypes)
        nt = noiseTypes{n};

        meanImp = zeros(numel(snrLevels), numel(methods));

        for s = 1:numel(snrLevels)
            lvl = snrLevels(s);
            idx = strcmp(T.noiseType, nt) & T.inputSNR == lvl;

            if ~any(idx)
                continue;
            end

            snrNoisy = T.snrNoisy(idx);
            snrWien  = T.snrWiener(idx);
            snrSpec  = T.snrSpectral(idx);
            snrHyb   = T.snrHybrid(idx);

            meanImp(s,1) = mean(snrWien  - snrNoisy);
            meanImp(s,2) = mean(snrSpec  - snrNoisy);
            meanImp(s,3) = mean(snrHyb   - snrNoisy);
        end

        figure('Position',[100 100 800 400]);
        bar(snrLevels, meanImp, 'grouped');
        xlabel('Input SNR (dB)');
        ylabel('Average SNR improvement (dB)');
        title(sprintf('SNR improvement vs. input SNR (%s noise)', nt));
        legend(methods, 'Location','northwest');

        outName = sprintf('results/exp_%s_snr_improvement.png', nt);
        saveas(gcf, outName);
    end
end
