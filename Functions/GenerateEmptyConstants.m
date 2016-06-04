function Constants = GenerateEmptyConstants()

load('OFETDatabase.mat')

FN = fieldnames(OFET);
Constants = cell2struct(cell(size(FN)),FN,1);

end