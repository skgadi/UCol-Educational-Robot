function varargout = Control_Interface(varargin)
% CONTROL_INTERFACE MATLAB code for Control_Interface.fig
%      CONTROL_INTERFACE, by itself, creates a new CONTROL_INTERFACE or raises the existing
%      singleton*.
%
%      H = CONTROL_INTERFACE returns the handle to a new CONTROL_INTERFACE or the handle to
%      the existing singleton*.
%
%      CONTROL_INTERFACE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONTROL_INTERFACE.M with the given input arguments.
%
%      CONTROL_INTERFACE('Property','Value',...) creates a new CONTROL_INTERFACE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Control_Interface_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Control_Interface_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Control_Interface

% Last Modified by GUIDE v2.5 30-Jan-2020 21:13:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Control_Interface_OpeningFcn, ...
                   'gui_OutputFcn',  @Control_Interface_OutputFcn, ...
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

% --- Executes just before Control_Interface is made visible.
function Control_Interface_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Control_Interface (see VARARGIN)

% Choose default command line output for Control_Interface
handles.output = hObject;
%Initial Contidion Buttons 
set(handles.Figura,'units','points');
set(handles.Paro,'Enable','off');
set(handles.Home,'Enable','on');
set(handles.Circulo,'Enable','off');
set(handles.Cuadrado,'Enable','off');
set(handles.Red,'Enable','off');
set(handles.Yellow,'Enable','off');
set(handles.Start_A,'Enable','off');
set(handles.Activar,'Enable','on');
set(handles.Desactivar,'Enable','off');
set(handles.Mostrar,'Enable','off');
set(handles.Desactivar_Nido,'Enable','off');
set(handles.Busqueda_objeto,'Enable','off');
% Update handles structure
% Set icon to button help
[a,map]=imread('Informacion.jpg');
[r,c,d]=size(a);
x=ceil(r/30);
y=ceil(c/30);
g=a(1:x:end,1:y:end,:);
g(g==255)=5.5*255;
set(handles.Inf_home,'CData',g);
set(handles.Inf_Paro,'CData',g);
set(handles.Inf_forma_color,'CData',g);
set(handles.Inf_camara,'CData',g);
guidata(hObject, handles);
%Set titie and image
axes(handles.Camara);
title('Area de trabajo');
a=imread('Works.jpg');
image(a);
axis off
axis image;
% UIWAIT makes Control_Interface wait for user response (see UIRESUME)
% uiwait(handles.Figura);

% --- Outputs from this function are returned to the command line.
function varargout = Control_Interface_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in Home.
function Home_Callback(hObject, eventdata, handles)
%Flags
x=0;
y=0;
z=0;

% Get simulation status value Artificial Vision
if ('stopped'==get_param('Vision', 'SimulationStatus'))
    x=1;
end
% Get simulation status value Automatic Movement
if ('stopped'==get_param('Automatic_Movement', 'SimulationStatus'))
    y=1;
end
% Get simulation status value Starting Position
if ('stopped'~= get_param('Starting_Position', 'SimulationStatus'))
    z=1;
end

% Start algorithm to Starting Position
if (x==1 && y==1 && z~=1)
      set(handles.Paro,'Enable','on');
      set_param('Starting_Position','SimulationCommand', 'Start');
      set(handles.Desactivar_Nido,'Enable','on');
elseif (z==1) %it has already been iniciado Starting Position
   msgbox('Se esta ejecutando la rutina de Home', 'warn','Alerta');     
else          %Error
   msgbox('Se esta ejecutando algo más', 'Error','error');
end
% hObject    handle to Home (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in Activar.
function Activar_Callback(hObject, eventdata, handles)
%Flags
x=0;
y=0;
z=0;

% Get simulation status value Starting Position
if ('stopped'==get_param('Starting_Position', 'SimulationStatus'))
    x=1;
end
% Get simulation status value Automatic Movement
if ('stopped'==get_param('Automatic_Movement', 'SimulationStatus'))
    y=1;
end
% Get simulation status value Artificial Vision
if ('stopped'~= get_param('Vision', 'SimulationStatus'))
    z=1;
end

% Start algorithm to Artificial Vision
if (x==1 && y==1 && z~=1)
    axes(handles.Camara);
    cla;
    set_param('Vision','SimulationCommand','start');
    set(handles.Mostrar,'Enable','on');
    set(handles.Desactivar,'Enable','on');
elseif (z==1)  %it has already been iniciado Artificial Vision
   msgbox('Se esta ejecutando el algoritmo de visión', 'Alerta','warn');     
else           %Error
   msgbox('Se esta ejecutando algo más', 'Error','error');
end
% hObject    handle to Activar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in Desactivar.
% Stop Artificial Vision
function Desactivar_Callback(hObject, eventdata, handles)
set_param('Vision','SimulationCommand','stop');
set(handles.Mostrar,'Value',0);
set(handles.Mostrar,'Enable','off');
set(handles.Desactivar,'Enable','off');
% hObject    handle to Desactivar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in Paro.
% Emergency Stop
function Paro_Callback(hObject, eventdata, handles)
set_param('Starting_Position','SimulationCommand','stop');
set_param('Automatic_Movement','SimulationCommand','stop');
%Reset of Initials Conditions to  Buttons
set(handles.Red,'Enable','off');
set(handles.Yellow,'Enable','off');
set(handles.Circulo,'Enable','off');
set(handles.Cuadrado,'Enable','off');
set(handles.Start_A,'Enable','off');
set(handles.Red,'Value',0);
set(handles.Yellow,'Value',0);
set(handles.Circulo,'Value',0);
set(handles.Cuadrado,'Value',0);
set(handles.Busqueda_objeto,'Enable','off');
% hObject    handle to Paro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in Red.
% Select Color Red
function Red_Callback(hObject, eventdata, handles)
a=get(handles.Red,'Value');
if a==1
    set(handles.Yellow,'Enable','off');
else
    set(handles.Yellow,'Enable','on');
end% hObject    handle to Red (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in Yellow.
% Select Color Yellow
function Yellow_Callback(hObject, eventdata, handles)
b=get(handles.Yellow,'Value');
if b==1
    set(handles.Red,'Enable','off');
else
    set(handles.Red,'Enable','on');
end% hObject    handle to Green (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Start_A.
% Start Automatic Movement
function Start_A_Callback(hObject, eventdata, handles)
%Flags
x=0;
y=0;
z=0;

% Get simulation status value Artificial Vision
if ('stopped'==get_param('Vision', 'SimulationStatus'))
    x=1;
end
% Get simulation status value Starting Position
if ('stopped'==get_param('Starting_Position', 'SimulationStatus'))
    y=1;
end
% Get simulation status value Automatic Movement
if ('stopped'~= get_param('Automatic_Movement', 'SimulationStatus'))
    z=1;
end

if (x==1 && y==1 && z~=1)
      set_param('Automatic_Movement/Vision/Constant1','Value','0');
      set_param('Automatic_Movement/Vision/Constant2','Value','0'); 
      set_param('Automatic_Movement/Vision/Constant3','Value','0'); 
      set_param('Automatic_Movement/Vision/Constant4','Value','0'); 
      set_param('Automatic_Movement','SimulationCommand', 'Start');
      set(handles.Red,'Enable','on');
      set(handles.Yellow,'Enable','on');
      set(handles.Circulo,'Enable','on');
      set(handles.Cuadrado,'Enable','on');
      set(handles.Busqueda_objeto,'Enable','on');
elseif (z==1) %%it has already been iniciado Automatic Movement
   msgbox('Se esta ejecutando la rutina movimiento automatico', 'warn','Alerta');     
else          %Error
   msgbox('Se esta ejecutando algo más', 'Error','error');
end% hObject    handle to Start_A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in Circulo.
% Select Shape Circle
function Circulo_Callback(hObject, eventdata, handles)
c=get(handles.Circulo,'Value');
if c==1
    set(handles.Cuadrado,'Enable','off');
else
    set(handles.Cuadrado,'Enable','on');
end% hObject    handle to Circulo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in Cuadrado.
%Select Shape Square
function Cuadrado_Callback(hObject, eventdata, handles)
a=get(handles.Cuadrado,'Value');
if a==1
    set(handles.Circulo,'Enable','off');
else
    set(handles.Circulo,'Enable','on');
end% hObject    handle to Cuadrado (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%
% --- Executes on button press in Inf_forma_color.
function Inf_forma_color_Callback(hObject, eventdata, handles)
pos=get(handles.Figura,'position');
%Properties message 
w_0=pos(3);
h_0=pos(4);
we=450;
hi=160;
%Message
h=msgbox({'Estos botones permiten manipular objetos con forma y color especificos. Para mover los objetos es necesario seleccionar si el objeto es rojo o amarillo y si es un circulo o un cuadrado.';
    'En caso de no cumplir con lo anterior no se podra hacer uso de la rutina de movmiento automático y el manipulador estará en estado de espera.';
    'La desactivación de la rutina requiere que se presione el PARO DE EMERGENCIA.';
    'Los botones deben ser presionados solo una vez.'},'Información de uso. Movimiento automático', 'help');% hObject    handle to Inf_forma_color (see GCBO)
set(h, 'position', [(w_0/2-we/3) (h_0/2-hi/2) we hi]);
object_handles = findall(h);
set(object_handles(6), 'FontSize', 12, 'HorizontalAlignment', 'left','VerticalAlignment','bottom');
set(object_handles(2), 'position',[(we/2)-20 7 40 17]);
set(object_handles(3), 'position',[7 (hi/2-12) 24 24]);% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in Inf_home.
function Inf_home_Callback(hObject, eventdata, handles)
pos=get(handles.Figura,'position');
%Properties message 
w_0=pos(3);
h_0=pos(4);
we=450;
hi=130;
%Mesagge
h=msgbox({'Estos botones colocan al manipulador a su posición inicial. El botón ACTIVAR HOME es necesario de activar siempre que se valla a usar por primera vez o después de concluir de mover objetos.';
    'ACTIVAR HOME debe ser presionando solo una vez y si esta se esta ejecutando otra rutina, no se debe presionar.';
    'El botón DESACTIVAR HOME desactiva la rutina una vez concluida.'},'Información de uso. Posición inicial', 'help');% hObject    handle to Inf_forma_color (see GCBO)
set(h, 'position', [(w_0/2-we/3) (h_0/2-hi/2) we hi]);
object_handles = findall(h);
set(object_handles(6), 'FontSize', 12, 'HorizontalAlignment', 'left','VerticalAlignment','bottom');
set(object_handles(2), 'position',[(we/2)-20 7 40 17]);
set(object_handles(3), 'position',[7 (hi/2-12) 24 24]);% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in Inf_Paro.
function Inf_Paro_Callback(hObject, eventdata, handles)
pos=get(handles.Figura,'position');
%Properties message 
w_0=pos(3);
h_0=pos(4);
we=460;
hi=120;
%Mesagge
h=msgbox({'Manera rápida de detener todo proceso ejectado en Simulink en caso de una alguna falla en el funcionamiento de la plataforma.';
    'En caso de ser presionado, es necesario colocar el manipulador en su posición de inicio para poder mover objetos o para ver funcionar el algoritmo de visión artifical.'},'Información de uso', 'help');% hObject    handle to Inf_forma_color (see GCBO)
set(h, 'position', [(w_0/2-we/3) (h_0/2-hi/2) we hi]);
object_handles = findall(h);
set(object_handles(6), 'FontSize', 12, 'HorizontalAlignment','left','VerticalAlignment','bottom');
set(object_handles(2), 'position',[(we/2)-20 7 40 17]);
set(object_handles(3), 'position',[7 (hi/2-12) 24 24]);% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in Inf_camara.
function Inf_camara_Callback(hObject, eventdata, handles)
pos=get(handles.Figura,'position');
%Properties message 
w_0=pos(3);
h_0=pos(4);
we=450;
hi=170;
%Mesagge
h=msgbox({'Estos botones permiten visializar objetos en área de trabajo del manipulador sin necesidad de activar la rutina de movimiento automatico';
    'Antes de ser activado se debe verificar que el robot no se encuentre en el área de trabajo.';
    'El botón ACTIVAR CÁMARA debe ser presionando solo una vez y si esta se esta ejecutando otra rutina, no se debe presionar.';
    'Para poder visualizar objetos se necesita presionar el botón MOSTRAR IMAGEN, el cual deplegara una imagen con los objetos.';},'Información de uso', 'help');% hObject    handle to Inf_forma_color (see GCBO)
set(h, 'position', [(w_0/2-we/3) (h_0/2-hi/2) we hi]);
object_handles = findall(h);
set(object_handles(6), 'FontSize', 12, 'HorizontalAlignment', 'left','VerticalAlignment','bottom');
set(object_handles(2), 'position',[(we/2)-20 7 40 17]);
set(object_handles(3), 'position',[7 (hi/2-12) 24 24]);% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function Start_A_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Start_A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function Camara_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Camara (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: place code in OpeningFcn to populate Camara

% --- Executes on button press in Busqueda_objeto.
% Search object
function Busqueda_objeto_Callback(hObject, eventdata, handles)
% Get state buttons shape and color
a=get(handles.Red,'Value');
b=get(handles.Yellow,'Value');
c=get(handles.Circulo,'Value');
e=get(handles.Cuadrado,'Value');

if ((a==1 || b==1) && (c==1 || e==1))
    %Display image 
    cla;
    axes(handles.Camara);
    imagens=getappdata(0,'Name');
    imshow(imagens);
    
    %Select color Red
    if (a==1)
    find_system('Name','Automatic_Movement');
    set_param('Automatic_Movement/Vision/Constant2','Value','1');
    set_param('Automatic_Movement/Vision/Constant1','Value','0'); 
    end
    
    %Select color Yellow
    if (b==1)
    find_system('Name','Automatic_Movement');
    set_param('Automatic_Movement/Vision/Constant2','Value','0');
    set_param('Automatic_Movement/Vision/Constant1','Value','1');
    end
    
    %Select shape Circle
    if (c==1)
    find_system('Name','Automatic_Movement');
    set_param('Automatic_Movement/Vision/Constant3','Value','1');
    set_param('Automatic_Movement/Vision/Constant4','Value','0');
    end
    
    %Select shape Square
    if (e==1)
    find_system('Name','Automatic_Movement');
    set_param('Automatic_Movement/Vision/Constant3','Value','0');
    set_param('Automatic_Movement/Vision/Constant4','Value','1');
    end
else     %Error
   h=msgbox('No se ha seleccionado un color y una forma.','Error','error'); 
end% hObject    handle to Busqueda_objeto (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in Mostrar.
%Display image to axes
function Mostrar_Callback(hObject, eventdata, handles)
cla;
set(handles.Desactivar,'Enable','on');
if(1==get(hObject,'Value'))
 axes(handles.Camara);
 imagen = getappdata(0,'Name');
 imshow(imagen);
 title('Area de trabajo');
 drawnow update
end
% hObject    handle to Mostrar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of Mostrar

% --- Executes during object creation, after setting all properties.
function Busqueda_objeto_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Busqueda_objeto (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes on button press in Desactivar_Nido.
%Stop Starting Position
function Desactivar_Nido_Callback(hObject, eventdata, handles)
set(handles.Start_A,'Enable','on');
set_param('Starting_Position','SimulationCommand', 'Stop');
set(handles.Desactivar_Nido,'Enable','off');% hObject    handle to Desactivar_Nido (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
