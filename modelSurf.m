function [ax, hsurf, hscat, f] = modelSurf(Data,R,reg)

[ax,hscat,f] = myscatter3(Data,R);
hold(ax,'on');

pts = 50;
xl = [min(Data(:,1)), max(Data(:,1))];
xr = range(Data(:,1));
yl = [min(Data(:,2)), max(Data(:,2))];
yr = range(Data(:,2));
zr = range(R);
zl = [min(R)-zr/5, max(R)+zr/5];

[X,Y] = meshgrid((xl(1):xr/pts:xl(2)), (yl(1):yr/pts:yl(2)));

PM = reg.PowerMatrix;
C = reg.Coefficients;

% Now Compute Z, the model fit at each of the X and Y points

modelfun = @(x,y,pm,c) sum(c.*repmat(x,size(c,1),1).^pm(:,1).*repmat(y,size(c,1),1).^pm(:,2));

Z = arrayfun(@(x,y) modelfun(x,y,PM,C),X,Y);

hsurf = surf(ax,X,Y,Z);
hsurf.EdgeAlpha = 0;
hsurf.FaceAlpha = 0.6;
ax.ZLim = zl;