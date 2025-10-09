function y = adaptive_hybrid_filter(xn, fs)
% Combine Wiener and Spectral Subtraction adaptively
% === Ensure Hann window is available ===
if ~exist('hann','file')
    hann = @(N)(0.5 - 0.5*cos(2*pi*(0:N-1)'/(N-1)));
end
N = 1024; hop = N/2; win = hann(N);
y = zeros(size(xn));
for i=1:hop:length(xn)-N
    frame = xn(i:i+N-1).*win;
    X = fft(frame); P = abs(X).^2;
    snr_est = 10*log10(mean(P)/var(P));
    alpha = 1/(1+exp(-0.3*(snr_est-5)));
    % Wiener component
    Pn = 0.02*mean(P); H_w = max((P - Pn)./P, 0.1);
    % Spectral subtraction
    noise_est = 0.05*mean(abs(X)); mag_clean = max(abs(X)-noise_est,0);
    Y_spec = mag_clean .* exp(1j*angle(X));
    % Combine
    Y = alpha.*(H_w.*X) + (1-alpha).*Y_spec;
    y(i:i+N-1) = y(i:i+N-1) + real(ifft(Y)).*win;
end
y = y / max(abs(y));
end
