function Updated = AddSolventProps(Old)

%% Add Solvent Props
% Takes an OFET structure as an input and outputs Updated structure with
% HR, BP, and other relevant solvent properties added on

Solv1 = Old.Solv1;
Solv2 = Old.Solv2;
VFSolv1 = Old.VFSolv1;
Updated = Old;

if isnan(Solv2)
%     disp(Old.Author)
    SolvProps = Prop_Lookup(Solv1);
    P3HTProps = Prop_Lookup('P3HT');
    HR = sqrt(sum([4; 1; 1].*([SolvProps(1:3)-P3HTProps(1:3)].^2)));
    Updated.HR = HR;
    Updated.BP = SolvProps(4);
else
%     disp(Old.Author)
    Solv1Props = Prop_Lookup(Solv1);
    Solv2Props = Prop_Lookup(Solv2);
    P3HTProps = Prop_Lookup('P3HT');
    SolvVector = VFSolv1*Solv1Props(1:4)+(1-VFSolv1)*Solv2Props(1:4);  % Weighted Average of solvent properties to determine an "observed" solvent
    HR = sqrt(sum([4; 1; 1].*([SolvVector(1:3)-P3HTProps(1:3)].^2)));
    Updated.HR = HR;
    Updated.BP = SolvVector(4);
end

end
