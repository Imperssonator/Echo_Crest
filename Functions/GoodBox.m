function [hScat,hMarks,ax] = GoodBox(GroupSort,MobSort)

[xLabs, groupSplits, xVals] = unique(GroupSort,'stable');
xValsJog = xVals+(rand(length(xVals),1)-0.5)/5;
if ~iscell(xLabs)
    xLabs = mat2cell(xLabs,size(xLabs,1),size(xLabs,2));
end

% Create figure
f1=figure;
hold on

% Create scatterplot
hScat = scatter(xValsJog,MobSort); drawnow;
ax = gca;

% Separate Groups and plot medians / 25th and 75th percentiles as lines
for g = 1:max(xVals)
    if g==max(xVals)
        Setg = MobSort(groupSplits(g):end,1);
    else
        Setg = MobSort(groupSplits(g):groupSplits(g+1)-1,1);
    end
    Setx = xVals(groupSplits(g));
    med = median(Setg);
    p25 = prctile(Setg,25);
    p75 = prctile(Setg,75);
    boxWid = 0.25;
    plot(ax,[Setx-boxWid, Setx+boxWid], [med, med], '-k');
    plot(ax,[Setx-boxWid, Setx+boxWid], [p25, p25], '-k');
    plot(ax,[Setx-boxWid, Setx+boxWid], [p75, p75], '-k');
    plot(ax,[Setx-boxWid, Setx-boxWid], [p25, p75], '-k');
    plot(ax,[Setx+boxWid, Setx+boxWid], [p25, p75], '-k');
end

ax.XTickMode = 'manual';
ax.XTick = (1:max(xVals));
ax.XTickLabels = xLabs;
ax.FontSize=16;
ax.YScale = 'log';
ax.Box = 'on';
ax.XTickLabelRotation = 40;

% Make Transparent Labels
hScat.SizeData = 100;
hMarks = hScat.MarkerHandle;
hMarks.EdgeColorData = uint8([100; 100; 100; 175]);
hMarks.FaceColorData = uint8([120; 120; 120; 150]);
% hMarks.Size = 10;

end