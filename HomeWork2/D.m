Fpass = 4e6;
Fstop = 6e6;
Fs = 20e6;
Attenuation = 40;
n = 30;
h = fir1(n,2*Fpass/Fs, blackman(n+1));
% h = firpm(n, [0, 0.4, 0.6, 1], [1, 1, 0, 0]);
h_rounded = zeros(1, length(h));
h_rounded_next = zeros(1, length(h));
h_rounded_last = zeros(1, length(h));


for tap = 1:length(h)
    if h(tap) > 0
        cur = h(tap);
        binary = de2bi(cur);
        disp(binary)

        inv_tap = 1/h(tap);
        pow = nextpow2(inv_tap);
        h_rounded_next(tap) = 1/2^pow;
        pow = pow - 1;
        h_rounded_last(tap) = 1/2^pow;
        if (abs(h(tap) - h_rounded_last(tap)) > abs(h(tap) - h_rounded_next(tap)))
            h_rounded(tap) = h_rounded_next(tap);
            disp('next')
        else
            h_rounded(tap) = h_rounded_last(tap);
            disp('last')
        end
    else
        inv_tap = abs(1/h(tap));
        pow = nextpow2(inv_tap);
        h_rounded_next(tap) = -1/2^pow;
        pow = pow - 1;
        h_rounded_last(tap) = -1/2^pow;
        if (abs(h(tap) - h_rounded_last(tap)) > abs(h(tap) - h_rounded_next(tap)))
            h_rounded(tap) = h_rounded_next(tap);
        else
            h_rounded(tap) = h_rounded_last(tap);
        end
    end
end

fvtool(h, 1, h_rounded, 1)