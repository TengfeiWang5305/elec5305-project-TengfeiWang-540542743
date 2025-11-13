function [x, fs] = generate_synthetic_speech()
% GENERATE_SYNTHETIC_SPEECH
% Create a simple speech-like signal using sums of sinusoids
% and amplitude envelopes.

    fs  = 16000;
    dur = 4;                     % seconds
    t   = (0:1/fs:dur-1/fs)';

    % 两段"类语音"片段，模拟不同元音/音高
    f0_1 = 120;                  % segment 1 基频
    f0_2 = 180;                  % segment 2 基频

    env1 = 0.5 * (1 + sin(2*pi*0.8*t));
    env2 = 0.5 * (1 + sin(2*pi*0.5*t + 1));

    seg1 = env1 .* ( ...
           sin(2*pi*f0_1*t) + ...
           0.5*sin(2*pi*2*f0_1*t) + ...
           0.3*sin(2*pi*3*f0_1*t));

    seg2 = env2 .* ( ...
           sin(2*pi*f0_2*t) + ...
           0.5*sin(2*pi*2*f0_2*t) + ...
           0.3*sin(2*pi*3*f0_2*t));

    x = [seg1(1:floor(length(t)/2)); seg2(floor(length(t)/2)+1:end)];
    x = x ./ (max(abs(x)) + 1e-8);   % 归一化，防止爆音
end
