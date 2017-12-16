function fluc = FluctuationStrength(input,fs,N)
% function Fluctuation_strength
%
% Calculates the fluctuation strength value for a given time signal with a
% length greater than a frame.
%
% Inputs:
% input: The input signal vector.
% fs: the sampling frequency.
% N: the number of samples.
%
% Outputs:
% fluc: The fluctuation strength values for the given signal for each
% frame.
%
% Author: Rodrigo García

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if nargin < 1
        error('You must provide at least an input signal vector!');
    end

    if nargin < 2
        fs = 44100;
    end

    if nargin < 3
        N = 12*fs; % longest stimulus has a duration of 12 seconds
    end

    N = 2^nextpow2(N);

    % Repeats stimuli until frame length is achieved
    if length(input) < N
        input = repmat(input,ceil(N/length(input)),1);
        input = input(1:N);
    end

    % Multiframe separation
    overlap = 0.50;
    b       = buffer(input,N,N * overlap,'nodelay');
    nFrames = size(b,2);

    % Blackman window
    window = blackman(N);
    window = From_dB(100)*window/mean(window);

    fluc = zeros(1,nFrames);
    for iFrame = 1:nFrames
        % Apply window to frame
        x = window .* b(:,iFrame);

        %% Peripheral stages

        % Peripheral hearing system
        x = PeripheralHearingSystem(x',fs,N);

        % Excitation patterns
        [ei,Chno] = excitation_patterns(x,fs);

        %% Fluctuation strength calculation

        % Fluctuation strength model parameters
        params = Get_params(fs,Chno);

        % Modulation depth calculation
        [Md,hBPi] = modulation_depths(ei,params.Hweight);

        % Cross-correlation coefficients
        Ki = cross_correlation_coefficients(hBPi);

        % Specific fluctuations
        fi = specific_fluctuations(params.gzi,Md,Ki);

        % Adds total fluctuation strength value to results array
        fluc(iFrame) = params.Cal * sum(fi);
    end

    %% Helper functions

    function [ei,Chno] = excitation_patterns(x,fs)
        ei = auditoryfilterbank(x,fs,'flow',20,'fhigh',20e3);
        ei = squeeze(ei);
        
        [~,Chno] = size(ei);
    end
    
    function [mdept,hBPi] = modulation_depths(ei,Hweight)
        [Nc,chno] = size(ei);

        h0     = zeros(1,chno);
        hBPi   = zeros(chno,Nc);
        hBPrms = zeros(1,chno);
        mdept  = zeros(1,chno);

        for k = 1:chno
            etmp      = abs(ei(:,k));
            h0(k)     = mean(etmp);
            hBPi(k,:) = filter(Hweight,etmp-h0(k));
            hBPrms(k) = rms(hBPi(k,:));

            if h0(k) > 0
                mdept(k) = hBPrms(k)/h0(k);
                if mdept(k) > 1
                    mdept(k) = 1;
                end
            else
                mdept(k) = 0;
            end
        end
    end

    function ki = cross_correlation_coefficients(hBPi)
        [chno,~] = size(hBPi);

        ki = zeros(1,chno-2);
        for k=1:chno-2
            cfac = cov(hBPi(k,:),hBPi(k+2,:));
            den  = diag(cfac);
            den  = sqrt(den*den');

            if den(2,1) > 0
                ki(k) = cfac(2,1)/den(2,1);
            else
                ki(k) = 0;
            end
        end
    end

    function fi = specific_fluctuations(Gzi,Md,Ki)
        chno = length(Gzi);

        fi = zeros(1,chno);

        for k = 1:chno
            gzi = Gzi(k);
            md  = Md(k);

            if k == chno-1 || k == chno
                ki = 1;
            else
                ki = Ki(k);
            end

            if k == 1 || k == 2
                ki2 = 1;
            else
                ki2 = Ki(k-2);
            end

            fi(k) = (gzi*md*ki*ki2)^2;
        end
    end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
