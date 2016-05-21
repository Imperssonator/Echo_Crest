

% Fit Linear Model
creg = MultiPolyRegress(cx,cy,1);
% mfun1 = @(xi) sum(creg.Coefficients.*prod(repmat(xi,size(creg.PowerMatrix,1),1).^creg.PowerMatrix,2));

% Fit Quadratic Model
creg(2) = MultiPolyRegress(cx,cy,2);
% mfun2 = @(xi) sum(creg2.Coefficients.*prod(repmat(xi,size(creg2.PowerMatrix,1),1).^creg2.PowerMatrix,2));

reg1 = get_fit_measures(creg(1),2,0.5);
reg1 = get_CI(reg1,0.05);
reg2 = get_fit_measures(creg(2),2,0.5);
reg2 = get_CI(reg2,0.05);
reg = reg1;
reg(2) = reg2;

% Find Best Model
AIC = [reg(:).AIC];
PB = [reg(:).PB];

% Normalize Bayesian probabilities
for i = 1:length(reg)
    reg(i).PB = reg(i).PB/norm(PB,1);
end

CI = [reg(:).CIoptval];
[~,best_model_ind] = min(CI);
bestmod = reg(best_model_ind);

% Generate its function
mfun = @(xi) sum(bestmod.Coefficients.*prod(repmat(xi,size(bestmod.PowerMatrix,1),1).^bestmod.PowerMatrix,2));
posCIfun = @(xi) mfun(xi)+bestmod.meanCIfun(xi);
negCIfun = @(xi) mfun(xi)-bestmod.meanCIfun(xi);

% L metric
T = 40; % Target
d=5; % Tolerance
Lfun = @(xi) max(abs(T-posCIfun(xi)),abs(T-negCIfun(xi)));
[x_star, L_star] = fminsearch(Lfun,mean(bestmod.Data,1));
disp('L* = '); disp(L_star)
if L_star<d
    disp('Optimization complete')
end

% Figure out the Next Layer

% Bootstrapping for Center Determination
numOpts = 1000;  % 100 optimizations per candidate model
alphac = 0.98;
L2 = struct();
L2.T = T;
L2 = find_new_center(L2,reg,numOpts,alphac);
disp('new center:'); disp(L2.cent)
disp('lower bound:'); disp(L2.LB)
disp('upper bound:'); disp(L2.UB)
figure; plot((1:length(L2.Psi))',L2.Psi,'-b');

% Adaptive Combined Design
% L2 = ACD(L2,reg);

% Plot Data and both fits
f1 = figure;
ax = gca;
hold(ax,'on')
hdata = plot(ax,cx,cy,'og');
plot_range = [min(cx)-0.1*range(cx), max(cx)+0.1*range(cx)];
fplot(ax,mfun,plot_range);
% fplot(ax,cfun2,[min(cx)-10,max(cx)+10],'-c');
color = uint8([0 150 50]);
hdata.MarkerFaceColor = color;
hdata.MarkerEdgeColor = color;
hdata.MarkerSize = 10;

% Plot mean intervals
fplot(ax, posCIfun,plot_range,'-.k')
fplot(ax, negCIfun,plot_range,'-.k')

% Plot L function and target
fplot(ax, @(x) T,plot_range,'-r')
fplot(ax, Lfun,plot_range,'-b')

