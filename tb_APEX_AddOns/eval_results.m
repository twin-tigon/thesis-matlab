function [histos, stimuli, buttons, corrector, nEachTrial, roving] = eval_results(filenames, bDiscard, strategies)
% function [histos, stimuli, buttons, corrector, nEachTrial, roving] = eval_results(filenames, bDiscard, strategies)
%
% Evaluates Apex3 results on Musical Instrument Pitch Ranking experiment. 
% The result-filename is put together as follows: 
% MIPR_F0{which_F0, e.g. C3}_results_{strategy, e.g. ACE}-{which_experiment, e.g. 1}.xml
%
% Inputs:
%   path:      Path to result files
%   filenames: Cell-array containing filenames of result-files (order: F0mod, ACE, ACE512, F0ace)
%
% Outputs:
%   [histos{1,1}{1,1} histos{2,1}{1,1}] - results for ACE and F0mod,
%   respectively
%   nEachTrial: Number of presentations per trial (total trials / 4)
%
% % Example:
%   bDiscard = 0;
%   result_dir = '/home/alejandro/Documenten/Meas/Meas/Experiments/Results_XML/';
%   result_files = {[result_dir 'ci-Romain_Peeters/20130924-PR/PR_Ref_208_UW_ACE-LB-ACE-RP-trunc.apr'], ... 
%                   [result_dir 'ci-Romain_Peeters/20130924-PR/PR_Ref_208_UW_F0m-LB-F0m-RP-trunc.apr']}; 
%	[histos, stimuli, buttons, corrector, TimesPresented] = eval_results(result_files, bDiscard);
%
% Programmed by Matthias, revised by Alejandro
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin == 0
	return;
end

nExperiments = size(filenames, 2); % Number of result files = number of strategies

stimuli     = cell(nExperiments, 1);
buttons     = cell(nExperiments, 1);
correctors  = cell(nExperiments, 1);
roving      = cell(nExperiments, 1);
histos      = cell(nExperiments, 1);

for i=1:nExperiments
    try
        [stimuli{i, 1}, buttons{i, 1}, corrector{i, 1}, xx, parsed_results] = a3cstresults(filenames{i});
        if isfield(parsed_results, 'randomrove')
            roving_aux = [];
            for k = 1:length(parsed_results)
                roving_aux      = [roving_aux; str2num(parsed_results(k).randomrove)];
            end
            roving{i,1} = roving_aux;
        end
    catch
        warning('one or more APEX result files were not found');
    end
    stimuli{i} = stimuli{i, 1}(1+bDiscard:end);
    for j=1:length(stimuli{i})
        tmp = strread(stimuli{i}{j}, '%s', 'delimiter', '_');
        try
            stimuli{i}{j} = [tmp{1} '_' tmp{2} tmp{3} '_' tmp{4}];
        catch
            stimuli{i}{j} = [tmp{1}]; % new PR format - since october 2013
        end
    end
    
    corrector{i, 1} = corrector{i, 1}(1+bDiscard:end);
    buttons{i, 1} = buttons{i, 1}(1+bDiscard:end);
    
    % Generates the histogram for each result file:
    histos{i} = process_stimuli_exp(stimuli{i, 1}, corrector{i, 1}, '_', {'stimulus'}); 
    
end

disp([mfilename '.m: APEX files read: '])
try
    disp(['    ' filenames{1}])
    disp(['    ' filenames{2}])
end

correct_histo = 0;

for i=1:length(histos)

    if(size(histos{i}, 1) == 3)
        hn{i}{1} = histos{i}{1};
        hn{i}{2} = histos{i}{2};
        correct_histo = 1;
    elseif(size(histos{i}, 1) == 4)
        hn{i}{1} = histos{i}{1};
        hn{i}{2} = histos{i}{3};
        correct_histo = 1;
    end
end

if(correct_histo)
    histos = hn;
    histos = histos';
    histos{1} = histos{1}';
    histos{2} = histos{2}';
end

nEachTrial = length( stimuli{1} ) / 4;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end