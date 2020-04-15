function varargout = GUImrivolume(varargin)
% GUIMRIVOLUME MATLAB code for GUImrivolume.fig
%      GUIMRIVOLUME, by itself, creates a new GUIMRIVOLUME or raises the existing
%      singleton*.
%
%      H = GUIMRIVOLUME returns the handle to a new GUIMRIVOLUME or the handle to
%      the existing singleton*.
%
%      GUIMRIVOLUME('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIMRIVOLUME.M with the given input arguments.
%
%      GUIMRIVOLUME('Property','Value',...) creates a new GUIMRIVOLUME or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUImrivolume_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUImrivolume_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUImrivolume

% Last Modified by GUIDE v2.5 14-Apr-2020 22:39:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUImrivolume_OpeningFcn, ...
                   'gui_OutputFcn',  @GUImrivolume_OutputFcn, ...
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


% --- Executes just before GUImrivolume is made visible.
function GUImrivolume_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUImrivolume (see VARARGIN)

% Choose default command line output for GUImrivolume
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUImrivolume wait for user response (see UIRESUME)
% uiwait(handles.MRIdisplay);


% --- Outputs from this function are returned to the command line.
function varargout = GUImrivolume_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function MRIdisplay_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to MRIdisplay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in toolboxcheck_pushbutton.
function toolboxcheck_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to toolboxcheck_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
test = license('test','image_toolbox');
if test == 0
    disp('To run this project you must have the Image Processing Toolbox. It looks like you do not have it and you should please install it before using this program.')
else
    disp('The test to check if you have the Image Processing Toolbox is approved.')
end

% --- Executes on button press in LoadData_pushbutton.
function LoadData_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to LoadData_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filenames,filepath] = uigetfile('*.dcm', 'Select all the MRI images to be analyzed','Multiselect', 'on');
nfiles = length(filenames);

for i = 1:nfiles
    info = dicominfo(filenames{i});
    file = fullfile(filepath,filenames{i});
    image = dicomread(file);
end
mri1 = dicomread(info(1));
axes(handles.axes1)
imagesc(mri1);

% --- Executes on button press in Threshold_pushbutton.
function Threshold_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Threshold_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ROI_pushbutton.
function ROI_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ROI_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Volume_pushbutton.
function Volume_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Volume_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ROIthreshold_pushbutton.
function ROIthreshold_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ROIthreshold_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
