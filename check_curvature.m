function handles = check_curvature(handles)

Data = handles.options.selData;
R = handles.options.selR;

[C,IA,IC] = unique(Data,'rows');

% Find which rows are center points

cent_approx = mean(Data,1);

cent_dist = sqrt(sum((Data-repmat(cent_approx,size(Data,1),1)).^2,2));

cent_rows = cent_dist<0.01;

nc = sum(cent_rows);
nf = sum(~cent_rows);

% Get means and calculate statistics

yc = mean(R(cent_rows),1);
yf = mean(R(~cent_rows),1);

SScurv = nc*nf*(yc-yf)^2/(nc+nf);

sigma2 = std(R(cent_rows))^2;

F0 = SScurv/sigma2;

t_test = F0^2>tinv(1-0.05/2,nc-1);

handles.curvTest = t_test;

end

