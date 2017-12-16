function [succes,basepath] = download_hrtf(database)
%DOWNLOAD_HRTF download freely available HRTF data sets and store them in hrtf/data/
%
%
%   Url: http://amtoolbox.sourceforge.net/doc/hrtf/download_hrtf.php

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

%% ===== Database urls ===================================================
database_url = { ...
    'wierstorf2011_3m',   'https://dev.qu.tu-berlin.de/projects/measurements/repository/raw/2010-11-kemar-anechoic/mat/QU_KEMAR_anechoic_3m.mat';...
    'wierstorf2011_2m',   'https://dev.qu.tu-berlin.de/projects/measurements/repository/raw/2010-11-kemar-anechoic/mat/QU_KEMAR_anechoic_2m.mat';...
    'wierstorf2011_1m',   'https://dev.qu.tu-berlin.de/projects/measurements/repository/raw/2010-11-kemar-anechoic/mat/QU_KEMAR_anechoic_1m.mat';...
    'wierstorf2011_0_5m', 'https://dev.qu.tu-berlin.de/projects/measurements/repository/raw/2010-11-kemar-anechoic/mat/QU_KEMAR_anechoic_0.5m.mat';...
};


%% ===== Checking of input parameters ====================================


%% ===== Downloading the databases =======================================
% get the path to hrtf/
basepath = fullfile(amtbasepath,'hrtf','wierstorf2013');
% create directory if it is not existing
if ~exist(basepath,'dir')
    mkdir(basepath);
end
for ii=1:size(database_url,1)
    if strcmpi(database_url{ii,1},database)
        % check if file is already downloaded
        filename = fullfile(basepath,[database_url{ii,1} '.mat']);
        if ~exist(filename,'file')
            succes = urlwrite(database_url{ii,2},filename);
        else
            succes = 1;
        end
        % end the loop if desired data base was stored
        return;
    end
end

