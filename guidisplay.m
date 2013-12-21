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

% Last Modified by GUIDE v2.5 21-Dec-2013 15:21:34

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
 global Y X
[Y X]=readmatrix('../final/ml2013final_train.dat');


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
global Y X
ind=str2num(get(handles.index,'String'));
img=find(X(ind,:));
pointNum=size(img,2)
y=zeros(pointNum);
x=zeros(pointNum);
for i=1:pointNum
    [yy xx]=transInd(img(1,i));
    y(i)=yy;
    x(i)=xx;
end
plot(handles.textImg,x,y,'Marker','o','MarkerSize',1,'LineStyle','none');



function index_Callback(hObject, eventdata, handles)
% hObject    handle to index (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of index as text
%        str2double(get(hObject,'String')) returns contents of index as a double


% --- Executes during object creation, after setting all properties.
function index_CreateFcn(hObject, eventdata, handles)
% hObject    handle to index (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
