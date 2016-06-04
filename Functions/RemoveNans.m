function Updated = RemoveNans(Old,Variable)

%% Remove NaNs

% Remove devices from Old that have NaN entries under 'Variable'
NumDevs = length(Old);
Updated = struct();
KeepVec = [];
for i = 1:NumDevs
    if isnan(Old(i).(Variable))
    else
        KeepVec = [KeepVec i];
    end
end

Updated = Old(KeepVec);

end
