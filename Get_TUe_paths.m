function paths = Get_TUe_paths
    MATLAB_base         = ['/Users/rodrigo/Documents/MATLAB' delim];
    MATLAB_shared       = [MATLAB_base 'MATLAB_shared' delim];
    Psychoacoustics     = [MATLAB_shared 'Psychoacoustics' delim];

    paths.DSP                   = [MATLAB_shared 'DSP' delim];
%     paths.PsySound32            = [MATLAB_shared 'tb_PsySound32' delim];

    paths.FluctuationStrength   = [Psychoacoustics 'FluctuationStrength_Rodrigo' delim];
    paths.FluctuationStrength_TestTones = [paths.FluctuationStrength 'TestTones' delim];
end
