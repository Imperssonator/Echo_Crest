function Updated = ClearEmpty(Old)

%% Find empty matrices and replace with NaN

FN = fieldnames(Old);
Updated = Old;

for d = 1:length(Old)
    for i = 1:numel(FN)
%         disp(Old(d).(FN{i}))
%         disp(isequal(Old(d).(FN{i}),[]))
        if isequal(Old(d).(FN{i}),[])
            Updated(d).(FN{i})=NaN;
        end
    end
end

end
