% Casciato Data
cx = [60 60 90 120 120 150]';
cy = [18.3 17.8 24.3 44 47.5 51.8]';

% Wire Data
% cx=[2 8 11 10 8 4 2 2 9 8 4 11 12 2 4 4 20 1 10 15 15 16 17 6 5; 50 110 120 550 295 200 375 52 100 300 412 400 500 360 205 400 600 585 540 250 290 510 590 100 400]';
% cy=[9.95 24.45 31.75 35.00 25.02 16.86 14.38 9.60 24.35 27.50 17.08 37 41.95 11.66 21.65 17.89 69 10.3 34.93 46.59 44.88 54.12 56.63 22.13 21.15]';

% Oxygen Data 
% cx=[0.99 1.02 1.15 1.29 1.46 1.36 0.87 1.23 1.55 1.4 1.19 1.15 0.98 1.01 1.11 1.2 1.26 1.32 1.43 0.95]'
% cy=[90.01 89.05 91.43 93.74 96.73 94.45 87.59 91.77 99.42 93.65 93.54 92.25 90.56 89.54 89.85 90.39 93.25 93.41 94.98 87.33]'

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

