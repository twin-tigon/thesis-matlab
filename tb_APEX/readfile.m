function result = readfile(filename)
% function result = readfile(filename)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: ExpORL, KU Leuven, Belgium
% Created in     : 2010-2013
% Modified by Alejandro Osses, HTI, TU/e, the Netherlands, 2014
% Last updated on: 16/05/2014
% Last used on   : 29/06/2014
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if (~exist(filename))
    warning(['Can''t open file ' filename ]);
    result = '';
    return;
end

result='';
fid=fopen(filename);
while 1
    tline = fgets(fid);
    if ~ischar(tline), break, end
    result=[result tline];
end
fclose(fid);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end