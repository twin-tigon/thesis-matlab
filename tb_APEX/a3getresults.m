function [results,parameters,general] = a3getresults(filename,script,forcetransform)
% function [results,parameters,general] = a3getresults(filename,script,forcetransform)
%
% get results from an APEX3 result file
% transform first if necessary (check implementation on windows)
%
% % Example:
% % filename = '/home/alejandro/Documenten/Meas/Meas/Experiments/Results_XML/ci-Jan_Leys/20131007-PR/PR_Ref_104_UW_ACE-LB-ACE-JL.apr';
% % filename = '/home/alejandro/Documenten/Meas/Meas/Experiments/Results_XML/ci-Romain_Peeters/20130924-PR/PR_Ref_104_UW_ACE-LB-ACE-RP-mod.apr';
% % filename = '/home/alejandro/Documenten/Meas/Meas/Experiments/Results_XML/ci-Patrick_Meul/20131001-PR/PR_Ref_104_UW_ACE-LB-ACE-PM.apr';
% [file1,file2]=uigetfile('*.*','Select an APEX result file'); 
% filename = [file2 file1];
% script = 'apexresult.xsl';
% forcetransform = 1;
% [results,parameters,general] = a3getresults(filename,script,forcetransform);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if (nargin<2)
    script='';
end
if (nargin<3)
    forcetransform=0;
end

if (~exist(filename, 'file'))
    % look in all data paths
    pa=getpaths;
    paths=pa.results;
    for i=1:length(paths)
        newpath=fixpath([paths{i} '/' filename ]);
        if (exist( newpath ,'file'))
            filename=newpath;
        end
    end
end

results=readpartfile(filename,'<processed>', '</processed>');

if (forcetransform || length(results)==0)
    if (length(script)==0)
        script=a3getxsltscript(filename);
    end
    
    if (length(script)==0)
        error(['no XSLT script found for file ' filename]);
    end
    
    text=a3transform(filename, script);
    results=strread(text, '%[^\n]\n');
end


if (nargout>1)
    parameters=struct;
    part=readpartfile(filename,'<parameters>', '</parameters>');
    for l=1:length(part)
        line=part{l};
        names=regexp(line, '<parameter name="(?<name>[^"]*)">(?<value>[^<]*)<', 'names');
        if (~isempty(names))
            parameters=setfield( parameters, escapefieldname_l(names(1).name), names(1).value);
        end
    end
end

if (nargout>2)
    general=struct;
    part=readpartfile(filename,'<general>', '</general>');
    for l=1:length(part)
        line=part{l};
        names=regexp(line, '<(?<name>[^"]*)>(?<value>[^<]*)<', 'names');
        if (~isempty(names))
            general.(names(1).name) =  names(1).value;
        end
    end
end

function name=escapefieldname_l(name)
name = regexprep(name, ' ', '_');