function handles = get_fits(handles)

opts = handles.options;

handles.reg1 = MultiPolyRegress(opts.selData,opts.selR,1);
handles.reg2 = MultiPolyRegress(opts.selData,opts.selR,2);

end