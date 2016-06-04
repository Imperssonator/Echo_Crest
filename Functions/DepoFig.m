function [hScat,hMarks,ax] = DepoFig()

Constants = GenerateEmptyConstants();
Constants.ElectrodeMat={'Au'};

[MobSort, GroupSort, Filtered] = OFETSearch(Constants,'Depo');

[hScat,hMarks,ax] = GoodBox(GroupSort,MobSort);

whos Filtered

ax.XTickLabels = {'Dip-coated'; 'Drop-cast'; 'Spin-coated'};
ax.XTickLabelRotation = 0;

end
