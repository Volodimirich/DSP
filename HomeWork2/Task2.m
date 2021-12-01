
sample_freq = 100 * 10^6;
nyquist_freq = sample_freq / 2;
ripple = 0.2;
stopband = 60;

passband = 20 * 10^6;
passband_normalized = passband / nyquist_freq;
stop_freq = 42 * 10^6;
stop_normalized = stop_freq / nyquist_freq;

order = cheb1ord(passband_normalized, stop_normalized, ripple, stopband);
% order = 4;

[b,a] = cheby1(order, ripple, 2*pi*passband, 'low', 's');
[bz,az] = impinvar(b,a,sample_freq);
[r,p] = residue(b,a);
t = linspace(0,40/sample_freq,1000);
h = real(r.'*exp(p.*t)/sample_freq);
figure(1);
plot(t,h);
hold;
impz(bz,az,[],sample_freq);
legend("Analog","Digital");
hold off;

 
figure(2);
[H,W] = freqz(bz,az);
F = linspace(0,sample_freq/2, length(W));
semilogy(F,abs(H))
hold on;
[H] = freqs(b,a,W*sample_freq);
semilogy(F,abs(H));
legend("Digital","Analog");
hold off;