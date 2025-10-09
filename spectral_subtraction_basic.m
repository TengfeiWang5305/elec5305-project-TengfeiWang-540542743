function y = spectral_subtraction_basic(xn, fs)
% Simple spectral subtraction
% === Ensure Hann window is available ===
if ~exist('hann','file')
    hann = @(N)(0.5 - 0.5*cos(2*pi*(0:N-1)'/(N-1)));
end

N = 1024; hop = N/2; win = hann(N);
y = zeros(size(xn));
for i=1:hop:length(xn)-N
    frame = xn(i:i+N-1).*win;
    X = fft(frame);
    mag = abs(X); phase = angle(X);
    noise_est = 0.05*mean(mag);
    mag_clean = max(mag - noise_est, 0);
    Y = mag_clean .* exp(1j*phase);
    y(i:i+N-1) = y(i:i+N-1) + real(ifft(Y)).*win;
end
y = y / max(abs(y));
end
