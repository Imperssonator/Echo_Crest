function out = obj_fun(vt,mob,mob0)

mob_range = 0.25;
vt_range = 50;
vt_target = 10;

if (mob-mob0)<=0
    if vt<vt_target
        out = abs((mob-mob0)) / mob_range;
    else
        out = abs((mob-mob0)) / mob_range + abs((vt-vt_target)) / vt_range;
    end
end

end