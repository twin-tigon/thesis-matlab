function y = PeripheralHearingSystem(x,fs,N)
% function y = PeripheralHearingSystem(x,fs,N)
% 
% Applies the effect of transmission from free field to the cochlea to a
% given signal.
% 
% Inputs:
% x: The signal to process.
% fs: Sampling frequency,
% N: number of samples.
% 
% Author: Rodrigo García

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    a0 = calculate_a0(fs,N);
    y  = 2*real(ifft(a0.*fft(x)));
    
    %% Helper functions
    
    function a0 = calculate_a0(fs,N)
        % Defines audible range indexes and frequencies
        df    = fs/N;
        N0    = round(20/df)+1;
        Ntop  = round(20e3/df)+1;
        qb    = N0:Ntop;
        freqs = (qb-1)*df;
        
        Bark = get_Bark(N,qb,freqs);
        
        a0tab = [
            0       0
            10      0
            12      1.15
            13      2.31
            14      3.85
            15      5.62
            16      6.92
            16.5    7.38
            17      6.92
            18      4.23
            18.5    2.31
            19      0
            20      -1.43
            21		-2.59
            21.5	-3.57
            22		-5.19
            22.5	-7.41
            23		-11.3
            23.5	-20
            24		-40
            25		-130
            26		-999
        ];
        
        a0            = zeros(1,N);
        a0(qb)        = From_dB(interp1(a0tab(:,1),a0tab(:,2),Bark(qb)));
        a0(isnan(a0)) = 0;
    end

    function Bark = get_Bark(N,qb,freqs)
        Bark_table = [
            0   0       50      0.5
            1   100     150     1.5
            2   200     250     2.5
            3   300     350     3.5
            4   400     450     4.5
            5   510     570     5.5
            6   630     700     6.5
            7   770     840     7.5
            8   920     1000	8.5
            9   1080	1170	9.5
            10  1270	1370	10.5
            11  1480	1600	11.5
            12  1720	1850	12.5
            13  2000	2150	13.5
            14  2320	2500	14.5
            15  2700	2900	15.5
            16  3150	3400	16.5
            17  3700	4000	17.5
            18  4400	4800	18.5
            19  5300	5800	19.5
            20  6400	7000	20.5
            21  7700	8500	21.5
            22  9500	10500	22.5
            23  12000	13500	23.5
            24  15500   20000   24.5
        ]; 
    
        Bark_sorted = [
            sort([Bark_table(:,2);Bark_table(:,3)]),... % frequencies
            sort([Bark_table(:,1);Bark_table(:,4)])     % Bark
        ];
    
        Bark     = zeros(1,N/2+1);
        Bark(qb) = interp1(Bark_sorted(:,1),Bark_sorted(:,2),freqs);
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
