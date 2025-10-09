function generate_demo_video(x, xn, yh, fs)
% Generate simple demo video combining before-after plots
v = VideoWriter('results/demo_denoising.mp4','MPEG-4'); open(v);
frames = 100; t = (0:length(x)-1)/fs;
for i=1:frames:length(x)
    idx = min(i+frames-1, length(x));
    plot(t(i:idx), xn(i:idx),'r'); hold on; plot(t(i:idx), yh(i:idx),'b');
    legend('Noisy','Hybrid Denoised'); xlabel('Time (s)'); ylabel('Amp');
    title('Speech Denoising Progress'); hold off;
    frame = getframe(gcf); writeVideo(v,frame);
end
close(v);
fprintf('🎬 Demo video saved to /results/demo_denoising.mp4\\n');
end
