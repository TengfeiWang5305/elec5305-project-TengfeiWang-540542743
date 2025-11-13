function generate_demo_video(x, xn, y, fs)
% GENERATE_DEMO_VIDEO (v3.0)
% 约 30 秒动态视频：波形 & 频谱随时间慢慢展开

    if ~exist('results','dir'); mkdir('results'); end

    outFile   = 'results/demo_denoising.mp4';
    frameRate = 20;          % 帧率
    targetDur = 30;          % 目标视频时长(秒)

    numFrames = frameRate * targetDur;

    vw = VideoWriter(outFile, 'MPEG-4');
    vw.FrameRate = frameRate;
    open(vw);

    % Normalize
    x  = x(:)  ./ (max(abs(x))  + 1e-8);
    xn = xn(:) ./ (max(abs(xn)) + 1e-8);
    y  = y(:)  ./ (max(abs(y))  + 1e-8);

    N   = 512;
    hop = N/2;
    win = local_hann(N);

    [Sx, fx, tx]    = simple_spec(x,  fs, win, hop, N);
    [Sxn, fxn, txn] = simple_spec(xn, fs, win, hop, N);
    [Sy, fy, ty]    = simple_spec(y,  fs, win, hop, N);

    T_clean = length(x)/fs;
    T_noisy = length(xn)/fs;
    T_hyb   = length(y)/fs;

    fig = figure('Position',[100 100 1000 600]);

    for f = 1:numFrames
        progress = f / numFrames;   % 0 → 1
        clf;

        % ---- 波形索引 ----
        t_lim_clean = progress * T_clean;
        t_lim_noisy = progress * T_noisy;
        t_lim_hyb   = progress * T_hyb;

        idx_c = max(1, min(round(t_lim_clean*fs), length(x)));
        idx_n = max(1, min(round(t_lim_noisy*fs), length(xn)));
        idx_h = max(1, min(round(t_lim_hyb*fs), length(y)));

        t_c = (0:idx_c-1)/fs;
        t_n = (0:idx_n-1)/fs;
        t_h = (0:idx_h-1)/fs;

        % ===== 上排：波形 =====
        subplot(2,3,1);
        plot(t_c, x(1:idx_c));
        xlim([0 T_clean]); ylim([-1 1]);
        title('Clean'); xlabel('Time (s)');

        subplot(2,3,2);
        plot(t_n, xn(1:idx_n));
        xlim([0 T_noisy]); ylim([-1 1]);
        title('Noisy'); xlabel('Time (s)');

        subplot(2,3,3);
        plot(t_h, y(1:idx_h));
        xlim([0 T_hyb]); ylim([-1 1]);
        title('Hybrid Denoised'); xlabel('Time (s)');

        % ===== 下排：频谱 =====
        k_c = max(1, round(progress * size(Sx,2)));
        subplot(2,3,4);
        imagesc(tx(1:k_c), fx, 20*log10(abs(Sx(:,1:k_c))+1e-8));
        axis xy; colormap jet;
        hold on; plot([tx(k_c) tx(k_c)], [0 fx(end)], 'w--'); hold off;
        title('Clean Spectrogram'); xlabel('Time (s)'); ylabel('Freq (Hz)');

        k_n = max(1, round(progress * size(Sxn,2)));
        subplot(2,3,5);
        imagesc(txn(1:k_n), fxn, 20*log10(abs(Sxn(:,1:k_n))+1e-8));
        axis xy; colormap jet;
        hold on; plot([txn(k_n) txn(k_n)], [0 fxn(end)], 'w--'); hold off;
        title('Noisy Spectrogram'); xlabel('Time (s)');

        k_h = max(1, round(progress * size(Sy,2)));
        subplot(2,3,6);
        imagesc(ty(1:k_h), fy, 20*log10(abs(Sy(:,1:k_h))+1e-8));
        axis xy; colormap jet;
        hold on; plot([ty(k_h) ty(k_h)], [0 fy(end)], 'w--'); hold off;
        title('Hybrid Spectrogram'); xlabel('Time (s)');

        drawnow;
        frame = getframe(fig);
        writeVideo(vw, frame);
    end

    close(vw);
    close(fig);
    fprintf(' Demo video saved to %s\n', outFile);
end
function [S, f, t] = simple_spec(x, fs, win, hop, N)
% SIMPLE_SPEC  Simple STFT for spectrogram.

    x = x(:);
    L = length(x);
    frames    = 1:hop:(L-N+1);
    numFrames = numel(frames);

    S = zeros(N, numFrames);
    for i = 1:numFrames
        idx = frames(i);
        seg = x(idx:idx+N-1).*win;
        S(:,i) = fft(seg);
    end

    f = (0:N-1)'*fs/N;
    t = (frames-1)/fs;
end

function w = local_hann(N)
%LOCAL_HANN Simple Hann window without toolboxes
    n = (0:N-1)';
    w = 0.5 - 0.5*cos(2*pi*n/(N-1));
end
