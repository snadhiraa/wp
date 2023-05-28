function varargout = ProyekAkhir_ShofiaAtikaNadhira(varargin)
% PROYEKAKHIR_SHOFIAATIKANADHIRA MATLAB code for ProyekAkhir_ShofiaAtikaNadhira.fig
%      PROYEKAKHIR_SHOFIAATIKANADHIRA, by itself, creates a new PROYEKAKHIR_SHOFIAATIKANADHIRA or raises the existing
%      singleton*.
%
%      H = PROYEKAKHIR_SHOFIAATIKANADHIRA returns the handle to a new PROYEKAKHIR_SHOFIAATIKANADHIRA or the handle to
%      the existing singleton*.
%
%      PROYEKAKHIR_SHOFIAATIKANADHIRA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROYEKAKHIR_SHOFIAATIKANADHIRA.M with the given input arguments.
%
%      PROYEKAKHIR_SHOFIAATIKANADHIRA('Property','Value',...) creates a new PROYEKAKHIR_SHOFIAATIKANADHIRA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ProyekAkhir_ShofiaAtikaNadhira_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ProyekAkhir_ShofiaAtikaNadhira_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ProyekAkhir_ShofiaAtikaNadhira

% Last Modified by GUIDE v2.5 22-May-2023 07:19:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ProyekAkhir_ShofiaAtikaNadhira_OpeningFcn, ...
                   'gui_OutputFcn',  @ProyekAkhir_ShofiaAtikaNadhira_OutputFcn, ...
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


% --- Executes just before ProyekAkhir_ShofiaAtikaNadhira is made visible.
function ProyekAkhir_ShofiaAtikaNadhira_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ProyekAkhir_ShofiaAtikaNadhira (see VARARGIN)

% Choose default command line output for ProyekAkhir_ShofiaAtikaNadhira
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ProyekAkhir_ShofiaAtikaNadhira wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ProyekAkhir_ShofiaAtikaNadhira_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in show.
function show_Callback(hObject, eventdata, handles)
% hObject    handle to show (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

datatabel = readcell('eyecare.csv', 'range', 'B2:J222');
set(handles.uitable1,'ColumnName',["Brand","Name","Price","Number of Reviews","Number of Loves","Review Score","Size","Clean Product","Category"]);
set(handles.uitable1,'data',datatabel);

% --- Executes on button press in clear.
function clear_Callback(hObject, eventdata, handles)
% hObject    handle to clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.uitable1,'ColumnName','');
set(handles.uitable1,'data','')
set(handles.price,'String','');
set(handles.n_of_loves,'String','');
set(handles.score,'String','');
set(handles.rank,'String','');
set(handles.tb2,'ColumnName','');
set(handles.tb2,'data','');

% --- Executes on button press in hasil.
function hasil_Callback(hObject, eventdata, handles)
% hObject    handle to hasil (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%data
opts = detectImportOptions('eyecare.csv');
opts.SelectedVariableNames = [4 6 7];
x = readmatrix('eyecare.csv',opts);

%atribut tiap kriteria, nilai 0=atribut biaya/cost, 1=atribut keuntungan/benefit
k = [0,1,1];

%input nilai bobot setiap kriteria
price = str2double(get(handles.price,'String'));
n_of_loves = str2double(get(handles.n_of_loves,'String'));
reviews_score = str2double(get(handles.score,'String'));

w = [price n_of_loves reviews_score];

%normalisasi bobot
%inisialisasi ukuran x
[m,n]=size (x);

%membagi bobot per kriteria dengan jumlah total seluruh bobot
w=w./sum(w);

%menentukan nilai vektor S
%perhitungan vektor S per baris (alternatif)
for j=1:n,
    if k(j)==0, w(j)=-1*w(j);
    end;
end;

for i=1:m,
    S(i)=prod(x(i,:).^w);
end;

%proses perankingan
V= S/sum(S);

%meranking nilai vektor V
vmax=max(V);

set(handles.rank,'String',vmax);

%mengurutkan data dari nilai tertinggi
[dataurut, index] = sort(V,'descend');
i=index(1);
%index[1] = index tertinggi
%dataurut = nilai preferensi tertinggi

%menampilkan data yang merupakan hasil terbaik
opts = detectImportOptions('eyecare.csv');
opts.SelectedVariableNames = (2:10);
tampil = readcell('eyecare.csv',opts);
rincian=tampil(i,:);
set(handles.tb2,'ColumnName',["Brand","Name","Price","Number of Reviews","Number of Loves","Review Score","Size","Clean Product","Category"]);
set(handles.tb2,'data',rincian);


function price_Callback(hObject, eventdata, handles)
% hObject    handle to price (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of price as text
%        str2double(get(hObject,'String')) returns contents of price as a double


% --- Executes during object creation, after setting all properties.
function price_CreateFcn(hObject, eventdata, handles)
% hObject    handle to price (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function n_of_loves_Callback(hObject, eventdata, handles)
% hObject    handle to n_of_loves (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of n_of_loves as text
%        str2double(get(hObject,'String')) returns contents of n_of_loves as a double


% --- Executes during object creation, after setting all properties.
function n_of_loves_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n_of_loves (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function score_Callback(hObject, eventdata, handles)
% hObject    handle to score (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of score as text
%        str2double(get(hObject,'String')) returns contents of score as a double


% --- Executes during object creation, after setting all properties.
function score_CreateFcn(hObject, eventdata, handles)
% hObject    handle to score (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
