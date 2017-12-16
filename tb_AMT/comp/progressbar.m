function progressbar(ii,nii)
% PROGRESSBAR Show the progress of an iteration
%   Usage: progressbar(ii,nii)
%
%   Input parameters:
%       ii  - Current iteration
%       nii - number of iterations
%
%   PROGRESSBAR(ii,nii) displays the progress of a loop.
%
%
%   Url: http://amtoolbox.sourceforge.net/doc/comp/progressbar.php

% Copyright (C) 2009-2014 Peter L. Søndergaard and Piotr Majdak.
% This file is part of AMToolbox version 0.9.6
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.

%   AUTHOR: Hagen Wierstorf


% ------ Checking of input parameters ------------------------------------
error(nargchk(2,2,nargin));
if ( ~isnumeric(ii) || ~isscalar(ii) )
    error('%s: ii has to be a scalar.',upper(mfilename));
end
if ( ~isnumeric(nii) || ~isscalar(ii) )
    error('%s: nii has to be a scalar.',upper(mfilename));
end


% ------ Generate the progress bar ---------------------------------------
% \r is not working under some Windows systems, therefore we use \b to clear the
% line
str_length = 30; % this allows to handle integers up to 12 characters
if ii==nii
    clear_line(str_length);
    fprintf(1,'Run %.0f/%.0f\n',ii,nii);
else
    clear_line(str_length);
    fprintf(1,'Run %.0f/%.0f',ii,nii);
end
% Octave didn't show the output directly in a function call, in order to do so
% it has explicitly flushed to stdout
if isoctave
    fflush(1);
end
end % end of function


%% ------ Subfunctions ---------------------------------------------------
function clear_line(str_length)
    for ii=1:str_length
        fprintf(1,'\b');
    end
end

