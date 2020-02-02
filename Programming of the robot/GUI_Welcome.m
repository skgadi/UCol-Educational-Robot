function varargout = GUI_Welcome(varargin)
% GUI_WELCOME MATLAB code for GUI_Welcome.fig
%      GUI_WELCOME, by itself, creates a new GUI_WELCOME or raises the existing
%      singleton*.
%
%      H = GUI_WELCOME returns the handle to a new GUI_WELCOME or the handle to
%      the existing singleton*.
%
%      GUI_WELCOME('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_WELCOME.M with the given input arguments.
%
%      GUI_WELCOME('Property','Value',...) creates a new GUI_WELCOME or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Welcome_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Welcome_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Welcome

% Last Modified by GUIDE v2.5 30-Jan-2020 21:12:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Welcome_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Welcome_OutputFcn, ...
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


% --- Executes just before GUI_Welcome is made visible.
function GUI_Welcome_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Welcome (see VARARGIN)

% Choose default command line output for GUI_Welcome
handles.output = hObject;
%Set image to GUI.PNG 
set(handles.figure1,'units','points');
axes(handles.axes2);
a=imread('GUI.png');
image(a);
axis off;
axis image;
set(handles.Empezar,'Enable','off');
%Set image to Buttons
[a,map]=imread('Informacion.jpg');
[r,c,d]=size(a);
x=ceil(r/30);
y=ceil(c/30);
g=a(1:x:end,1:y:end,:);
g(g==255)=5.5*255;
set(handles.Ayuda,'CData',g)
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_Welcome wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = GUI_Welcome_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in Empezar.
%Function to Start the interface secondary
function Empezar_Callback(hObject, eventdata, handles)
close all;
%Prepare and open files of simulink 
find_system('Name','Starting_Position');
open_system('Starting_Position');
find_system('Name','Automatic_Movement');
open_system('Automatic_Movement');
find_system('Name','Vision');
open_system('Vision');
evalin('base', 'Parameters');
%Function to Start the interface secondary
Control_Interface;
% hObject    handle to Empezar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in Ayuda.
%Mesage to user about how to use the GUI
function Ayuda_Callback(hObject, eventdata, handles)
pos=get(handles.figure1,'position');
%Dimension of alert
w_0=pos(3);
h_0=pos(4);
we=430;
hi=185;
%Message
h=msgbox({'La plataforma educativa cuenta con secuencias establecidas que permiten su adecuado uso. Tome en cuenta lo siguiente:';
    '1° Existen 3 rutinas o formas de trabajar: POSICIÓN INICIAL, prepara al manipulador listo para trabajar; MOVIMIENTO AUTOMÁTICO, permite que el manipulador mueva objetos por forma y color; VISIÓN ARTIFICIAL, da al usuario la oportunidad de ver trabajar el algorimo de visión artificial.';
    '2° Siempre que se inicie por primera vez una rutina o al presionar el paro de emergencia, colocar el manipulador en posición inicial.';
    '3° Si se esta ejecuntando alguna de las rutinas, NO active ninguna otra.';
    '4° Leer cada una de las opciones de ayuda antes de operar el robot.'},'Intrucciones','warn');% hObject    handle to Inf_forma_color (see GCBO)
%Configurate box mesagge
set(h,'units','points');
set(h, 'position', [(w_0/2-we/3) (h_0/2-hi/4) we hi]);
object_handles = findall(h);
set(object_handles(6), 'FontSize', 11, 'HorizontalAlignment', 'left','VerticalAlignment','bottom');
set(object_handles(2), 'position',[(we/2)-20 7 40 17]);
set(object_handles(3), 'position',[7 (hi/2-12) 24 24]);
set(handles.Empezar,'Enable','on');
% hObject    handle to Ayuda (see GCBO)
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
