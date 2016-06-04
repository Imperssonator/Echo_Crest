function Updated = RemoveNanInsertNone(Old,Variable)

%% Remove NaNs

% Remove devices from Old that have NaN entries under 'Variable'

for i = 1:length(Old)
    if isnan(Old(i).(Variable))
        Old(i).(Variable) = 'None';
    else
    end
end

Updated = Old;

end