function [xn, noise] = add_noise_simulation(x, fs)
% Mix clean speech with multiple noise types
t = (0:length(x)-1)/fs;
white = 0.3*randn(size(x));
urban = 0.2*sin(2*pi*60*t)' + 0.1*randn(size(x));
burst = zeros(size(x)); idx = randi(length(x)-fs,3,1);
for i=1:3, burst(idx(i):idx(i)+fs/4)=0.5*rand; end
noise = white + urban + burst;
xn = x + noise; xn = xn / max(abs(xn));
end
