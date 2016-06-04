function [hScat1,hMarks1,ax1,hScat2,hMarks2,ax2] = MnFig()

Constants = GenerateEmptyConstants();

[MobSort, GroupSort, Filtered] = OFETSearch(Constants,'Mn');
[hScat1,hMarks1,ax1] = GoodScatter(GroupSort,MobSort);
xlabel('Mn (kD)')
ylabel('Mobility (cm^2/Vs)')
disp(length(Filtered))

[MobSortP, GroupSortP, FilteredP] = OFETSearch(Constants,'PDI');
[hScat2,hMarks2,ax2] = GoodScatter(GroupSortP,MobSortP);
xlabel('PDI')
ylabel('Mobility (cm^2/Vs)')
disp(length(FilteredP))

Mn = [FilteredP(:).Mn]';
PDI = [FilteredP(:).PDI]';
GoodScatter(PDI,Mn);
reg = MultiPolyRegress(PDI,Mn,1)
disp(reg.RSquare)

end
