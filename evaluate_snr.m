function snrDb = evaluate_snr(clean, est)
% EVALUATE_SNR  Compute global SNR between clean and estimate.

    clean = clean(:);
    est   = est(:);

    L = min(length(clean), length(est));
    clean = clean(1:L);
    est   = est(1:L);

    noise = clean - est;

    Px = sum(clean.^2);
    Pn = sum(noise.^2) + 1e-8;

    snrDb = 10*log10(Px / Pn);
end
