function y = Create_AM(Fc,Fmod,Mdept,SPL,Fs,N)
    wstep   = 2 * pi / Fs;
    x       = zeros(N,1);

    for n = 1:1:N;
        x(n) = (1 + (Mdept * sin(wstep * Fmod * n))) * ...
            sin(wstep * Fc * n);
    end

    y = x * From_dB(SPL - 103) / mean(rms(x));
end
