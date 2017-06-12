function fits = get_all_fits(X,Y,maxDeg)

Data = [];
Terms = [];
for d = 1:maxDeg
    Data = [Data, X.^d];
    Terms = [Terms, [repmat(d,[1,size(X,2)]); (1:size(X,2))]];
end

% Now Data looks like this:

% | x1^1 x2^1 x3^1... x1^2 x2^2 x3^2... |
% | x1^1 ... ...

% And Terms is this:

% | 1    1    1  ...  2    2     2 ...  |
% | 1    2    3  ...  1    2     3 ...  |

numDims = size(Data,2);    % Dimensionality of space
numPts = size(Data,1);     % Number of data points

numCombos = 0;
for i = 1:numPts-1          % Only want m-1 terms otherwise model will be overspec'd for sure
    numCombos = numCombos+nchoosek(numDims,i);
end

reg_struct = struct(numCombos,1);
combo_count = 0;
for p = 1:numPts-1
    Combos_p = nchoosek((1:numDims),p);
    for j = 1:size(Combos_p,1)
        combo_count = combo_count+1;
        reg_struct(combo_count).termInds = Combos_p(j,:);
    end
end

disp('Performing regression fits')

for i = 1:numCombos
    reg_struct(i).r = MultiPolyRegress(Data(:,reg_struct(i).termInds),Y,1);
    reg_struct(i).truePM = zeros(length

end

