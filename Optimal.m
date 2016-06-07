function varargout = Optimal(varargin)
% OPTIMAL MATLAB code for Optimal.fig
%      OPTIMAL, by itself, creates a new OPTIMAL or raises the existing
%      singleton*.
%
%      H = OPTIMAL returns the handle to a new OPTIMAL or the handle to
%      the existing singleton*.
%
%      OPTIMAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OPTIMAL.M with the given input arguments.
%
%      OPTIMAL('Property','Value',...) creates a new OPTIMAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Optimal_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Optimal_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Optimal

% Last Modified by GUIDE v2.5 07-Jun-2016 17:00:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Optimal_OpeningFcn, ...
                   'gui_OutputFcn',  @Optimal_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Optimal is made visible.
function Optimal_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Optimal (see VARARGIN)

% Choose default command line output for Optimal
handles.output = hObject;
set(handles.dataTable,'Data',zeros(str2num(get(handles.initRows,'String')),3));

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Optimal wait for user response (see UIRESUME)
% uiwait(handles.figure1);



% --- Executes on button press in modelFit.
function modelFit_Callback(hObject, eventdata, handles)
% hObject    handle to modelFit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.options = get_options(handles);
handles = get_fits(handles);

set(handles.PMtable,'Data',num2cell(handles.reg1.PowerMatrix));
set(handles.Ctable,'Data',num2cell(handles.reg1.Coefficients));

guidata(hObject, handles);


% --- Executes on button press in nextPts.
function nextPts_Callback(hObject, eventdata, handles)
% hObject    handle to nextPts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.options = get_options(handles);
handles = get_next_pts(handles);

% --- Executes on button press in curvCheck.
function curvCheck_Callback(hObject, eventdata, handles)
% hObject    handle to curvCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.options = get_options(handles);
handles = check_curvature(handles);

set(handles.curvStatus,'String',num2str(handles.curvTest));

guidata(hObject, handles);

% --- Executes when selected cell(s) is changed in dataTable.
function dataTable_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to dataTable (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)

if size(eventdata.Indices,1)>0
    handles.selDataInds = eventdata.Indices;
end

guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = Optimal_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function funStr_Callback(hObject, eventdata, handles)
% hObject    handle to funStr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of funStr as text
%        str2double(get(hObject,'String')) returns contents of funStr as a double


% --- Executes during object creation, after setting all properties.
function funStr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to funStr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in dispModel.
function dispModel_Callback(hObject, eventdata, handles)
% hObject    handle to dispModel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns dispModel contents as cell array
%        contents{get(hObject,'Value')} returns selected item from dispModel


% --- Executes during object creation, after setting all properties.
function dispModel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dispModel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in designMode.
function designMode_Callback(hObject, eventdata, handles)
% hObject    handle to designMode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns designMode contents as cell array
%        contents{get(hObject,'Value')} returns selected item from designMode


% --- Executes during object creation, after setting all properties.
function designMode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to designMode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function initRows_Callback(hObject, eventdata, handles)
% hObject    handle to initRows (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of initRows as text
%        str2double(get(hObject,'String')) returns contents of initRows as a double

set(handles.dataTable,'Data',zeros(str2num(get(handles.initRows,'String')),3));

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function initRows_CreateFcn(hObject, eventdata, handles)
% hObject    handle to initRows (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


