function y = spectral_subtraction_basic(xn, fs)
% SPECTRAL_SUBTRACTION_BASIC
% Classic spectral subtraction with simple noise estimation.

    N   = 1024;
    hop = N/2;
    win = local_hann(N);

    xn = xn(:);
    y  = zeros(size(xn));

    % ---- 噪声估计：前几帧 ----
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

    floorFactor = 0.1;
    idx         = 1;

    % ---- 主循环 ----
    while idx + N - 1 <= length(xn)
        frame = xn(idx:idx+N-1) .* win;
        X     = fft(frame);
        mag   = abs(X);
        phase = angle(X);

        magClean = mag - noiseMagEst;
        magClean = max(magClean, floorFactor*noiseMagEst);  % 防止负值

        Y    = magClean .* exp(1j*phase);
        ySeg = real(ifft(Y)) .* win;

        y(idx:idx+N-1) = y(idx:idx+N-1) + ySeg;
        idx = idx + hop;
    end

    y = y ./ (max(abs(y)) + 1e-8);
end

function w = local_hann(N)
    n = (0:N-1)';
    w = 0.5 - 0.5*cos(2*pi*n/(N-1));
end
