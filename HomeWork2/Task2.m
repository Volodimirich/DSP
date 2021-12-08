
Fs = 100 * 10^6;
Fmax = sample_freq / 2;
Rp = 0.2;
Rs = 60;

Fp = 20 * 10^6;
Wp = Fp / Fmax;
% Not fixed value
Fs = 27 * 10^6;
Ws = Fs / Fmax;

n = cheb1ord(Wp, Ws, Rp, Rs);
% order = 4;

[b,a] = cheby1(n, Rp, 2*pi*Fcut, 'low', 's');
[bz,az] = impinvar(b,a,sample_freq);
[r,p] = residue(b,a);

t = linspace(0,40/Fs,1000);
h = real(r.'*exp(p.*t)/Fs);
figure(1);
plot(t,h);
hold;
impz(bz,az,[],Fs);
legend("Analog","Digital");
hold off;

 
figure(2);
[H,W] = freqz(bz,az);
F = linspace(0,Fmax, length(W));
semilogy(F,abs(H))
hold on;
[H] = freqs(b,a,W*sample_freq);
semilogy(F,abs(H));
legend("Digital","Analog");
hold off;
