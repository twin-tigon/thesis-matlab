function r = Roughness(x,power_g,power_m,power_k)
    % General roughness parameters
    params = Get_roughness_params;
    
    % Blackman window
    window = blackman(params.N);
    ampCal = From_dB(80) * 2 / (params.N * mean(window));
    window = ampCal * window';
    
	% Excitation patterns
    tempIn  = window .* x';
    tempIn  = params.a0 .* fft(tempIn);
    Lg      = abs(tempIn(params.qb));
    LdB     = To_dB(Lg);
    whichL  = find(LdB > params.MinExcdB);
    nL      = length(whichL);
    
    % Steepness of slopes (Terhardt)
    S1 = -27;			
    S2 = zeros(1,nL);
    for w = 1:1:nL;
        steep = -24 - (230 / params.freqs(w)) + (0.2 * LdB(whichL(w)));
        if steep < 0
            S2(w) = steep;
        end
    end
    
    whichZ      = zeros(2,nL);
    qd          = 1:1:nL;
    whichZ(1,:)	= floor(2 * params.Barkno(whichL(qd) + params.N01));
    whichZ(2,:)	= ceil(2 * params.Barkno(whichL(qd) + params.N01));
    
    ExcAmp = zeros(nL,47);
    Slopes = zeros(nL,47);
    
    for k = 1:1:nL    
        Ltmp = LdB(whichL(k));
        Btmp = params.Barkno(whichL(k) + params.N01);
        
        for l = 1:1:whichZ(1,k)
            Stemp =	(S1 * (Btmp - (l * 0.5))) + Ltmp;
            if Stemp > params.MinBf(l)
                Slopes(k,l) = From_dB(Stemp);
            end
        end
        
        for l = whichZ(2,k):1:47
            Stemp = (S2(k) * ((l * 0.5) - Btmp)) + Ltmp;
            if Stemp > params.MinBf(l)
                Slopes(k,l) = From_dB(Stemp);
            end
        end 
    end
    
    ei      = zeros(47,params.N);
    Fei     = zeros(47,params.N);
    h0      = zeros(1,47);
    hBPi    = zeros(params.Chno,params.N);
    hBPrms  = zeros(1,params.Chno);
    mdept	= zeros(1,params.Chno);
    
    for k = 1:1:47
        etmp = zeros(1,params.N);
        
        for l = 1:1:nL
            N1tmp = whichL(l);
            N2tmp = N1tmp + params.N01;
            
            if whichZ(1,l) == k
                ExcAmp(N1tmp,k)	= 1;
            elseif whichZ(2,l) == k
                ExcAmp(N1tmp,k)	= 1;
            elseif whichZ(2,l) > k
                ExcAmp(N1tmp,k) = Slopes(l,k + 1) / Lg(N1tmp);
            else
                ExcAmp(N1tmp,k) = Slopes(l,k - 1) / Lg(N1tmp);
            end
            
            etmp(N2tmp) = ExcAmp(N1tmp,k) * tempIn(N2tmp);
        end
        
        ei(k,:)		= params.N * real(ifft(etmp));
        etmp		= abs(ei(k,:));
        h0(k)		= mean(etmp);
        Fei(k,:)	= fft(etmp - h0(k));
        hBPi(k,:)   = 2 * real(ifft(Fei(k,:) .* params.Hweight(k,:)));
        hBPrms(k)   = rms(hBPi(k,:));
        
        if h0(k) > 0
            mdept(k) =	hBPrms(k) / h0(k);
            if mdept(k) > 1
                mdept(k) = 1;
            end
        else
            mdept(k)=0;
        end
    end
    
    ki = zeros(1,params.Chno - 2);
    ri = zeros(1,params.Chno);
    
    % Find cross-correlation coefficients
    for k=1:1:45
        cfac    = cov(hBPi(k,:),hBPi(k + 2,:));
        den     = diag(cfac);
        den     = sqrt(den * den');
        
        if den(2,1) > 0
            ki(k) = cfac(2,1) / den(2,1);
        else
            ki(k) = 0;
        end
    end
    
    % Calculate specific roughness ri and total roughness R
    ri(1) = params.gzi(1)^power_g*mdept(1)^power_m*ki(1)^power_k;
    ri(2) = params.gzi(2)^power_g*mdept(2)^power_m*ki(2)^power_k;
    
    for k = 3:1:45
        ri(k) = params.gzi(k)^power_g*mdept(k)^power_m*(ki(k-2)*ki(k))^power_k;
    end
    
    ri(46) = params.gzi(46)^power_g*mdept(46)^power_m*ki(44)^power_k;
    ri(47) = params.gzi(47)^power_g*mdept(47)^power_m*ki(45)^power_k;

	r = params.Cal * sum(ri);
end