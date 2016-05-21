function out = DesignInit(ExpName,Bounds,NumPts,Fill)

%% Initiate an Experimental Design
% ExpName: a string that is the name of the experiment
% Bounds: an Nx2 matrix, N = number of parameters, columns 1 and 2 are
% lower and upper bounds on those parameters
% NumPts: scalar, the number of design points to fill the space with
% Fill: string, the method used to fill the space.
% Current options for fill:
%   - 'Factorial22'

% This is currently only going to work for a 2-D space


mkdir(ExpName);
ExpDir = [ExpName '/'];

E = struct();    % The experiment is a structure

if strcmp(Fill,'Factorial22')
    InitPts = Factorial22(Bounds,NumPts);
end

E(1).Design = InitPts;

save([ExpDir 'EXP'],'E')

end