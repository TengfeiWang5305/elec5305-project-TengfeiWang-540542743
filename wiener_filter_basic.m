function y = wiener_filter_basic(xn, fs)
% WIENER_FILTER_BASIC
% Simple STFT-based Wiener filter implementation.

    N   = 1024;
    hop = N/2;
    win = local_hann(N);

    xn = xn(:);
    y  = zeros(size(xn));

    % 噪声估计：前几帧
    numNoiseFrames = 5;
    noiseMagAccum  = 0;
    count          = 0;

    idx = 1;
    while idx + N - 1 <= length(xn) && count < numNoiseFrames
        frame = xn(idx:idx+N-1) .* win;
        X     = fft(frame);
        noiseMagAccum = noiseMagAccum + abs(X);
        count = count + 1;
        idx   = idx + hop;
    end

    noiseMagEst = noiseMagAccum / max(count,1);
    noisePowEst = noiseMagEst.^2;

    eps_ = 1e-8;
    idx  = 1;
    while idx + N - 1 <= length(xn)
        frame = xn(idx:idx+N-1) .* win;
        X     = fft(frame);
        mag   = abs(X);
        phase = angle(X);

        speechPowEst = max(mag.^2 - noisePowEst, 0);
        H = speechPowEst ./ (speechPowEst + noisePowEst + eps_);

        Y    = H .* (mag .* exp(1j*phase));
        ySeg = real(ifft(Y)) .* win;

        y(idx:idx+N-1) = y(idx:idx+N-1) + ySeg;
        idx = idx + hop;
    end

    y = y ./ (max(abs(y)) + eps_);
end

function w = local_hann(N)
%LOCAL_HANN Simple Hann window without toolboxes
    n = (0:N-1)';
    w = 0.5 - 0.5*cos(2*pi*n/(N-1));
end
