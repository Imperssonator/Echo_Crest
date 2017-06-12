function DES = RSM(center, scales, obj_fun)

% Run a response surface optimization (minimization) starting from a given
% center point with "scales" indicating how to space the grid for factorial
% design levels

% -------------------
maxDeg = 3;
% -------------------


DES = struct();     % Everything is going to be stored here
DES.obj_fun = obj_fun;
DES.layers = {'init'};

% First, build the initial layer, 2^2+center point
init = struct();
init.center = center;
init.X = [center;
          center;
          center;
          center + scales .* [0.5 0.5];
          center + scales .* [0.5 -0.5];
          center + scales .* [-0.5 0.5];
          center + scales .* [-0.5 -0.5]];
      
init.Y = obj_fun(init.X);

% Check for curvature
init.curvTest = check_curvature1(init.X,init.Y);
DES.init = init;

if init.curvTest < 0
    DES = add_ccd(

if curvTest>0
    [newData, newR] = get_central_composite(DD(initRows,:),RR(initRows,:));
    newStart = size(DD,1)+1;
    DD = [DD; newData];
    RR = [RR; newR];
    ccRows = [initRows; (newStart:size(DD,1))'];
    ccFit = MultiPolyRegress(DD(ccRows,:),RR(ccRows,:),1);
    ccFit(2) = MultiPolyRegress(DD(ccRows,:),RR(ccRows,:),2);
    
    % Hopefully ........ it's a paraboloid.... and that is the problem.
end

% New algorithm:
% Take 2^2+center
% Fit ALL MODELS
% If a "sloped" model fits, follow it with steepest descent until you hit a
% possible new minimum, then re-start
% If simple mean is best fit, expand to CCD
% FIT ALL MODELS
% If "sloped" model fits, follow with steepest descent...

% If at any point a model with a local minimum within the current design
% region is best, test that point - if it falls within 95CI, you're done.
% If not, re-fit and try again.


end