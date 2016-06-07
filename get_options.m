function options = get_options(handles)

options = struct();

% Design Mode - Steepest Ascent or whatever
designModeContents = get(handles.designMode,'String');
options.designMode = lower(designModeContents{get(handles.designMode,'Value')});

% Response Function - name of function m file
options.funStr = get(handles.funStr,'String');


% Selected Data - Get the Data and Response from the selected rows of the
% table

% Get rows
options.selRows = unique(handles.selDataInds(:,1));

% Get a matrix of the data
selDataMat = get(handles.dataTable,'Data');
options.selData = selDataMat(options.selRows,1:end-1);
options.selR = selDataMat(options.selRows,end);


% Display Model - which model to show the parameters for
dispModelContents = get(handles.dispModel,'String');
options.dispModel = lower(designModeContents{get(handles.dispModel,'Value')});

end