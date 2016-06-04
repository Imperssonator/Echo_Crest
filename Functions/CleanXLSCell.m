function Updated = CleanXLSCell(Old)

% Takes a cell array "old" and removes any rows or columns that are
% entirely full of NaN's

[m, n] = size(Old);

GoodRows = [];
GoodCols = [];

for i = 1:m
    if all(isnan([Old{i,:}]))
    else
        GoodRows = [GoodRows i];
    end
end

for j = 1:n
    if all(isnan([Old{:,j}]))
    else
        GoodCols = [GoodCols j];
    end
end

Updated = Old(GoodRows,GoodCols);

end

        