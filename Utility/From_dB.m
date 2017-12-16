function gain = From_dB(gain_dB)
% function gain = From_dB(gain_dB)
%
% From_dB: Convert decibels to voltage gain.
% gain = From_dB(gain_dB)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copyright     : Cochlear Ltd
% $Change       : 86418 $
% $Revision     : #1 $
% $DateTime     : 2008/03/04 14:27:13 $
% Authors       : Brett Swanson
% Modified by Alejandro Osses, HTI, TU/e, the Netherlands, 2014
% Last update on: 30/07/2014 % Update this date manually
% Last use on   : 30/07/2014 % Update this date manually
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

gain = 10 .^ (gain_dB / 20.0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
