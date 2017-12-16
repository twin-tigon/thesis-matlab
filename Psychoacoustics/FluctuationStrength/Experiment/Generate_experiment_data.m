function Generate_experiment_data(specs)
% function Generate_experiment_data(specs)
% 
% Processes APEX results files data.
% 
% Inputs:
% specs: The specifications to use.
% 
% Author: Rodrigo García

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if nargin == 0
        specs = Get_specs;
    end
    
    results_path = [Get_path('APEX_result') 'experiment/'];
    output_path  = Get_path('FluctuationStrength_Experiment_Data');
    cellfun(@(x)process_spec(x,results_path,output_path),specs);
    
    %% Helper functions
    
    function process_spec(spec,results_path,output_path)
        % Gets all results filenames
        filenames = struct2cell(dir([results_path spec.name '*.apr']));
        filenames = filenames(1,:);
        
        group_answers = {};
        
        for n = 1:length(filenames)
            results = Get_results_from_APEX_file(...
                [results_path filenames{n}]);
            answers = Get_answers_from_APEX_results(results);
            adjust_and_save(answers,spec,output_path...
                ,filenames{n}(1:end-4));
            
            group_answers = [group_answers;answers];
        end
        
        adjust_and_save(group_answers,spec,output_path,spec.name);
    end

    function adjust_and_save(orig_answers,spec,output_path,filename)
        answers  = adjust_answers(orig_answers,spec);
        filename = [output_path filename '.mat'];
        Delete(filename);
        save(filename, 'answers');
    end

    function normalized = adjust_answers(answers,spec)
        factor     = get_adjustment_factor(answers,spec);
        adjusted   = adjust_second_standard(answers,factor);
        normalized = normalize_answers(adjusted,spec.n_stimuli);
    end

    function factor = get_adjustment_factor(answers,spec)
        m1 = median(Extract_values(...
            Cellfilter(answers,@(x)x.std==1&&x.stim==spec.std1)));
        m2 = median(Extract_values(...
            Cellfilter(answers,@(x)x.std==2&&x.stim==spec.std1)));
        
        factor = m1/m2;
    end

    function answers = adjust_second_standard(answers,factor)
        for n = 1:length(answers)
            if answers{n}.std == 2
                answers{n}.val = answers{n}.val * factor;
            end
        end
    end

    function normalized = normalize_answers(answers,n)
        vals_1 = Get_values_per_level(Cellfilter(answers,@(x)x.std==1),n);
        [m1,~] = Extract_stats(vals_1);
        vals_2 = Get_values_per_level(Cellfilter(answers,@(x)x.std==2),n);
        [m2,~] = Extract_stats(vals_2);
        
        m = (m1+m2)*0.5;
        
        max_m = max(m);
        for n_a = 1:length(answers)
            answers{n_a}.val = 100 * answers{n_a}.val / max_m;
        end
        
        normalized = answers;
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end