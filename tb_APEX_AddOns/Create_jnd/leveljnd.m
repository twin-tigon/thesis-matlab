function leveljnd(p)

p.type='leveljnd';

p=ensure_field(p,'targetpath', '/data/apex/jnd/level/');
p=ensure_field(p,'filename', 'jnd_level.xml');
p=ensure_field(p,'stimulus_type',1);        % sinus
p=ensure_field(p,'stimulus_len',0.5);       % stimulus length in seconds
p=ensure_field(p,'normalize_rms', -20);
p=ensure_field(p,'audio_sample_rate',44100);
p=ensure_field(p,'freq', 250);

p=ensure_field(p,'lds', [0:2:10]);          % level differences

p.targetpath=makedirend(p.targetpath);

signal=genstimulus(p);

filename=[ p.targetpath '/sinus_' num2str(p.freq) 'Hz.wav'];
wavwrite(signal,p.audio_sample_rate, filename);

% create apex file

filelist={filename};

datablocknames={'sinus'};
datablocks=a3datablocks({filename}, '', datablocknames);

stimulinames=cell(length(p.lds),1);
fixparams=cell(length(p.lds),1);
varparams=cell(length(p.lds),1);

for c=1:length(p.lds)
   ld=p.lds(c);
   
   stimulinames{c}=['stim_ld_' num2str(ld)];
%   trialnames{c}=['trials_ld_' num2str(ld)];
   
   fixparams{c}.stimnr=c;
   fixparams{c}.level=ld;
   varparams{c}.gain=ld;
end


stimuli=a3stimuli(datablocknames, stimulinames, varparams,fixparams);

screennames= {'screen'};

%trials=a3trials(trialnames,{}, screennames, stimulinames);
trials=a3singletrial('trial','','screen', stimulinames,'');
    
proceduretype=1;        % use adaptive procedure
    
procedureparameters=a3procedureparameters(p,proceduretype);   
procedureparameters.parameters.choices=3;
procedureparameters.parameters.defaultstandard='stim_ld_0';
procedureparameters.parameters.adapt_parameter='stimnr';
procedureparametersxml=a3toxml(procedureparameters);
procedure=a3procedure(procedureparametersxml,trials,proceduretype);

corrector=a3corrector('afc',procedureparameters.parameters.choices);
devices=a3devices();
connections=a3connections(p,'amplifier');

amp=a3amplifier(0);
filters=['<filters>' amp '</filters>'];

screens=a3screens( a3screen('afc',procedureparameters.parameters.choices) );
    

%% write everything to file in correct order %%
F = fopen([p.targetpath p.filename], 'w');
fprintf(F,'%s', a3header() );
fprintf(F,'%s', procedure);
fprintf(F,'%s', corrector );
fprintf(F, screens );
fprintf(F,'%s', datablocks );
fprintf(F,'%s', devices );
fprintf(F,'%s', filters );
fprintf(F,'%s', stimuli );
fprintf(F,'%s', connections );
fprintf(F,'%s', a3footer() );

fclose(F);
