function [hScat,hMarks,ax] = StdFig()

StdMob = [];
StdGroups = {};
TotDev = 0;
Constants = GenerateEmptyConstants();

[MobSort, GroupSort, Filtered] = OFETSearch(Constants,'Year');
StdMob = [StdMob; MobSort];
for i = TotDev+1:length(StdMob)
    StdGroups{i,1} = 'All Devices';
end
TotDev = length(StdMob);

disp('Solvents...')

Constants.Solv1={'CHCl3'};
Constants.VFSolv1 = NaN;
[MobSort, GroupSort, Filtered] = OFETSearch(Constants,'Year');
StdMob = [StdMob; MobSort];
for i = TotDev+1:length(StdMob)
    StdGroups{i,1} = 'CHCl3';
end
TotDev = length(StdMob);

disp('Depo...')

Constants.Depo={'SPUN'};
[MobSort, GroupSort, Filtered] = OFETSearch(Constants,'Year');
StdMob = [StdMob; MobSort];
for i = TotDev+1:length(StdMob)
    StdGroups{i,1} = 'Spin-coated';
end
TotDev = length(StdMob);

Constants.OFETConfig={'BGBC'};
Constants.ElectrodeMat={'Au'};
[MobSort, GroupSort, Filtered] = OFETSearch(Constants,'Year');
StdMob = [StdMob; MobSort];
for i = TotDev+1:length(StdMob)
    StdGroups{i,1} = 'BGBC';
end
TotDev = length(StdMob);

Constants.Mn=[20 Inf];
[MobSort, GroupSort, Filtered] = OFETSearch(Constants,'Year');
StdMob = [StdMob; MobSort];
for i = TotDev+1:length(StdMob)
    StdGroups{i,1} = 'Mn > 20kD';
end
TotDev = length(StdMob);

Constants.AnnTime=NaN;
[MobSort, GroupSort, Filtered] = OFETSearch(Constants,'Year');
StdMob = [StdMob; MobSort];
for i = TotDev+1:length(StdMob)
    StdGroups{i,1} = 'No Annealing';
end
TotDev = length(StdMob);

Constants.SonicationTime=NaN;
Constants.AgeTime=NaN;
[MobSort, GroupSort, Filtered] = OFETSearch(Constants,'Year');
StdMob = [StdMob; MobSort];
for i = TotDev+1:length(StdMob)
    StdGroups{i,1} = 'No Pre-treatment';
end
TotDev = length(StdMob);

Constants.ChanLen=[10 Inf];
[MobSort, GroupSort, Filtered] = OFETSearch(Constants,'Year');
StdMob = [StdMob; MobSort];
for i = TotDev+1:length(StdMob)
    StdGroups{i,1} = 'Channel > 10µm';
end
TotDev = length(StdMob);

[hScat,hMarks,ax] = GoodBox(StdGroups,StdMob);

ax.XTickLabels = {'All Devices'; 'Chloroform'; 'Spin-coated'; 'BGBC'; 'Mn > 20kD'; 'No Annealing'; 'No Pre-treatment'; 'Channel < 10µm'};
ax.PlotBoxAspectRatioMode = 'auto';

end