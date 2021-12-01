clock_freq = 20;
nyquist_freq = clock_freq / 2;
b = [0, 1, 2.5];
a = [1, 2.5, 4];
bz = [0.0249, 0.0029, -0.022];
az = [1, -1.8732, 0.8826];
[freq_resp, ang_resp] = freqz(bz,az);
x_vals = linspace(0, nyquist_freq, length(freq_resp));

figure(1);
semilogy(x_vals,abs(freq_resp))
hold on;
[H] = freqs(b,a, ang_resp*clock_freq);
semilogy(x_vals,abs(H))

legend("Digital", "Analog")
hold off;

fvtool(bz, az)
