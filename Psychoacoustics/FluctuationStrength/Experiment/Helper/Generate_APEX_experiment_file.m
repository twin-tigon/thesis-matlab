function Generate_APEX_experiment_file(spec)
% function Generate_APEX_experiment_file
% 
% Generates an APEX experiment file from an experiment specification.
% 
% Author: Rodrigo García

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    stim = Get_stimuli_filenames(spec.tone,spec.params);
    stds = Get_standards_filenames(spec.stds,spec.tone);
    
    experiment_filename = [Get_path('APEX_experiment') spec.name '.apx'];
    template_filename   = 'template.apx';
    
    if exist(experiment_filename, 'file')
        fprintf('File %s already exists, skipping...\n', ...
            experiment_filename);
        return;
    end

    experiment = xmlread(template_filename);
    
    description = experiment.getElementsByTagName('description').item(0);
    description.setTextContent(spec.desc);
    
    ids = add_datablocks(experiment,stds,stim);
    add_stimuli(experiment,ids);
    add_procedures(experiment,length(stds),length(stim));
    
    xmlwrite(experiment_filename,experiment);
    
    % Helper functions
    function ids = add_datablocks(doc,stds,stim)
        ids         = cell(length(stds)+length(stim),1);
        datablocks  = doc.getElementsByTagName('datablocks').item(0);
        
        for iStd = 1:length(stds)
            id = ['datablockref' num2str(iStd)];
            ids{iStd,1} = id;
            
            datablock = create_datablock(doc,stds{iStd});
            datablock.setAttribute('id',id);
            datablocks.appendChild(datablock);
        end
        
        for iStim = 1:length(stim)
            id = ['datablock' num2str(iStim)];
            ids{length(stds)+iStim,1} = id;
            
            datablock = create_datablock(doc,stim{iStim});
            datablock.setAttribute('id',id);
            datablocks.appendChild(datablock);
        end
    end

    function datablock = create_datablock(doc,filename)
        device = doc.createElement('device');
        device.setTextContent('wavdevice');
        uri = doc.createElement('uri');
        uri.setTextContent(filename);
        
        datablock = doc.createElement('datablock');
        datablock.appendChild(device);
        datablock.appendChild(uri);
    end

    function add_stimuli(doc,ids)
        stimuli = doc.getElementsByTagName('stimuli').item(0);
        
        for iId = 1:length(ids)
            stimulus = create_stimulus(doc,ids{iId});
            stimulus.setAttribute('id',['stim' ids{iId}(10:end)]);
            stimuli.appendChild(stimulus);
        end
    end

    function stimulus = create_stimulus(doc,id)
        stimulus    = doc.createElement('stimulus');
        datablock   = doc.createElement('datablock');
        sequential  = doc.createElement('sequential');
        datablocks  = doc.createElement('datablocks');
        
        datablock.setAttribute('id',id);
        
        sequential.appendChild(datablock);
        datablocks.appendChild(sequential);
        stimulus.appendChild(datablocks);
    end

    function add_procedures(doc,nStds,nStim)
        procedures = doc.getElementsByTagName('procedure').item(0);
        
        for iStd = 1:nStds
            procedure = createProcedure(doc,iStd,nStim);
            procedure.setAttribute('id',['procedure' num2str(iStd)]);
            procedures.appendChild(procedure);
        end
    end

    function procedure = createProcedure(doc,iStd,nStim)
        procedure = doc.createElement('procedure');
        procedure.setAttribute('xsi:type','apex:constantProcedureType');
        procedure.appendChild(create_parameters(doc));
        procedure.appendChild(create_trials(doc,iStd,nStim));
    end

    function parameters = create_parameters(doc)
        parameters = doc.createElement('parameters');
        
        presentations = doc.createElement('presentations');
        presentations.setTextContent('4');
        parameters.appendChild(presentations);
        
        order = doc.createElement('order');
        order.setTextContent('random');
        parameters.appendChild(order);
        
        choices = doc.createElement('choices');
        choices.setAttribute('select','2');
        choices.setTextContent('2');
        parameters.appendChild(choices);
        
        pause_between_stimuli = doc.createElement('pause_between_stimuli');
        pause_between_stimuli.setTextContent('800');
        parameters.appendChild(pause_between_stimuli);
    end

    function trials = create_trials(doc,iStd,nStim)
        trials = doc.createElement('trials');
        for iStim = 1:nStim
            trials.appendChild(create_trial(doc,iStd,iStim));
        end
    end

    function trial = create_trial(doc,iStd,iStim)
        trial = doc.createElement('trial');
        trial.setAttribute('id',['trial' num2str(iStd) num2str(iStim)]);
        
        screen = doc.createElement('screen');
        screen.setAttribute('id','screen1');
        trial.appendChild(screen);
        
        stimulus = doc.createElement('stimulus');
        stimulus.setAttribute('id',['stim' num2str(iStim)]);
        trial.appendChild(stimulus);
        
        standard = doc.createElement('standard');
        standard.setAttribute('id',['stimref' num2str(iStd)]);
        trial.appendChild(standard);
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
