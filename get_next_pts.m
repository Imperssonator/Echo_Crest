function handles = get_next_pts(handles)

switch lower(handles.options.designMode)
    case 'steepest ascent'
        handles = steep_ascent(handles);
end

end