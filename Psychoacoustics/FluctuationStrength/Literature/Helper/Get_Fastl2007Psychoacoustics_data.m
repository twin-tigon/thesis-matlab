function data = Get_Fastl2007Psychoacoustics_data(filename)
% function data = Get_Fastl2007Psychoacoustics_data(filename)
% 
% Returns literature data from Fastl2007Psychoacoustics.
% 
% Inputs:
% filename: The filename to use.
% 
% Outputs:
% data: Struct with the values obtained.
% 
% Author: Rodrigo García

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    csv         = csvread(filename,1,0);
    csv_size    = size(csv);

    if csv_size(2) == 2
        [x,c] = GroupBy(csv,'cols');
    else
        [s,x,m,l,u] = GroupBy(csv,'cols');
        c           = mean([m(s==1)';m(s==2)']);
    end

    n = length(c);

    vars = Cellfilter(who,@(x)...
        ~strcmp(x,'ans')...
        && ~strcmp(x,'csv')...
        && ~strcmp(x,'filename')...
        && ~strcmp(x,'settings')...
        && ~strcmp(x,'specs')...
        && ~strcmp(x,'csv_size')...
        && ~strcmp(x,'fig_smooth')...
        && ~strcmp(x,'standalone')...
    );

    data = struct;
    for v = 1:length(vars)
        try
            data.(vars{v}) = eval(vars{v});
        end
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
