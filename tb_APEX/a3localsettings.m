function r=a3localsettings
% function r=a3localsettings
%
% return apex 3 toolbox settings
% Created by: Tom Francart
% Edited by: Alejandro Osses
% Last edited on: 6/3/2015
% Last used on: 6/3/2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% path to xalan, only necessary if APEX does not do the XSLT transformation
r.xalancmd='/usr/bin/xalan';

% Main APEX directory:
if ismac
    r.apex_path='/Users/rodrigo/VirtualBox VMs/Luxuria/share/APEX_shared/';
elseif ~isunix
    r.apex_path='C:\Program Files\apex\';
else
    r.apex_path='/home/alejandro/data/apex/';
end

% APEX experiment schema
r.apex_schema=[r.apex_path 'schemas/experiment.xsd'];
% APEX XSLT scripts, only necessary if APEX does not do the XSLT transformation
if ismac
    r.apex_xslt_scripts=[r.apex_path 'xslt' delim];
elseif ~isunix
    r.apex_xslt_scripts=[r.apex_path 'xslt' delim];
else
    r.apex_xslt_scripts=[r.apex_path 'data' delim 'xslt' delim];
end
% Tool to check XML files, not required
r.xml_check_tool='/usr/bin/xmllint';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end