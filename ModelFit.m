function [Reg, ModelNameClean] = ModelFit(Data,R,ModelName)

ModelChoices = {'Linear';...
                'Full Quadratic';...
                'Interactions';...
                'Pure Quadratic';...
                'Full Cubic';...
                };

ModelNameClean = ModelChoices{strnearest(ModelName,ModelChoices)};

if strcmp(ModelNameClean,'Linear')
    Reg = MultiPolyRegress(Data,R,1);
elseif strcmp(ModelNameClean,'Full Quadratic')
    Reg = MultiPolyRegress(Data,R,2);
end

end