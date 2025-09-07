# elec5305-project-TengfeiWang-540542743
5305 project
%% Custom STFT
function [S,f,t] = mySTFT(x, win, hop, nfft, fs)
    x = x(:);
    N = length(x);
    nwin = length(win);
    nseg = floor((N-nwin)/hop)+1;
    S = zeros(nfft, nseg);
    for k = 1:nseg
        idx = (1:nwin)+(k-1)*hop;
        seg = x(idx).*win;
        S(:,k) = fft(seg, nfft);
    end
    t = ((0:nseg-1)*hop + nwin/2)/fs;
    f = (0:nfft-1)/nfft*fs;
end

%% Custom iSTFT (OLA)
function y = myISTFT(S, win, hop)
    nfft = size(S,1);
    nwin = length(win);
    nseg = size(S,2);
    ylen = hop*(nseg-1)+nwin;
    y = zeros(ylen,1);
    for k=1:nseg
        grain = real(ifft(S(:,k), nfft));
        grain = grain(1:nwin).*win;
        idx = (1:nwin)+(k-1)*hop;
        y(idx) = y(idx)+grain;
    end
end
