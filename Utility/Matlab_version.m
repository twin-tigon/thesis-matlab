function v = Matlab_version
% function v = Matlab_version
% 
% Matlab_version: returns MATLAB version as a number.
% The built-in function version returns a string,
% which is inconvenient for comparison purposes.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    Copyright: Cochlear Ltd
%      $Change: 86418 $
%    $Revision: #1 $
%    $DateTime: 2008/03/04 14:27:13 $
%      Authors: Brett Swanson
% Edited by Alejandro Osses, HTI, TU/e, the Netherlands, 2014-2015
% Last used on: 31/03/2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

version_str = version;				% a string
v = sscanf(version_str, '%f', 1);	% read one floating point number, e.g. '6.1'

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
