function [] = Build_Solv_Lib()

[ndata, text, alldata] = xlsread('Solvs.xlsx'); % all cells in spreadsheet saved as cell arrays in "alldata"
[m1,n1] = size(alldata);
disp(n1)

SolvLib = struct();

for i = 1:m1
    SolvLib(i).Name = alldata{i,1};
    SolvLib(i).dd = alldata{i,2};
    SolvLib(i).dp = alldata{i,3};
    SolvLib(i).dh = alldata{i,4};
    SolvLib(i).MV = alldata{i,5};
    SolvLib(i).BP = alldata{i,6};
end

save('SolvLib.mat','SolvLib')

end
