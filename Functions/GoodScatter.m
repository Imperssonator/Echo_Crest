function [hScat,hMarks,ax] = GoodScatter(X,Y)

% Create figure
f1=figure;
hold on

% Create scatterplot
hScat = scatter(X,Y); drawnow;
ax = gca;

ax.FontSize=16;
ax.YScale = 'log';
ax.Box = 'on';

% Make Transparent Labels
hScat.SizeData = 100;
hMarks = hScat.MarkerHandle;
hMarks.EdgeColorData = uint8([100; 100; 100; 175]);
hMarks.FaceColorData = uint8([120; 120; 120; 150]);

end