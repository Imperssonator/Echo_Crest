function [hScat,hMarks,ax] = ChanLenFig()

Constants = GenerateEmptyConstants();

[MobSort, GroupSort, Filtered] = OFETSearch(Constants,'ChanLen');
whos GroupSort
disp(max(GroupSort))
longestChan = max(GroupSort);
GroupBin = cell(size(GroupSort));
for i = 1:length(GroupSort)
    if GroupSort(i)<10
        GroupBin{i,1} = '<10';
    elseif GroupSort(i)>=10 && GroupSort(i)<50
        GroupBin{i,1} = '10-49';
    elseif GroupSort(i)>=50 && GroupSort(i)<100
        GroupBin{i,1} = '50-99';
    else
        GroupBin{i,1} = '100+';
    end
end

[hScat,hMarks,ax] = GoodBox(GroupBin,MobSort);
ax.XTickLabelRotation = 0;

end
