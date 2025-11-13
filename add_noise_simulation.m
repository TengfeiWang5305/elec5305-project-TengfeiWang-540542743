function [xn, noise] = add_noise_simulation(x, fs)
% ADD_NOISE_SIMULATION
% Simple mixed-noise simulation: white + low-frequency hum + bursts.

    x = x(:);
    N = length(x);

    t    = (0:N-1)' / fs;
    hum  = 0.3 * sin(2*pi*60*t);       % 低频电流噪声
    w    = 0.3 * randn(N,1);          % 白噪声

    burst  = zeros(N,1);              % 三个短时突发噪声
    nBurst = 3;
    for k = 1:nBurst
        startIdx = randi(N-fs);
        burst(startIdx:startIdx+floor(fs/4)) = 0.5*rand;
    end

    noise = hum + w + burst;

    % 设定目标 SNR ≈ 5 dB
    targetSNRdB  = 5;
    Px           = sum(x.^2);
    Pn           = sum(noise.^2);
    targetLinear = 10^(targetSNRdB/10);
    scale        = sqrt(Px / (Pn * targetLinear));
    noise        = scale * noise;

    xn = x + noise;
    xn = xn ./ (max(abs(xn)) + 1e-8);
end
