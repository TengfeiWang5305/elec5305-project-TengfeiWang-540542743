function plot_results(x, xn, y_w, y_s, y_h, fs)
% PLOT_RESULTS  Plot time-domain waveforms for comparison.

    t = (0:length(x)-1)/fs;

    figure('Position',[100 100 1000 800]);

    subplot(5,1,1);
    plot(t, x);
    title('Original Clean Speech'); xlabel('Time (s)');

    subplot(5,1,2);
    plot(t, xn);
    title('Noisy Speech'); xlabel('Time (s)');

    subplot(5,1,3);
    plot(t, y_w);
    title('Wiener Denoised'); xlabel('Time (s)');

    subplot(5,1,4);
    plot(t, y_s);
    title('Spectral Subtraction Denoised'); xlabel('Time (s)');

    subplot(5,1,5);
    plot(t, y_h);
    title('Adaptive Hybrid Denoised'); xlabel('Time (s)');

    if ~exist('results','dir'); mkdir('results'); end
    saveas(gcf, 'results/comparison_waveforms.png');
end
