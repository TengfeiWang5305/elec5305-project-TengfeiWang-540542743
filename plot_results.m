function plot_results(x, xn, y_w, y_s, y_h, fs)
t = (0:length(x)-1)/fs;
figure('Position',[100 100 1000 600]);
subplot(4,1,1); plot(t,x); title('Original Clean Speech');
subplot(4,1,2); plot(t,xn); title('Noisy Speech');
subplot(4,1,3); plot(t,y_w); title('Wiener Denoised');
subplot(4,1,4); plot(t,y_h); title('Adaptive Hybrid Denoised');
saveas(gcf,'results/comparison_waveforms.png');
end
