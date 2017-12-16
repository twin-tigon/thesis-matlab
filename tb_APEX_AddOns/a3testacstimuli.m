function a3testacstimuli(savefilename, path, ncols)
% function a3testacstimuli(savefilename, path, ncols)
% 
% 1. Description:
%       Creates an APEX3 experiment file that can present any of the .wav
%       files under the directory 'paths'.
%       'ncols' correspond to the number of columns to be displayed. If there
%       are 5 wav files in path, then buttons are going to be displayed in a
%       2 x 3 matrix
%       It uses the XML template file 'a3testacstimuli.xml' and it requires
%       the APEX MATLAB toolbox
% 
% 2. Stand-alone example (Windows example):
%       path = 'D:\Output\Daniel1997_test_20141126\'; 
%       savefilename = 'test-XML.xml';
%       a3testacstimuli(savefilename, path,3);
% 
% Programmed by the APEX3 team
% Created on    : 2013-2014
% Adapted by Alejandro Osses, HTI, TU/e, the Netherlands, 2014-2015
% Last update on: 11/06/2015 % Update this date manually
% Last use on   : 11/06/2015 % Update this date manually
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

experiment.trials='';
experiment.screen='';
experiment.datablocks='';
experiment.map='';
experiment.stimuli='';

try
    path=makedirend(path);
end

files=dir([path '*.wav']);
buttons=cell(length(files),1);

for f=1:length(files)
    filename=files(f).name;
    filename_noext=filename(1:end-4);
    
    datablock=['d' filename_noext];
    stimulus=['s' filename_noext];
    trial=['t' filename_noext];
    button=['button' filename_noext];
    experiment.datablocks=[experiment.datablocks a3datablock(datablock, filename, 'wavdevice')]; % 'soundcard' %for old templates
    experiment.trials=[experiment.trials a3trial(trial, 'screen', stimulus, button)];
    experiment.stimuli=[experiment.stimuli a3stimulus(stimulus, datablock)];
    
    buttons{f}=filename_noext;
end

if nargin < 3
    ncols = 3;
end

nrows = ceil(length(buttons)/ncols);

buttons=[buttons; cell(nrows*ncols-length(buttons),1)];

buttons = transpose( reshape(buttons, ncols, nrows) ); % trick to get [1 2 3; 4 5 6] instead of [1 3 5;2 4 6]

experiment.buttonlayout = a3buttonlayout(buttons, 1,2);
experiment.buttongroup  = a3buttongroup(buttons);

result=readfile_replace('a3testacstimuli.xml',experiment);
% result=readfile_replace('a3testacstimuli-TF-20131029.xml',experiment);

fid=fopen([path savefilename],'w');
if (fid==-1)
    error(['Can''t open file ' savefilename ]);
end
fwrite(fid, result);
fclose(fid);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
