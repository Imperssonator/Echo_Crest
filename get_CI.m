function reg = get_CI(reg,alpha)

% alpha = degree of confidence for t dist... default 0.05

if ~exist('alpha')
    alpha = 0.05;
end

% Now Compute Z, the model fit at each of the X and Y points

f_x = @(xi) prod(repmat(xi,size(reg.PowerMatrix,1),1).^reg.PowerMatrix,2);

reg.meanCIfun = @(x) tinv(1-alpha/2,reg.dof)*sqrt((f_x(x)'*inv(reg.X'*reg.X)*f_x(x))*reg.model_var);
reg.predCIfun = @(x) tinv(1-alpha/2,reg.dof)*sqrt((1+f_x(x)'*inv(reg.X'*reg.X)*f_x(x))*reg.model_var);
reg.CIoptpt = fminsearch(reg.meanCIfun,mean(reg.Data,1));
reg.CIoptval = reg.predCIfun(reg.CIoptpt);

end