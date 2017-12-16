function alabels=removeduplicate(a)
% remove duplicate values in array

    s=sort(a);
    alabels=[s(1)];
    for i=1:length(s)
        if (s(i)~=alabels(end))
            alabels=[alabels s(i)];
        end
    end