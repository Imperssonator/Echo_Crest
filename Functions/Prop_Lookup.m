function out = Prop_Lookup(Name)

disp(Name)
% Given 'Name' (a string), find a Nx1 vector [dd; dp; dh; BP] from the solvent
% library and put it in OUT
L = load('SolvLib.mat');
SolvLib = L.SolvLib;

X = 0;

for i = 1:length(SolvLib)
    if strcmp(SolvLib(i).Name, Name)
        X = i;
    end
end
% disp(X)

out = [SolvLib(X).dd; SolvLib(X).dp; SolvLib(X).dh; SolvLib(X).BP];

end