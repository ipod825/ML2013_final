function varargout = guidisplay(varargin)
% GUIDISPLAY MATLAB code for guidisplay.fig
%      GUIDISPLAY, by itself, creates a new GUIDISPLAY or raises the existing
%      singleton*.
%
%      H = GUIDISPLAY returns the handle to a new GUIDISPLAY or the handle to
%      the existing singleton*.
%
%      GUIDISPLAY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIDISPLAY.M with the given input arguments.
%
%      GUIDISPLAY('Property','Value',...) creates a new GUIDISPLAY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guidisplay_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guidisplay_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guidisplay

% Last Modified by GUIDE v2.5 21-Dec-2013 21:55:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guidisplay_OpeningFcn, ...
                   'gui_OutputFcn',  @guidisplay_OutputFcn, ...
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



% --- Executes just before guidisplay is made visible.
function guidisplay_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guidisplay (see VARARGIN)

% Choose default command line output for guidisplay
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes guidisplay wait for user response (see UIRESUME)
% uiwait(handles.figure1);
 handles.label={'Mouse','Bull','Tiger','Rabbit','Dragon','Snake','Horse','Goat','Moncky','Chicken','Dog','Pig'};
 handles.degree=0;
 handles.flipx=false;
[handles.Y handles.X handles.imgh handles.imgw]=readmatrix('./ml2013final_train.dat');

guidata(hObject,handles);
set(handles.imgIndSlider,'value',1);
set(handles.imgIndSlider,'Max',size(handles.Y,1));
step=1/size(handles.Y,1);
set(handles.imgIndSlider,'SliderStep',[step 5*step]);
pushbutton1_Callback(hObject, eventdata, handles);

% --- Outputs from this function are returned to the command line.
function varargout = guidisplay_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imgInd=str2double(get(handles.imgIndText,'String'));
set(handles.imgIndSlider,'value',imgInd);
handles.degree=0;
guidata(hObject,handles);
showTextImg(handles,imgInd);


function imgIndText_Callback(hObject, eventdata, handles)
% hObject    handle to imgIndText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of imgIndText as text
%        str2double(get(hObject,'String')) returns contents of imgIndText as a double


% --- Executes during object creation, after setting all properties.
function imgIndText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imgIndText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function imgIndSlider_Callback(hObject, eventdata, handles)
% hObject    handle to imgIndSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
imgInd=floor(get(hObject,'value'));
set(handles.imgIndText,'String',num2str(imgInd));
handles.degree=0;
guidata(hObject,handles);
showTextImg(handles,imgInd);


% --- Executes during object creation, after setting all properties.
function imgIndSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imgIndSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in turnRightBtn.
function turnRightBtn_Callback(hObject, eventdata, handles)
% hObject    handle to turnRightBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.degree=mod(handles.degree+1,4);
guidata(hObject,handles);
showTextImg(handles);


% --- Executes on button press in turnLeftBtn.
function turnLeftBtn_Callback(hObject, eventdata, handles)
% hObject    handle to turnLeftBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.degree=mod(handles.degree-1,4);
guidata(hObject,handles);
showTextImg(handles);


function showTextImg(handles, imgInd)    
    %axis(handles.textImg);
    if nargin<2 || isempty(imgInd)
        imgInd=str2double(get(handles.imgIndText,'String'));
    end
    img=handles.X(imgInd,:);
    img=reshape(img,handles.imgw,handles.imgh);
    img=full(img);
    a=handles.degree;
    deg=handles.degree*90;
    img=flipdim(imrotate(img,deg),1);
    
    imshow(img);
    set(handles.imgLabel,'String',handles.label{handles.Y(imgInd)});
