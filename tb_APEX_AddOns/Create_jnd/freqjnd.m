function freqjnd(p)

p.type='freqjnd';

p=ensure_field(p,'fs', 44100);

p=ensure_field(p,'targetpath', '/data/apex/jnd/freq/');
p=ensure_field(p,'experiment_file', 'freqjnd.adp');
p=ensure_field(p,'basefreq', 250);
p=ensure_field(p,'steps', [1:0.01:1.1 1.1:0.1:2]);

p=ensure_field(p,'silence_after', 0.1);         % add zero's to avoid lynxOne clicking (s)

p=ensure_field(p,'file_prefix', 'fjnd_');
p=ensure_field(p,'file_postfix', '.wav');


% stimulus parameters:
stim.stimulus_type=1;    % sinus
stim.stimulus_len=0.5;       % stimulus length in seconds
stim.freq=p.basefreq;
stim.normalize_before=0;
stim.normalize_dba=1;       % normalize in dbA (left versus right)
stim.attenuate=20;       % attenuate by x dB (to prevent clipping)
stim.ramp=1;
stim.ramp_len=0.05;              % length of fade, in s
stim.audio_sample_rate=p.fs;



p.targetpath=[makedirend(p.targetpath) num2str(p.basefreq) '/'];

if (~exist(p.targetpath))
   mkdir(p.targetpath, '.'); 
   disp(['Warning: targetpath not found: ' p.targetpath]);
end

p.file_prefix=[p.file_prefix ];


standard=genstimulus(stim);
standard=addsilence(standard,p.silence_after,p.fs);
std_filename=[p.file_prefix 'standard' p.file_postfix];
wavwrite(standard,p.fs,[p.targetpath std_filename]);

ef=fopen([p.targetpath p.experiment_file],'w');
fprintf(ef,'[device]\ndevice=AUDIO\n\n');
fprintf(ef,'[help]\ntask=Which stimulus sounds differently?\n\n');
fprintf(ef,'[stimuli]\npath=.\ndefaultstandard=%s,label=%d\n', std_filename,p.basefreq);

for l=1:length(p.steps)
   curfreq=p.basefreq*p.steps(l);
   disp(['Curfreq=' num2str(curfreq)]);
   
   stim.freq=curfreq;
   
   filename=[p.file_prefix num2str(curfreq) 'Hz' p.file_postfix];
   stimulus=genstimulus(stim);
   stimulus=addsilence(stimulus,p.silence_after,p.fs);   
   wavwrite(stimulus,p.fs,[p.targetpath filename]);
   
   fprintf(ef,'signal=%s,label=%4.1f\n', filename,curfreq);
end

fprintf(ef,'\n\n[method]\nstart=%4.1f\n', p.basefreq*p.steps(end));
rest=readfile('fjndmethod.txt');
fprintf(ef,rest);
fprintf(ef,'\n[end]\n');


fclose(ef);

