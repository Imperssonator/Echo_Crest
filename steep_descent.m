function pts = steep_descent(Data,R,h)

% h is the space

numOpts = 500;
numDims = size(Data,2);

% Fit Linear Model
reg = MultiPolyRegress(Data,R,1);

% Bootstrap a bunch of gradient vectors from linear models
G = zeros(numOpts,numDims);

for i = 1:numOpts
    
    % Get a resampled dataset
    numPts=length(reg.Residuals); % number of points
    boot_y = reg.y+reg.Residuals(randi(numPts,numPts,1)); % bootstrapped responses
    
    % Fit the appropriate model
    boot_reg = MultiPolyRegress(reg.Data,boot_y,reg.Degree);
    
    % Store the gradient of the model
    grad = boot_reg.Coefficients(2:3)';
    grad_norm = grad./norm(grad,2);
    G(i,:) = grad_norm;
end

% Make ND histogram of centers, find the bin with the most votes
[N edges mid loc] = histcn(G);
[~,maxbin] = max(N(:));
indv = ind2subv(size(N),maxbin);
gg = [];
for n = 1:numDims
    gg = [gg, mid{n}(indv(n))];
end

cent = mean(Data,1);
pts = cent;
for p = 1:20
    pts = [pts; cent-gg.*h*p];
end

end