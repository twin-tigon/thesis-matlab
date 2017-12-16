function varargout = GroupBy(arr,dim)
% function varargout = GroupBy(arr,dim)
% 
% Groups array into separated array by columns or rows.
% 
% Input:
% arr: The array to use.
% dim: The dimension to group by, can be 'cols' or 'rows'.
% 
% Outputs:
% varargout: The grouped cell array.
% 
% Author: Rodrigo García

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if ~Xor(cellfun(@(x)strcmp(dim,x),{'cols','rows'}))
        error(['You must specifity either cols or rows as the '...
            'dimension  to use!']);
    end
    
    varargout = arrayfun(@(n)get_group(arr,dim,n)...
        ,1:get_n_groups(arr,dim),'UniformOutput',false);
    
    %% Helper functions

    function n = get_n_groups(arr,dim)
        s = size(arr);
        if strcmp(dim,'rows')
            n = s(1);
        else
            n = s(2);
        end
    end

    function g = get_group(arr,dim,n)
        if strcmp(dim,'cols')
            g = arr(:,n);
        else
            g = arr(n,:);        
        end
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
