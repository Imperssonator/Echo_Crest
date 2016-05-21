function out = Factorial22(Bounds,NumPts);

%% Factorial22
% Bounds is Nx2, N = number of design parameters
% NumPts is scalar
% out is NumPtsxN design matrix

B1mean = mean(Bounds(1,:));
B2mean = mean(Bounds(2,:));

out = [Bounds(1,1) Bounds(2,1);...
       Bounds(1,1) Bounds(2,2);...
       Bounds(1,2) Bounds(2,1);...
       Bounds(1,2) Bounds(2,2);...
       B1mean B2mean;...
       B1mean B2mean];
end
