function varargout = matrix2latex(varargin)
% MATRIX2LATEX M-file for matrix2latex.fig
%      MATRIX2LATEX, by itself, creates a new MATRIX2LATEX or raises the existing
%      singleton*.
%
%      H = MATRIX2LATEX returns the handle to a new MATRIX2LATEX or the handle to
%      the existing singleton*.
%
%      MATRIX2LATEX('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MATRIX2LATEX.M with the given input arguments.
%
%      MATRIX2LATEX('Property','Value',...) creates a new MATRIX2LATEX or raises
%      the existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before matrix2latex_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to matrix2latex_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
% 
% Copyright 2002-2004 The MathWorks, Inc.
% 
% Last Modified by GUIDE v2.5 15-Sep-2006 22:31:24
% 
%	Author : Zouzias Anastasios
%	Email  : zouzias@ceid.upatras.gr
%	URL    : http://students.ceid.upatras.gr/~zouzias/
%	Copyright 2006 (c) Zouzias Anastasios
% 
% Edited by Alejandro Osses, HTI, TU/e, the Netherlands, 2014
% Last updated: 19/06/2014 % Update this date manually
% Last used   : 19/06/2014 % Update this date manually
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Begin initialization code - DO NOT EDIT

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @matrix2latex_OpeningFcn, ...
                   'gui_OutputFcn',  @matrix2latex_OutputFcn, ...
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes just before matrix2latex is made visible.
function matrix2latex_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to matrix2latex (see VARARGIN)

% Choose default command line output for matrix2latex
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

initialize_gui(hObject, handles, false);

% UIWAIT makes matrix2latex wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Outputs from this function are returned to the command line.
function varargout = matrix2latex_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes during object creation, after setting all properties.
function density_CreateFcn(hObject, eventdata, handles)
% hObject    handle to density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background, change
%       'usewhitebg' to 0 to use default.  See ISPC and COMPUTER.
usewhitebg = 1;
if usewhitebg
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in pushbuttonLatex.
function pushbuttonLatex_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonLatex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 %  'rowLabels', rowLabels, 'columnLabels', columnLabels

 % Check what output the user had chose.
 if ~isempty(get(handles.textboxfilename, 'String') )
    filename = get(handles.textboxfilename, 'String');
 else
     % Means MATLAB COMMAND LINE..
     filename = '__MCL';
 end
 
 
 % Check the format textbox if selected.
 if isequal(handles.radiobuttonformatcustom, 'Value', 1)
    if ~isempty( handles.textboxformat)
        handles.table.format = get(handles.textboxformat, 'String');
    else
        disp('Using format default format %-6.2f')
        handles.table.format = '%-6.2f';
    end
 end
 
 handles.table.fontsize
 if ~isempty(handles.table.matrix)
    latex(handles.table.matrix, filename, 'alignment', handles.table.alignment, 'format', handles.table.format, 'size', handles.table.fontsize ...
        , 'vline', get(handles.checkboxvline, 'Value'), 'hline', get(handles.checkboxhline, 'Value') );
 end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in pushbuttonexit.
function pushbuttonexit_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonexit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Alignmentgroup_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to Alignmentgroup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Alignment left
if  isequal(get(hObject,'String'),'Left')
    handles.table.alignment = 'l';
elseif isequal(get(hObject,'String'),'Center')
    handles.table.alignment = 'c';
elseif isequal(get(hObject,'String'),'Right')
    handles.table.alignment = 'r';
end

% Save the new matrix value
guidata(hObject,handles)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function initialize_gui(fig_handle, handles, isreset)
% If the metricdata field is present and the pushbuttonexit flag is false, it means
% we are we are just re-initializing a GUI by calling it from the cmd line
% while it is up. So, bail out as we dont want to pushbuttonexit the data.
if isfield(handles, 'metricdata') && ~isreset
    return;
end

% Initialize the table properties...

% Matrix is empty..
handles.table.matrix = [];
%Alignment
handles.table.alignment = 'l';
set(handles.radiobuttonleft ,'Value' , 1);
set(handles.radiobuttoncenter ,'Value' , 0);
set(handles.radiobuttonRight ,'Value' , 0);
%fontSize
handles.table.fontsize = 'normalsize';
set(handles.radiobuttontiny ,'Value' , 0);
set(handles.radiobuttonscriptsize ,'Value' , 0);
set(handles.radiobuttonfootnotesize ,'Value' , 0);
set(handles.radiobuttonsmall ,'Value' , 0);
set(handles.radiobuttonNormalsize ,'Value' , 1);
set(handles.radiobuttonlarge ,'Value' , 0);
set(handles.radiobuttonLarge ,'Value' , 0);
set(handles.radiobuttonLARGE ,'Value' , 0);
set(handles.radiobuttonhuge ,'Value' , 0);
set(handles.radiobuttonHuge ,'Value' , 0);

% Make the textbox invisible..
set(handles.textboxfilename,'Visible','off');

% Horizontal and vertical lines..
set(handles.checkboxhline, 'Value', 0);
set(handles.checkboxvline, 'Value', 0);

% Format of the elements.
set(handles.radiobuttonformat3, 'Value', 1);
handles.table.format = '%g';

% Text box format invisible.
set(handles.textboxformat, 'Visible', 'off');

%set(handles.density, 'String', handles.metricdata.density);
%set(handles.volume,  'String', handles.metricdata.volume);
%set(handles.mass, 'String', 0);

%set(handles.Alignmentgroup, 'SelectedObject', handles.english);

%set(handles.text4, 'String', 'lb/cu.in');
%set(handles.text5, 'String', 'cu.in');
%set(handles.text6, 'String', 'lb');

% Update handles structure
guidata(handles.figure1, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in pushbuttonLoad.
function pushbuttonLoad_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonLoad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem with cell arrays!!!
%%%%%%%%%%%%%%%%%%%%%%%%%

% Empty the message of the textbox.
set(handles.statictextinfo,'String', '');

% Get all the variable of the workspace
myvars = evalin('base','who');

% Get the name of the textbox.
matrix = get(handles.textboxmatrix,'String');

if sum(ismember(myvars,matrix)) & ~isempty(evaluatevars(matrix))...
        & ~isa(evaluatevars(matrix),'cell') & ~isa(evaluatevars(matrix),'struct') &...
        isnumeric(evaluatevars(matrix))
    set(handles.statictextinfo,'String','Matrix Successfully loaded...');
    % Save the new matrix value
    handles.table.matrix = evaluatevars(matrix);
    guidata(hObject,handles)
    
elseif ~sum(ismember(myvars,matrix))
    errorstring = sprintf('The variable %s doesn''t exist.', matrix );
    set(handles.statictextinfo,'String', errorstring);
    handles.table.matrix = [];
else
    errorstring = sprintf('The variable %s isn''t a numeric matrix.', matrix );
    set(handles.statictextinfo,'String', errorstring);
    handles.table.matrix = [];
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function textboxmatrix_Callback(hObject, eventdata, handles)
% hObject    handle to textboxmatrix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textboxmatrix as text
%        str2double(get(hObject,'String')) returns contents of textboxmatrix as a double

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes during object creation, after setting all properties.
function textboxmatrix_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textboxmatrix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in radiobutton31.
function radiobutton31_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton31

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function FontSizeGroup_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to FontSizeGroup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


if  isequal(get(hObject,'String'),'tiny')
    handles.table.fontsize = 'tiny';
elseif isequal(get(hObject,'String'),'scriptsize')
    handles.table.fontsize = 'scriptsize';
elseif isequal(get(hObject,'String'),'Footnotesize')
    handles.table.fontsize = 'footnotesize';
elseif isequal(get(hObject,'String'),'Small')
    handles.table.fontsize = 'small';
elseif isequal(get(hObject,'String'),'Normalsize')
    handles.table.fontsize = 'normalsize';
elseif isequal(get(hObject,'String'),'large')
    handles.table.fontsize = 'large';
elseif isequal(get(hObject,'String'),'Large')
    handles.table.fontsize = 'Large';
elseif isequal(get(hObject,'String'),'LARGE')
    handles.table.fontsize = 'LARGE';
elseif isequal(get(hObject,'String'),'huge')
    handles.table.fontsize = 'huge';
elseif isequal(get(hObject,'String'),'Huge')
    handles.table.fontsize = 'Huge';
end

% Save the new matrix value
guidata(hObject,handles)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function textboxfilename_Callback(hObject, eventdata, handles)
% hObject    handle to textboxfilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textboxfilename as text
%        str2double(get(hObject,'String')) returns contents of textboxfilename as a double

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes during object creation, after setting all properties.
function textboxfilename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textboxfilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in radiobuttonoutputfile.
function radiobuttonoutputfile_Callback(hObject, eventdata, handles)
% hObject    handle to radiobuttonoutputfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobuttonoutputfile

% Make the filename textbox visible.
set(handles.textboxfilename,'Visible','on');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in radiobuttonouputmatlab.
function radiobuttonouputmatlab_Callback(hObject, eventdata, handles)
% hObject    handle to radiobuttonouputmatlab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobuttonouputmatlab

set(handles.textboxfilename,'Visible','off');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in checkboxhline.
function checkboxhline_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxhline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxhline


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in checkboxvline.
function checkboxvline_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxvline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxvline


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function textboxformat_Callback(hObject, eventdata, handles)
% hObject    handle to textboxformat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textboxformat as text
%        str2double(get(hObject,'String')) returns contents of textboxformat as a double

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes during object creation, after setting all properties.
function textboxformat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textboxformat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in radiobuttonformat1.
function radiobuttonformat1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobuttonformat1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobuttonformat1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function formatGroup_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to formatGroup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if  isequal(get(hObject,'String'),'%-6.2f')
    handles.table.format = '%-6.2f';
    set(handles.textboxformat,'Visible','off');
elseif isequal(get(hObject,'String'),'%d')
    handles.table.format = '%d';
    set(handles.textboxformat,'Visible','off');
elseif isequal(get(hObject,'String'),'%g')
    handles.table.format = '%g';
    set(handles.textboxformat,'Visible','off');
elseif isequal(get(hObject,'String'),'Custom Select')
    set(handles.textboxformat,'Visible','on');
end

% Save the new matrix value
guidata(hObject,handles)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%