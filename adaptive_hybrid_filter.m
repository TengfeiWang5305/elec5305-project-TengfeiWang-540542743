function y = adaptive_hybrid_filter(xn, fs)
% ADAPTIVE_HYBRID_FILTER
% Combine Wiener-like and spectral-subtraction-like estimates
% using an SNR-dependent weight alpha.

    N   = 1024;
    hop = N/2;
    win = local_hann(N);

    xn = xn(:);
    y  = zeros(size(xn));

    noiseMagEst = [];
    alphaNoise  = 0.95;   % 噪声平均平滑系数
    alphaPrev   = 0.5;    % 上一帧权重
    eps_        = 1e-8;

    idx = 1;
    while idx + N - 1 <= length(xn)
        frame = xn(idx:idx+N-1) .* win;
        X     = fft(frame);
        mag   = abs(X);
        phase = angle(X);

        % ---- 噪声幅度跟踪 ----
        if isempty(noiseMagEst)
            noiseMagEst = mag;
        else
            framePower = mean(mag.^2);
            noisePower = mean(noiseMagEst.^2);

            if framePower < 1.5*noisePower
                % 噪声主导：更强更新
                noiseMagEst = alphaNoise*noiseMagEst + (1-alphaNoise)*mag;
            else
                % 语音主导：更新更慢
                noiseMagEst = alphaNoise*noiseMagEst + (1-alphaNoise*0.2)*mag;
            end
        end

        % ---- 估计这一帧的 SNR(dB) ----
        snrLin     = mean(mag.^2) ./ (mean(noiseMagEst.^2) + eps_);
        snrDb      = 10*log10(snrLin + eps_);
        alphaFrame = 1 ./ (1 + exp(-0.4*(snrDb - 5)));  % logistic 映射
        alphaFrame = max(min(alphaFrame, 0.98), 0.02);
        alpha      = 0.7*alphaPrev + 0.3*alphaFrame;    % 时间平滑
        alphaPrev  = alpha;

        % ---- Wiener-like 估计 ----
        P_speech = mag.^2;
        P_noise  = noiseMagEst.^2;
        H_wien   = max((P_speech - P_noise) ./ (P_speech + eps_), 0.1);
        Y_wien   = H_wien .* (mag .* exp(1j*phase));

        % ---- 谱减估计 ----
        magSpec = max(mag - noiseMagEst, 0.1*noiseMagEst);
        Y_spec  = magSpec .* exp(1j*phase);

        % ---- Hybrid 合成 ----
        Y    = alpha*Y_wien + (1-alpha)*Y_spec;
        ySeg = real(ifft(Y)) .* win;

        y(idx:idx+N-1) = y(idx:idx+N-1) + ySeg;
        idx = idx + hop;
    end

    y = y ./ (max(abs(y)) + eps_);
end

function w = local_hann(N)
    n = (0:N-1)';
    w = 0.5 - 0.5*cos(2*pi*n/(N-1));
end
