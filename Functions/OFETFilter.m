function Updated = OFETFilter(Old,Constants)
%OFET Filter
% This function takes two inputs:
% Old: since multiple filters may be applied, this takes the *possibly*
% already filtered structure array as an input. Thus 'old'
%
% Constants: a structure with a field for each process variable, cell
% arrays to specify text variables that should be held constant, vectors or
% NaNs to specify where numerical variables should be held constant, or
% empty arrays to specify 'no constraint'

Updated=Old;            % Start with the full structure
ProcVars = fieldnames(Old);

for i = 1:length(ProcVars);
    disp(length(Updated))
    if isempty(Constants.(ProcVars{i}))     % If no constraint for this variable, move onto next category
        
    else
        HoldVal = Constants.(ProcVars{i}); % This could be a vector range for numeric variables or a cell array of strings
        
        if iscell(HoldVal)          % If it's a cell array (meaning it is a text-based variable)
            NumDevs = length(Old);  % How many devices we started with
            Updated = struct();     % Going to rebuild the struct with only devices that satisfy HoldVals
            if length(Old)<1
                return
            end
            KeepVec = [];           % Store the indices of devices that we want to keep
            
            for ii = 1:length(HoldVal)
                if strcmp('None',HoldVal{ii})       % None means we keep the NaN's... for some reason I went with this
                    for d = 1:NumDevs
                        if isnan(Old(d).(ProcVars{i}))
                            KeepVec = [KeepVec d];
                        end
                    end
                else
                    for d = 1:NumDevs
                        if isequal(Old(d).(ProcVars{i}),HoldVal{ii})
                            KeepVec = [KeepVec d];
                        end
                    end
                end
            end
            Updated = Old(KeepVec);
            
        else
            % Else, it's a numeric variable, in which case it will be held
            % at a value, a range, or NaN
            
            if numel(HoldVal)==1
                NumDevs = length(Old);
                Updated = struct();
                if length(Old)<1
                    return
                end
                
                KeepVec = [];
                if isnan(HoldVal)
                    for d = 1:NumDevs
                        if isnan(Old(d).(ProcVars{i}))
                            KeepVec = [KeepVec d];
                        end
                    end
                else
                    for d = 1:NumDevs
                        if isequal(Old(d).(ProcVars{i}),HoldVal)
                            KeepVec = [KeepVec d];
                        end
                    end
                end
                
                Updated = Old(KeepVec);
                
            else
                
                NumDevs = length(Old);
                Updated = struct();
                if length(Old)<1
                    return
                end
                
                KeepVec = [];
                for d = 1:NumDevs
                    if Old(d).(ProcVars{i})>=HoldVal(1) && Old(d).(ProcVars{i})<=HoldVal(2)
                        KeepVec = [KeepVec d];
                    end
                end
                
                Updated = Old(KeepVec);
            end
            
        end
        Updated = nestedSortStruct2(Updated,{'Year','Author'});
        Old = Updated;
    end
    
end