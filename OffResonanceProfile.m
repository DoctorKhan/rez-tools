function varargout = OffResonanceProfile(varargin)
% OFFRESONANCEPROFILE M-file for OffResonanceProfile.fig
%      OFFRESONANCEPROFILE, by itself, creates a new OFFRESONANCEPROFILE or raises the existing
%      singleton*.
%
%      H = OFFRESONANCEPROFILE returns the handle to a new OFFRESONANCEPROFILE or the handle to
%      the existing singleton*.
%
%      OFFRESONANCEPROFILE('CALLBACK',hObject,eventData,handles,...) calls
%      the local
%      function named CALLBACK in OFFRESONANCEPROFILE.M with the given input arguments.
%
%      OFFRESONANCEPROFILE('Property','Value',...) creates a new OFFRESONANCEPROFILE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OffResonanceProfile_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OffResonanceProfile_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OffResonanceProfile

% Last Modified by GUIDE v2.5 01-Apr-2009 18:43:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OffResonanceProfile_OpeningFcn, ...
                   'gui_OutputFcn',  @OffResonanceProfile_OutputFcn, ...
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
end

% --- Executes just before OffResonanceProfile is made visible.
function OffResonanceProfile_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to OffResonanceProfile (see VARARGIN)

% Choose default command line output for OffResonanceProfile
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes OffResonanceProfile wait for user response (see UIRESUME)
% uiwait(handles.figure1);

updateOffResonancePlot(handles);


end

% --- Outputs from this function are returned to the command line.
function varargout = OffResonanceProfile_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end

% --- Executes on slider movement.
function TRSlider_Callback(hObject, eventdata, handles)
% hObject    handle to TRSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sliderValue = get(handles.TRSlider, 'Value');
set(handles.TREdit, 'String', num2str(sliderValue));
updateOffResonancePlot(handles);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
end

% --- Executes during object creation, after setting all properties.
function TRSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TRSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

end

function updateOffResonancePlot(handles)
    [mTransverse, mPhase] = OffResonanceProfileAnalytic(get(handles.TRSlider, 'Value'), (pi/180)*get(handles.AlphaSlider, 'Value'));
    tr = get(handles.TRSlider, 'Value');
    mTransverse(1,:) = (mTransverse(1,:)-pi)/(2*pi*tr);
    plotData(mTransverse);
    a = axis;
    a(1) = -0.5/tr; a(2) = -a(1); a(3) = 0;
    axis(a);
    xlabel('Off Resonance Frequency (Hz)')
end


% --- Executes on slider movement.
function AlphaSlider_Callback(hObject, eventdata, handles)
% hObject    handle to AlphaSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
sliderValue = get(handles.AlphaSlider, 'Value');
set(handles.AlphaEdit, 'String', num2str(sliderValue));
updateOffResonancePlot(handles);


updateOffResonancePlot(handles);

end

% --- Executes during object creation, after setting all properties.
function AlphaSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AlphaSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


end



function TREdit_Callback(hObject, eventdata, handles)
% hObject    handle to TREdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TREdit as text
%        str2double(get(hObject,'String')) returns contents of TREdit as a double
SetSliderFromEdit(hObject, handles.TRSlider);
updateOffResonancePlot(handles);


end

% --- Executes during object creation, after setting all properties.
function TREdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TREdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

function AlphaEdit_Callback(hObject, eventdata, handles)
% hObject    handle to AlphaEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AlphaEdit as text
%        str2double(get(hObject,'String')) returns contents of AlphaEdit as a double

SetSliderFromEdit(hObject, handles.AlphaSlider);
updateOffResonancePlot(handles);

end

% --- Executes during object creation, after setting all properties.
function AlphaEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AlphaEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

end
