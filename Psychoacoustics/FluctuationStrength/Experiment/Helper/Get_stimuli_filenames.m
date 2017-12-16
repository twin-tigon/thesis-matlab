function filenames = Get_stimuli_filenames(spec,N)
% function filenames = Get_stimuli_filenames(spec)
% 
% Returns stimuli filenames.
% 
% Author: Rodrigo García

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    tone    = spec.tone;
    params  = spec.params;

    FMs     = params.FMs;
    SPLs    = params.SPLs;
    Ws      = params.Ws;
    FSs     = params.FSs;
    
    if nargin == 1
        N = 0;
    end
    
    % Ugly hack for AM BBN stimuli
    if strcmp(tone,'AM_BBN')
        FCs = -1;
    else
        FCs = params.FCs;
    end
    
    if strcmp(tone,'FM')
        MDDFs = params.DFs;
    else
        MDDFs = params.MDs;
    end

    filenames = cell( ...
        length(FMs) ...
        * length(FCs) ...
        * length(MDDFs) ...
        * length(SPLs) ...
        * length(Ws) ...
        * length(FSs) ...
    ,1);

    iFile = 1;
    for iFM = 1:length(FMs)
        for iFC = 1:length(FCs)
            for iMDDF = 1:length(MDDFs)
                for iSPL = 1:length(SPLs)
                    for iW = 1:length(Ws)
                        for iFS = 1:length(FSs)
                            filenames{iFile,1} = ...
                                Get_filename_from_params( ...
                                    Get_filename_write_format(tone), ...
                                    FMs(iFM), ...
                                    FCs(iFC), ...
                                    MDDFs(iMDDF), ...
                                    SPLs(iSPL), ...
                                    Ws(iW), ...
                                    FSs(iFS), ...
                                    N ...
                                );
                            iFile = iFile+1;
                        end
                    end
                end
            end
        end
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
end
