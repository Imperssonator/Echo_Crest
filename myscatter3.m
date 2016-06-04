function [ax,hscat,f] = myscatter3(Data,R)

% Data is an Nx2 matrix whose first column is X, second column is Y
% R is an Nx1 matrix which is basically "Z"

f = figure;
ax = gca;
hold(ax,'on');
hscat = scatter3(ax,Data(:,1),Data(:,2),R,'ob');

for i = 1:length(R)
    xi = Data(i,1);
    yi = Data(i,2);
    zi = R(i);
    li = plot3(ax,[xi xi],[yi yi],[0 zi],'-b');
    li.Color = [0 0 1 0.3];
end

ax.XGrid = 'on';
ax.YGrid = 'on';
ax.ZGrid = 'on';

hscat.SizeData = 60;
hscat.LineWidth = 1;

xbuffer = range(ax.XTick)*0.1;
ax.XLim = ax.XLim + [-xbuffer, xbuffer];
ybuffer = range(ax.YTick)*0.1;
ax.YLim = ax.YLim + [-ybuffer, ybuffer];

ax.CameraPosition = [-20.1425 -258.8670 0.3188];