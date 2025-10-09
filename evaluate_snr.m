function snrValue = evaluate_snr(x_ref, x_test)
% Compute SNR in dB
snrValue = 10*log10(sum(x_ref.^2)/sum((x_ref-x_test).^2 + 1e-10));
end
