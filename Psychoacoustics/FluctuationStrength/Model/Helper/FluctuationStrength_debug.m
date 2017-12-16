function fluc = FluctuationStrength_debug(x,s_p,m_p)
% function Fluctuation_strength
%
% Fluctuation strength model debug version.
%
% Inputs:
% x: The input signal vector.
% s_p: Stimulus parameters.
% m_p: Model parameters.
%
% Outputs:
% fluc: The fluctuation strength values for the given signal
%
% Author: Rodrigo Garc?a

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    ei        = peripheral_stage(x,m_p.fs,m_p.N);
    [Md,hBPi] = modulation_depths_stage(ei,m_p.Hweight);
    Ki        = cross_correlation_coefficients_stage(hBPi);
    fi        = specific_fluctuations(Md,Ki,m_p.gzi,m_p.p_g,m_p.p_m,m_p.p_k);
    
    fluc = m_p.cal * sum(fi);

    %% Helper functions
    
    function ei = peripheral_stage(x,fs,N)
        switch m_p.debug
            case 'none'
                ei = peripheral(x,fs,N);
            case 'md'
                data = load(get_param_filename('ei'));
                ei   = data.ei;
                return
            case 'fi'
                ei = 0;
                return
        end
    end

    function [mdept,hBPi] = modulation_depths_stage(ei,Hweight)
        if strcmp(m_p.debug,'fi')
            data  = load(get_param_filename('md'));
            mdept = data.mdept;
            hBPi  = data.hBPi;
            return
        else
            [mdept,hBPi] = modulation_depths(ei,Hweight);
        end
    end

    function ki = cross_correlation_coefficients_stage(hBPi)
        if strcmp(m_p.debug,'fi')
            data = load(get_param_filename('ki'));
            ki   = data.ki;
            return
        else
            ki = cross_correlation_coefficients(hBPi);
        end
    end

    function ei = peripheral(x,fs,N)
        % Blackman window
        window = blackman(N);
        window = From_dB(100)*window/mean(window);

        % Apply window to frame
        x = window .* x';

        %% Peripheral stages

        % Peripheral hearing system
        x = PeripheralHearingSystem(x',fs,N);
        
        % Excitation patterns
        ei = TerhardtExcitationPatterns(x,fs);

        filename = get_param_filename('ei');
        Delete(filename);
        save(filename,'ei');
    end

    function [mdept,hBPi] = modulation_depths(ei,Hweight)
        [chno,Nc] = size(ei);

        h0     = zeros(1,chno);
        hBPi   = zeros(chno,Nc);
        hBPrms = zeros(1,chno);
        mdept  = zeros(1,chno);

        for k = 1:chno
            etmp      = abs(ei(k,:));
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
        
        if ~strcmp(m_p.debug,'md')
            filename = get_param_filename('md');
            Delete(filename);
            save(filename,'mdept','hBPi');
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
        
        if ~strcmp(m_p.debug,'md')
            filename = get_param_filename('ki');
            Delete(filename);
            save(filename,'ki');
        end
    end

    function fi = specific_fluctuations(Md,Ki,Gzi,p_g,p_m,p_k)
        chno = length(Gzi);

        fi = zeros(1,chno);
        
        for k = 1:chno
            gzi = Gzi(k);
            
            md = Md(k)-0.1;
            if md < 0
                md = 0;
            end

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
            kp = abs(ki*ki2);

            fi(k) = gzi^p_g*md^p_m*kp^p_k;
        end
    end

    function filename = get_param_filename(param)
        if strcmp(s_p.tone,'AM')
            filename = [
                Get_path('FluctuationStrength_Model_Data') ...
                sprintf('%s_%s_fm-%.3f_fc-%i_SPL-%i_md-%i.mat'...
                    ,param,s_p.tone,s_p.fm,s_p.fc,s_p.SPL,s_p.md)
            ];
        elseif strcmp(s_p.tone,'FM')
            filename = [
                Get_path('FluctuationStrength_Model_Data') ...
                sprintf('%s_%s_fm-%.3f_fc-%i_SPL-%i_df-%i.mat'...
                    ,param,s_p.tone,s_p.fm,s_p.fc,s_p.SPL,s_p.df)
            ];
        end
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
