function [x, fs] = generate_synthetic_speech()
% Generate pseudo-speech by combining sinusoids + envelope modulation
fs = 16000; t = 0:1/fs:3; % 3 seconds
env = 0.5*(1+sin(2*pi*1*t));
x = env .* (sin(2*pi*220*t) + 0.3*sin(2*pi*440*t) + 0.2*sin(2*pi*660*t));
x = x' / max(abs(x));
end
