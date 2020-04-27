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

% --- Executes on button press in toolboxcheck_pushbutton.
function toolboxcheck_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to toolboxcheck_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
test = license('test','image_toolbox');
if test == 0
    set(handles.toolbox_text,'String','Toolbox check: You must have the Image Processing Toolbox. You do NOT have it. Please install it before using this program.')
else
    set(handles.toolbox_text,'String','Toolbox check: The test to check if you have the Image Processing Toolbox is APPROVED.')
end

% --- Executes on button press in LoadData_pushbutton.
function LoadData_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to LoadData_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename,filepath] = uigetfile('*.dcm', 'Select all the MRI images to be analyzed','Multiselect', 'on');

if ~iscell(filename)    %checks if user only selected one file. If so, filename will be put in a cell.
    filename = {filename};
end 

N = length(filename);   %Makes N the number of files the user selected
set(handles.listbox1,'String',filename); 
set(handles.listbox2,'String',filename);
set(handles.listbox3,'String',filename);
set(handles.listbox4,'String',filename);

for i = 1:N % for loop to get the info of the images into a structure names mri
    mri(i).info = dicominfo(filename{i});
    mri(i).images = dicomread(mri(i).info);
end

handles.mri = mri; %defines the mri structure

axes(handles.axes1)
imshow(handles.mri(1).images,[]);%shows the first image in axis 1
guidata(hObject,handles)

% --- Executes on button press in Contrast_pushbutton.
function Contrast_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Contrast_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

mri = handles.mri;
for k = 1:length(mri) %for loop to contrast loaded images
    Con(k).Contrast = imadjustn(mri(k).images); 
end

handles.Con = Con; %Con structure
index = get(handles.listbox2,'value');  %index (what the user selects)

axes(handles.axes2) %axes 2

imshow(handles.Con(index).Contrast,[]);%shows selected contrasted images on axes 2
guidata(hObject,handles)


% --- Executes on button press in ROI_pushbutton.
function ROI_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ROI_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.ROIrules_text, 'Visible', 'on');
axes(handles.axes3)
index = get(handles.listbox2,'value');
imshow(handles.Con(index).Contrast,[]); %sets axes 3 to selected image that's contrasted from axes2

ROI = drawfreehand; %allows user to draw RIO
bw = createMask(ROI); %set bw to RIO 

Con = handles.Con; %handle on contrasted image

for l = 1:length(Con)           % for loop to set contrasted images to OG and Masked
    OGimage(l).OG = handles.Con(l).Contrast;  % sets images to contrasted
    MaskedIm(l).OG = handles.Con(l).Contrast; % sets images to contrasted
end

for k = 1:length(Con)           % for loop to black out images
    OGimage(k).OG(bw) = 225;    % keeps what user selected
    MaskedIm(k).OG(~bw) = 0;    % blacks out what user didn't select
end

handles.MaskedIm = MaskedIm;    % MaskedIm structure

index = get(handles.listbox3,'value');

axes(handles.axes3)
axes(handles.axes4)
imshow(handles.MaskedIm(index).OG,[]); %displays the masked images in axes 3 an 4

guidata(hObject,handles)

set(handles.sliderRule_text, 'Visible', 'on');

% --- Executes on button press in Volume_pushbutton.
function Volume_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Volume_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

mri = handles.mri;
spacing = mri(1).info.PixelSpacing; % extract measurements of the mri data in mm
thickness = mri(1).info.SliceThickness;
pixelArea = spacing(1) * spacing(2); % calculating area then volume per pixel
pixelVolume = pixelArea * thickness;

Thresh = handles.Thresh;

for i = 1:length(Thresh)
    pixels(i) = nnz(Thresh(i).ab); % counting non-zero pixels of the threshhold image and multiplying it by volume per pixel
    vol(i) = pixels(i) * pixelVolume;
    volumeTotal = sum(vol); % summing the volumes of all images
end

handles.Volume = volumeTotal;
volumetext = sprintf('%.3f mm^3', volumeTotal);
set(handles.volume_text, 'String', volumetext);
guidata(hObject,handles);

% --- Executes on button press in ROIthreshold_pushbutton.
function ROIthreshold_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ROIthreshold_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1

index = get(handles.listbox1,'value');  % gets the index of the image selected in the listbox
axes(handles.axes1)
imshow(handles.mri(index).images,[]);


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
return


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


set(handles.slider1, 'min', 50000);
set(handles.slider1, 'max', 70000);
%set(handles.slider1, 'Value', 60000); % Somewhere between max and min.
set(handles.slider1, 'SliderStep', [1/7 , 10/70]);

index = get(handles.listbox4,'value'); %index  = user selection
a = get(hObject, 'Value'); %gets slider value 
[sz_1,sz_2] = size(handles.MaskedIm(index).OG); %finds size of MRI image
Con = handles.Con; %handle on contrasted image



for c = 1:length(Con)
    Thresh(c).ab = zeros(sz_1,sz_2);
    for k = 1:sz_2
        for j = 1:sz_1
            if handles.MaskedIm(c).OG(j,k) > a
               Thresh(c).ab(j,k) = handles.MaskedIm(c).OG(j,k); %sets vector equal to ablation pixel value
            else
               Thresh(c).ab(j,k) = 0;  %everything but ablation pixels = 0
            end
        end
    end
end

handles.Thresh = Thresh;
%index = get(handles.listbox4,'value'); %index  = user selection
caption = sprintf('Slider value = %.3f', a);
set(handles.slider_text, 'String', caption);

axes(handles.axes4);
imshow(handles.Thresh(index).ab,[]);
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function Contrast_Message_Callback(hObject, eventdata, handles)
% hObject    handle to Contrast_Message (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Contrast_Message as text
%        str2double(get(hObject,'String')) returns contents of Contrast_Message as a double


% --- Executes during object creation, after setting all properties.
function Contrast_Message_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Contrast_Message (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2
index = get(handles.listbox2,'value'); %gets index (what image to show) that user selects
axes(handles.axes2) %axes 2
imshow(handles.Con(index).Contrast,[]); %shows contrasted images on axes 2


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in listbox3.
function listbox3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox3index = get(handles.listbox2,'value');

index = get(handles.listbox3,'value');
axes(handles.axes3)
imshow(handles.MaskedIm(index).OG,[]); %displays the masked images

% --- Executes during object creation, after setting all properties.
function listbox3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in listbox4.
function listbox4_Callback(hObject, eventdata, handles)
% hObject    handle to listbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox4

index = get(handles.listbox4,'value');
axes(handles.axes4);
imshow(handles.Thresh(index).ab,[]);

% --- Executes during object creation, after setting all properties.
function listbox4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
