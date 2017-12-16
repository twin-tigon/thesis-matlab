function results = Get_results_from_APEX_file(filename)
% function Get_results_from_APEX_file
% 
% Extracts results from an APEX experiment results file.
% 
% Inputs:
% filename: The file to process.
% 
% Outputs:
% results: The extracted results.
% 
% Author: Rodrigo García

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    [results,~] = a3getresults(filename);
    results = results(...
        find(strcmp('START',results)) + 1 : ...
        find(strcmp('END',results)) - 1 ...
    );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
