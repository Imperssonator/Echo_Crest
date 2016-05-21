function reg = get_fit_measures(reg,mu_e,prior)

% mu_e is number of repetitions of each data point
% prior is the prior probability of the model

if ~exist('mu_e')
    mu_e = 1;
end

if ~exist('prior')
    prior = 1;
end

n = size(reg.Residuals,1); reg.n = n;
p = size(reg.Coefficients,1); reg.p = p;
dof = n-p; reg.dof = dof;

reg.MSE = sum(reg.Residuals.^2)/n;
reg.model_var = sum(reg.Residuals.^2)/(n-p);
reg.AIC = n*(log(2*pi()*reg.MSE) + 1) + 2*p;
reg.PB = prior * 2^(-p/2) * reg.MSE^(-mu_e/2);

end