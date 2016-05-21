function PredOpt = ModelSelect(ExpCell,Models)

%% Model Select
% Opens an experiment given by the Experiment Cell Array and fits
% Models = cell array: Nx1, all strings of model types to consider

% Output is PredOpt: 1xM vector, M = number of parameters in design space

ExpName = ExpCell{1};
Layer = ExpCell{2};
ExpDir = [ExpName '/EXP'];
load(ExpDir)

CleanModels = {};

Data = E(Layer).Design;
R = E(Layer).R;

for i = 1:length(Models)
    ModelName = Models{i};
    [Regi CleanName] = ModelFit(Data,R,ModelName);
    E(i).(CleanName) = Regi;
    CleanModels{i} = CleanName;
    
end

E(Layer).Models = CleanModels;



end