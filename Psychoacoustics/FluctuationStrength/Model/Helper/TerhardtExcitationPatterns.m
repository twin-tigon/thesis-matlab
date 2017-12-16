function ei = TerhardtExcitationPatterns(x,fs)
% function ei = TerhardtExcitationPatterns(tempIn)
% 
% Calculates Terhardt excitation patterns.
% 
% Inputs:
% x: The input signal.
% 
% Outputs:
% ei: Excitation patterns.
% 
% Author: Rodrigo García

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % General parameters
    params = calculate_params(x,fs);

    % Transforms input signal to frequency domain
    x = fft(x)/params.N;
        
    % Use only samples that fall into the audible range
    Lg  = abs(x(params.qb));
    LdB = To_dB(Lg);

    % Use only components that are above the hearing threshold
    whichL = find(LdB > params.MinExcdB);
    nL     = length(whichL);

    % Steepness of slopes
    S1 = -27;			
    S2 = zeros(1,nL);
    for w = 1:nL;
        steep = -24 - (230 / params.freqs(whichL(w))) ...
            + (0.2 * LdB(whichL(w)));
        if steep < 0
            S2(w) = steep;
        end
    end

    whichZ      = zeros(2,nL);
    whichZ(1,:)	= floor(2 * params.Barkno(whichL + params.N01));
    whichZ(2,:)	= ceil(2 * params.Barkno(whichL + params.N01));

    % Calculate slopes from steep values
    Slopes = zeros(nL,params.Chno);
    for l = 1:nL
        Ltmp = LdB(whichL(l));
        Btmp = params.Barkno(whichL(l) + params.N01);

        for k = 1:whichZ(1,l)
            Stemp =	(S1 * (Btmp - (k * 0.5))) + Ltmp;
            if Stemp > params.MinBf(k)
                Slopes(l,k) = From_dB(Stemp);
            end
        end

        for k = whichZ(2,l):params.Chno
            Stemp = (S2(l) * ((k * 0.5) - Btmp)) + Ltmp;
            if Stemp > params.MinBf(k)
                Slopes(l,k) = From_dB(Stemp);
            end
        end 
    end

    % Excitation patterns
    ExcAmp  = zeros(nL,params.Chno);
    ei      = zeros(params.Chno,params.N);
    for k = 1:params.Chno
        etmp = zeros(1,params.N);
        for l = 1:nL
            N1tmp = whichL(l);
            N2tmp = N1tmp + params.N01;

            if whichZ(1,l) == k
                ExcAmp(N1tmp,k)	= 1;
            elseif whichZ(2,l) == k
                ExcAmp(N1tmp,k)	= 1;
            elseif whichZ(2,l) > k
                ExcAmp(N1tmp,k) = Slopes(l,k+1)/Lg(N1tmp);
            else % whichZ(1,l) < k
                ExcAmp(N1tmp,k) = Slopes(l,k-1)/Lg(N1tmp);
            end

            etmp(N2tmp) = ExcAmp(N1tmp,k)*x(N2tmp);
        end

        ei(k,:) = 2*params.N*real(ifft(etmp));
    end
    
    %% Helper functions
    function params = calculate_params(x,fs)
        params      = struct;
        params.N    = length(x);
        params.Chno = 47;
        
        % Defines audible range indexes and frequencies
        df           = fs/params.N;
        N0           = round(20/df)+1;
        Ntop         = round(20e3/df)+1;
        params.N01   = N0-1;
        params.qb    = N0:Ntop;
        params.freqs = (params.qb-1)*df;

        % Bark related parameters
        Bark          = get_Bark;
        Bark2         = get_Bark2(Bark);
        params.Barkno = calculate_Barkno(params.N,params.qb...
            ,params.freqs,Bark2);
        
        % Loudness threshold related parameters
        params.MinExcdB = calculate_MinExcdB(params.N01,params.qb...
            ,params.Barkno);
        params.MinBf    = calculate_MinBf(params.N01,df,Bark...
            ,params.MinExcdB);
    end

    function Bark = get_Bark
        Bark = [
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
    end

    function Bark2 = get_Bark2(Bark)
        Bark2 = [
            sort([Bark(:,2);Bark(:,3)]),... % frequencies
            sort([Bark(:,1);Bark(:,4)])     % Bark
        ];
    end
    
    function Barkno = calculate_Barkno(N,qb,freqs,Bark2)
        Barkno      = zeros(1,N/2+1);
        Barkno(qb)  = interp1(Bark2(:,1),Bark2(:,2),freqs);
    end
    
    function MinExcdB = calculate_MinExcdB(N01,qb,Barkno)
        HTres = [
            0		130
            0.01    70
            0.17    60
            0.8     30
            1       25
            1.5     20
            2		15
            3.3     10
            4		8.1
            5		6.3
            6		5
            8		3.5
            10		2.5
            12		1.7
            13.3	0
            15		-2.5
            16		-4
            17		-3.7
            18		-1.5
            19		1.4
            20		3.8
            21		5
            22		7.5
            23      15
            24      48
            24.5 	60
            25		130
        ];
     
        MinExcdB            = zeros(1,length(qb));
        MinExcdB(qb-N01)    = interp1(HTres(:,1),HTres(:,2),Barkno(qb));
    end

    function MinBf = calculate_MinBf(N01,df,Bark,MinExcdB)
        Cf = round(Bark(2:25,2)'/df)-N01+1;
        Bf = round(Bark(1:25,3)'/df)-N01+1;  

        zb      = sort([Bf Cf]);
        MinBf   = MinExcdB(zb);
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
