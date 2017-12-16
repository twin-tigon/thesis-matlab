function p = Ensure_field(p, field_name, default_value)
% function p = Ensure_field(p, field_name, default_value)
%
% Ensure that a struct field exists, else give it a default value.
% If the field existed in the input p, then the output p is identical.
% Else a new field is created, with the specified default value.
% function p = Ensure_field(p, field_name, default_value);
% 
% Inputs:
% p:             Parameter struct.
% field_name:    Name of field (string).
% default_value: Value to set field to if field does not exist in p.
%
% Outputs:
% p:             Parameter struct.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%      Copyright: Cochlear Ltd
%        $Change: 86418 $
%      $Revision: #1 $
%      $DateTime: 2008/03/04 14:27:13 $
% Authors       : Brett Swanson
% Edited by     : Alejandro Osses
% Last edited on: 21/05/2014
% Last used on  : 31/03/2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ~isfield(p, field_name)
	p = setfield(p, field_name, default_value);
    disp([mfilename '.m: Struct field ''' field_name ''' assigned'])
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
