function histos = process_stimuli_exp(stimuli, corrector, delimiter, to_disg)
% function histos = process_stimuli_exp(stimuli, corrector, delimiter, to_disg)
%
% Inputs:
%   stimuli
%   corrector
%   delimiter (usually '_')
%   to_disg (usually 'stimulus')
%
% Programmed by Matthias, revised by Alejandro
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nargin == 0)
    return;
end

%% Some setup things

num_stim    = length(stimuli); % number of trials
result_cell = strread(stimuli{1}, '%s', 'delimiter', delimiter); 
num_params  = length(result_cell) - length(to_disg); % disgard stimulus keyword, maybe stupid constrain
                   % result_cell and to_disg are stored as cell variables
if num_params == 0
    num_params = 1; % for new PR format, since october 2013
end

if(~isempty(to_disg))
    result_cell = remove_cell_entries(result_cell, to_disg); % result_cell from 'stimulus C3 4' to 'C3 4'
end

%% Create output cells
for i=1:num_params
   expression = ['param_hist' num2str(i) ' = cell(0,2);']; % create variable param_hist1 and param_hist2
   eval(expression);   
end

histos = cell(num_params,1);

%%
for i=1:num_stim
    result_cell = strread(stimuli{i}, '%s', 'delimiter', delimiter);
    if size(result_cell,1) == 1 % then stimulus is in format 'stimulus1'
        result_cell{2} = result_cell{1,1}(end); % '1' for 1 semitone
                                                % '2' for 2 semitones
                                                % '3' for 3 semitones
                                                % '4' for 4 semitones
    end
    tmp_result  = corrector(i);
    for j=1:num_params  % j = 1 histogram per semitone
                        % j = 2 histogram per roving (assuming 'stimulus_C3_7' format)
        param = result_cell{j+1};
        num_param_str = num2str(j);
        expression = ['contains_param(param_hist' num_param_str ', param);'];
        pos = eval(expression);
        switch pos
            case -1     % answer ~= correct
                expression = ['param_hist' num_param_str '{end+1,1} = param;'];
                eval(expression);
                expression1 = ['if(isempty(param_hist' num_param_str '{end,2})) param_hist' num_param_str '{end,2} = 0; end; '];
                expression2 = ['param_hist' num_param_str '{end,2} = param_hist' num_param_str '{end,2} + tmp_result;'];
                main_expression = [expression1, expression2];
                eval(main_expression);
            otherwise   % answer == correct
                expression1 = ['if(isempty(param_hist' num_param_str '{pos,2})) param_hist' num_param_str '{pos,2} = 0; end; '];
                expression2 = ['param_hist' num_param_str '{pos,2} = param_hist' num_param_str '{pos,2} + tmp_result;'];
                main_expression = [expression1, expression2];
                eval(main_expression);
        end
    end
end

for i=1:num_params
   num_param_str = num2str(i);
   expression = ['histos{' num_param_str '} = param_hist' num_param_str ';']; 
   eval(expression);
   % histos{1} = param_hist1;
   % histos{2} = param_hist2;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function pos = contains_param(param_cell, param)
% function pos = contains_param(param_cell, param)
%
% returns position of string or -1 when not found

if(size(param_cell, 1) == 0)
    pos = -1;
    return;
end

for i=1:size(param_cell, 1)   
   if(strcmp(param_cell{i,1}, param))
      pos = i;
      return;
   else
       pos = -1;
   end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function out_cell = remove_cell_entries(in_cell, to_disg)

for i=1:size(in_cell,1)
    for j=1:size(to_disg,1);
        if(strcmp(in_cell{i}, to_disg{j}))
           in_cell{i} = []; 
        end
    end
end

out_cell = cell(0);

for i=1:size(in_cell, 1)
    if(~isempty(in_cell{i}))
        out_cell{end+1} = in_cell{i};
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
