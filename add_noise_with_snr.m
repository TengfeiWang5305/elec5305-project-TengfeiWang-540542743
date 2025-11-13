function [xn, noise] = add_noise_with_snr(x, fs, noiseType, targetSNRdB)
% ADD_NOISE_WITH_SNR  Add different types of noise at a target global SNR.
%   noiseType: 'whitehum', 'babble', 'highfreq'

    x = x(:);
    N = length(x);

    switch lower(noiseType)
        case 'whitehum'
            t = (0:N-1)'/fs;
            hum   = 0.3 * sin(2*pi*60*t);
            white = 0.5 * randn(N,1);
            burst = zeros(N,1);
            nBurst = 3;
            for k = 1:nBurst
                startIdx = randi(max(N-fs,1));
                stopIdx  = min(startIdx + floor(fs/4), N);
                burst(startIdx:stopIdx) = 0.8*rand;
            end
            noise = hum + white + burst;

        case 'babble'
            % 多个随机延迟/增益的语音叠加 + 白噪声，模拟人声背景
            numTalkers = 6;
            noise = zeros(N,1);
            for k = 1:numTalkers
                gain  = 0.3 + 0.7*rand;
                delay = randi(round(0.5*fs));  % up to 0.5 s
                seg   = x;
                seg   = [zeros(delay,1); seg];
                seg   = seg(1:N);
                noise = noise + gain*seg;
            end
            noise = noise + 0.3*randn(N,1);

        case 'highfreq'
            % 高频嘶声：高通滤波白噪声（简单差分实现）
            white = randn(N,1);
            noise = white - [0; white(1:end-1)];  % 差分 → 强调高频
            noise = noise + 0.2*randn(N,1);

        otherwise
            error('Unknown noiseType: %s', noiseType);
    end

    % 调整噪声能量，达到目标 SNR
    Px           = sum(x.^2);
    Pn           = sum(noise.^2) + 1e-8;
    targetLinear = 10^(targetSNRdB/10);
    scale        = sqrt(Px / (Pn * targetLinear));
    noise        = scale * noise;

    xn = x + noise;
    xn = xn ./ (max(abs(xn)) + 1e-8);
end
