function y = wiener_filter_basic(xn, fs)
% Basic Wiener filtering
if ~exist('hann','file')
    hann = @(N)(0.5 - 0.5*cos(2*pi*(0:N-1)'/(N-1)));
end
N = 1024; hop = N/2; win = hann(N);
y = zeros(size(xn));
for i=1:hop:length(xn)-N
    frame = xn(i:i+N-1).*win;
    X = fft(frame);
    P = abs(X).^2;
    Pn = 0.02*mean(P);
    H = max((P - Pn)./P, 0.1);
    Y = H .* X;
    y(i:i+N-1) = y(i:i+N-1) + real(ifft(Y)).*win;
end
y = y / max(abs(y));
end
