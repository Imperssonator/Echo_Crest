function [MobSort, GroupSort, Filtered] = OFETSearch(Constants,Variable)

%OFET Search
%
% OFET Search is the grandaddy master function that takes all the marbles
% 
% Constants is a structure array to specify what process variables to hold
% constant for a given search
% Initialize Constants with:
% Constants = GenerateEmptyConstants()
% This creates an empty struct with fields the same as OFET Database
% Fill it out like this:
%
% Ex. Constants.SubsTreat = {'HMDS','None'}
% This would return devices with either HMDS or no surface modification
%
% Constants.Mn = [30 60] would return devices with Mn between 30 and 60
%
% Constants.SonicationTime = NaN would return devices that have not been
% sonicated

% And what variable you want to plot mobility against (must also be a valid process field):
% 'Variable'

% Returns :
% MobSort, mobility in a column vector sorted according to the column
% vector 'GroupSort'
%
% GroupSort, a column vector (if numeric) or column cell array of
% 'Variable' values for the mobilities in 'MobSort'
%
% Filtered, a structure array with the devices that satisfy the specified
% 'Constants'

load('OFETDatabase.mat');

% Keep the devices that satisfy all the constants

Filtered = OFETFilter(OFET,Constants);

% If this variable is only NaN's and Numbers, Use OFETNumVar, else use
% OFETTextVar

if isnumeric([Filtered(:).(Variable)])
    [MobSort, GroupSort] = OFETNumVar(Filtered,Variable);
else
    [MobSort, GroupSort] = OFETTextVar(Filtered,Variable);
end

end

function [MobSort, GroupSort] = OFETNumVar(Filtered,Variable)

% Remove Devices that don't have a reported value for "Variable"

Filtered = RemoveNans(Filtered,Variable);
Groups = zeros(length(Filtered),1);
Mobs = zeros(length(Filtered),1);

for i = 1:length(Filtered)      % Build up the either numeric or string matrix 'Groups'
    Groups(i,1) = Filtered(i).(Variable);
    Mobs(i,1) = Filtered(i).RTMob;  % and the corresponding mobilities
end

% Sort the data so the variables are in increasing order

[GroupSort, idx] = sort(Groups);    % sort the groups in ascending order
MobSort = Mobs(idx,1);  % Also apply ths sorting to mobilities

GoodScatter(GroupSort,MobSort);
xlabel(Variable)
ylabel('Mobility (cm^2/Vs)')

end

function [MobSort, GroupSort] = OFETTextVar(Filtered,Variable)

% Insert 'None' for NaN values...

Filtered = RemoveNanInsertNone(Filtered,Variable);
Groups = cell(length(Filtered),1);
Mobs = zeros(length(Filtered),1);

for i = 1:length(Filtered)      % Build up the either numeric or string matrix 'Groups'
    Groups{i,1} = Filtered(i).(Variable);
    Mobs(i,1) = Filtered(i).RTMob;  % and the corresponding mobilities
end

% Sort the data so the variables are in increasing order

[GroupSort, idx] = sort(Groups);    % sort the groups in ascending order
MobSort = Mobs(idx,1);  % Also apply ths sorting to mobilities

GoodBox(GroupSort,MobSort);
xlabel(Variable)
ylabel('Mobility (cm^2/Vs)')

end
