function R = RunCompExp(ExpCell,ExpFun)

%% Run Computer Experiment
% For experiments that have a function call, run the specified design layer
% ExpCell = cell array, 2x1: {'Name of experiment', <layer number>}
% ExpFun = string: 'Name of function call in experimental folder'

ExpName = ExpCell{1};
Layer = ExpCell{2};

load([ExpName '/EXP'])

RFun = str2func(ExpFun);

Runs = E(Layer).Design;

R = zeros(size(Runs,1),1);

addpath([ExpName '/']);

for i = 1:size(Runs,1)
    R(i) = RFun(Runs(i,:));
end

rmpath([ExpName '/'])

E(Layer).R = R;

save([ExpName '/EXP'],'E')

end