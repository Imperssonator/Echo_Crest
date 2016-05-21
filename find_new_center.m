function L = find_new_center(L,reg,numOpts,alphac,numBins)

if ~exist('numBins')
    numBins = 20;
end

if ~exist('numOpts')
    numOpts = 500;
end

if ~exist('alphac')
    alphac = 0.98;
end

L.numOpts = numOpts;
L.alphac = alphac;
numMods = length(reg);
numDims = size(reg(1).Data,2);

opts_used = 0;
for i = 1:numMods-1
    reg(i).optSamps = round(numOpts*reg(i).PB);
    opts_used = opts_used+reg(i).optSamps;
end
reg(numMods).optSamps = numOpts-opts_used;

C = zeros(numOpts,numDims); % Store all potential new centers
optCount = 0;
for i = 1:numMods
    for j = 1:reg(i).optSamps
        optCount = optCount+1;
        
        % Get a resampled dataset
        numPts=length(reg(i).Residuals); % number of points
        boot_y = reg(i).y+reg(i).Residuals(randi(numPts,numPts,1)); % bootstrapped responses
        
        % Fit the appropriate model
        boot_reg = MultiPolyRegress(reg(i).Data,boot_y,reg(i).Degree);
        boot_fun = @(xi) sum(boot_reg.Coefficients.* ...    % The model fit function
            prod(repmat(xi,size(boot_reg.PowerMatrix,1),1).^boot_reg.PowerMatrix,2));
        opt_fun = @(xx) abs( L.T-boot_fun(xx) ); % The objective function to optimize
        
        % Optimize the model and record its suggested new center
        C(optCount,:) = fminsearch(opt_fun,mean(reg(i).Data,1));
    end
end

% Make ND histogram of centers, find the bin with the most votes
[N edges mid loc] = histcn(C);
[~,maxbin] = max(N(:));
bc = 0;
indv = ind2subv(size(N),maxbin);
cent = [];
for n = 1:numDims
    cent = [cent, mid{n}(indv(n))];
end

L.cent = cent;
L.mid_bin = mid;
L.hist = N;

% Determine new layer bounds by generating Psi function
disp('Finding new layer...')
r_disc = 100;    % Level of discretization for Psi function r
L1_range = range(reg(1).Data);
r_step = L1_range/r_disc;

Psi_r = 0;
Psi = [];
R = [];
R_i = zeros(1,numDims);
while Psi_r<1
    disp(Psi_r)
    InRange = zeros(size(C));
    LB = L.cent-R_i; UB = L.cent+R_i;
    for n = 1:numDims
        InRange(:,n) = C(:,n)>LB(n) & C(:,n)<UB(n);
    end
    Psi_r = sum(uint8(sum(uint8(InRange),2)==numDims),1)/numOpts;   % Find fraction of potential centers that are within range
    Psi = [Psi; Psi_r];
    R = [R; R_i];
    
    R_i = R_i+r_step;
end

Psi_a = find(Psi>alphac,1);
R_new = R(Psi_a,:);

L.Psi = Psi;
L.R = R;
L.r_star = R_new;
L.LB = L.cent-R_new;
L.UB = L.cent+R_new;

end


    
        