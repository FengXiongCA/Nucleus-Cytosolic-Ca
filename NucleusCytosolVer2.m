function varargout = NucleusCytosolVer2(varargin)
% NUCLEUSCYTOSOLVER2 M-file for NucleusCytosolVer2.fig
%      NUCLEUSCYTOSOLVER2, by itself, creates a new NUCLEUSCYTOSOLVER2 or raises the existing
%      singleton*.
%
%      H =de NUCLEUSCYTOSOLVER2 returns the handle to a new NUCLEUSCYTOSOLVER2 or the handle to
%      the existing singleton*.
%
%      NUCLEUSCYTOSOLVER2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NUCLEUSCYTOSOLVER2.M with the given input arguments.
%
%      NUCLEUSCYTOSOLVER2('Property','Value',...) creates a new NUCLEUSCYTOSOLVER2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NucleusCytosolVer2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NucleusCytosolVer2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NucleusCytosolVer2

% Last Modified by GUIDE v2.5 18-Sep-2019 11:51:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NucleusCytosolVer2_OpeningFcn, ...
                   'gui_OutputFcn',  @NucleusCytosolVer2_OutputFcn, ...
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


% --- Executes just before NucleusCytosolVer2 is made visible.
function NucleusCytosolVer2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NucleusCytosolVer2 (see VARARGIN)

% Choose default command line output for NucleusCytosolVer2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes NucleusCytosolVer2 wait for user response (see UIRESUME)
% uiwait(handles.NucleusCytosolVer2);


% --- Outputs from this function are returned to the command line.
function varargout = NucleusCytosolVer2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Open_Callback(hObject, eventdata, handles)
% hObject    handle to Open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%it cost time so we here directly load the data
%
[handles.filename, handles.pathname] = uigetfile('C:\xiaoyan\New one\My data\nuclear Ca xiaoyan\*.xls', 'Select an data file');
         
 try [data, txt, raw] =xlsread([handles.pathname handles.filename]);
     SizeColumn=size(data,2);
     if SizeColumn==4
         DataTime=data(:,2);
         DataChannel1=data(:,3);
         DataChannel2=data(:,4);
     elseif SizeColumn==3
         DataTime=data(:,1);
         DataChannel1=data(:,2);
         DataChannel2=data(:,3);
     end
     IX=[];
     IX=find(DataChannel1==0);
     if ~isempty(IX)
         DataTime(IX)=[];
         DataChannel1(IX)=[];
         DataChannel2(IX)=[];
     end
     IX=[];
     IX=find(DataChannel2==0);
     if ~isempty(IX)
         DataTime(IX)=[];
         DataChannel1(IX)=[];
         DataChannel2(IX)=[];
     end
    
catch exception
    warndlg('Excel Data File Reading Error!!!');
    return
    
end


set(handles.axes1,'Visible','on');
axes(handles.axes1);
h_DataChannel1=plot(DataTime,DataChannel1,'g');
set(h_DataChannel1,'Tag','DataChannel1');

set(handles.axes2,'Visible','on');
axes(handles.axes2);
h_DataChannel2=plot(DataTime,DataChannel2,'g');
set(h_DataChannel2,'Tag','DataChannel2');

% DataChannel1(5000:end)=[];
% DataChannel1(5000:end)=[];
FigureUserData=[];
FigureUserData.DataTime=DataTime;
FigureUserData.DataChannel1=DataChannel1;
FigureUserData.DataChannel2=DataChannel2;
set(handles.SmartLab,'UserData',FigureUserData);

linkaxes([handles.axes1 handles.axes2],'x');


guidata(hObject, handles);
return;





% --------------------------------------------------------------------
function APDetect_Callback(hObject, eventdata, handles)
% hObject    handle to APDetect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

h_TempAPBase1=[];
h_TempAPBase1=findobj(get(handles.axes1,'Children'),'Tag','TempAPBase');
h_TempAPBase2=[];
h_TempAPBase2=findobj(get(handles.axes2,'Children'),'Tag','TempAPBase');

h_TempAPDiffMax1=[];
h_TempAPDiffMax1=findobj(get(handles.axes1,'Children'),'Tag','TempAPDiffMax');
h_TempAPDiffMax2=[];
h_TempAPDiffMax2=findobj(get(handles.axes2,'Children'),'Tag','TempAPDiffMax');

h_TempDecayFit1=[];
h_TempDecayFit1=findobj(get(handles.axes1,'Children'),'Tag','TempDecayFit');
h_TempDecayFit2=[];
h_TempDecayFit2=findobj(get(handles.axes2,'Children'),'Tag','TempDecayFit');

h_TempAPPeak1=[];
h_TempAPPeak1=findobj(get(handles.axes1,'Children'),'Tag','TempAPPeak');
h_TempAPPeak2=[];
h_TempAPPeak2=findobj(get(handles.axes2,'Children'),'Tag','TempAPPeak');

h_AddPeakBox=[];
h_AddPeakBox=findobj('Tag','AddPeakBox','Type','line');

try 
    delete(h_TempAPBase1);
    delete(h_TempAPBase2);
    delete(h_TempAPDiffMax1);
    delete(h_TempAPDiffMax2);
    delete(h_TempAPPeak1);
    delete(h_TempAPPeak2);
catch exception
   ; 
end

try 
    delete(h_TempDecayFit1);
    delete(h_TempDecayFit2);
catch exception
   ; 
end

try 
    delete(h_AddPeakBox);
catch exception
    ;
end

FigureUserData=[];
FigureUserData=get(handles.SmartLab,'UserData');
FilterChannel1=FigureUserData.FilterChannel1;
FilterChannel2=FigureUserData.FilterChannel2;
DataTime=FigureUserData.DataTime;
MarkerChannel1=[];
MarkerChannel2=[];


%%
try
    %flip the peak of Channel1 Signal
    NorFilterChannel1=[];
    NorFilterChannel1=(FilterChannel1-min(FilterChannel1))./(max(FilterChannel1)-min(FilterChannel1));
    NorFilterChannel2=[];
    NorFilterChannel2=(FilterChannel2-min(FilterChannel2))./(max(FilterChannel2)-min(FilterChannel2));
    
    
    APPeakTimeIX=[];APPeakValue=[];
    %[APPeakTimeIX APPeakValue]=ActionPotentialPeakDetect(FilterChannel1);
    [APPeakValue,APPeakTimeIX]=findpeaks(NorFilterChannel1,[1:length(DataTime)]','MinPeakHeight',0.7,'MinPeakDistance',150);
    APPeakValue=FilterChannel1(APPeakTimeIX);
    NumberPeak=length(APPeakTimeIX);
    %give ActivationID to the
    ActivationID=[];
    ActivationID=[1:NumberPeak];
    SignalMarkerChannel1.ActivationID=ActivationID;
    SignalMarkerChannel1.APPeakTime=DataTime(APPeakTimeIX);
    SignalMarkerChannel1.APPeakValue=APPeakValue;
    SignalMarkerChannel1.APPeakTimeIX=APPeakTimeIX;
    
    %the second step, find the maximum derivative of each activation
    APMaxDiff=[]; APMaxDiffIX=[];
    APBaseValue=[]; APBaseTimeIX=[];
    PotentialThre=[];
    [APMaxDiff APMaxDiffIX APBaseValue APBaseTimeIX]=ActionPotentialMaxDvdt(FilterChannel1,APPeakTimeIX, APPeakValue);
    
    SignalMarkerChannel1.APMaxDiffValue=APMaxDiff;
    SignalMarkerChannel1.APMaxDiffTime=DataTime(APMaxDiffIX);
    SignalMarkerChannel1.APBaseTime=DataTime(APBaseTimeIX);
    SignalMarkerChannel1.APBaseValue=APBaseValue;
    SignalMarkerChannel1.APMaxDiffTimeIX=APMaxDiffIX;
    SignalMarkerChannel1.APBaseTimeIX=APBaseTimeIX;
    
    
    %the third step, calculate the duration of action potential
    APDThre=[];
    APDDuration=[];
    APDDurationBeginTimeIX=[];
    APDDurationEndTimeIX=[];
    APDDurationEndValue=[];
    [APDDuration APDDurationBeginTimeIX APDDurationEndTimeIX APDDurationEndValue]=ActionPotentialDuration(FilterChannel1,APPeakTimeIX, APPeakValue, APBaseValue);
    APDDurationEndValue=-APDDurationEndValue;
    SignalMarkerChannel1.APDDuration=DataTime(APDDurationEndTimeIX)-DataTime(APDDurationBeginTimeIX);
    SignalMarkerChannel1.APDDurationBeginTime=DataTime(APDDurationBeginTimeIX);
    SignalMarkerChannel1.APDDurationEndTime=DataTime(APDDurationEndTimeIX);
    SignalMarkerChannel1.APDDurationEndValue=APDDurationEndValue;
    SignalMarkerChannel1.APDDurationBeginTimeIX=APDDurationBeginTimeIX;
    SignalMarkerChannel1.APDDurationEndTimeIX=APDDurationEndTimeIX;
    
    
    
    %%
    
    Beta=[];
    % Beta=NonLinearRegression(FilterChannel1,APPeakTime,APBaseTime);
    SignalMarkerChannel1.Beta=Beta;
    
    
    %ChannelSignal2, we will use the first channel as the template to analyze
    APPeakTimeIX2=[];APPeakValue2=[]; DeltaTimeIX=[];
    [APPeakTimeIX2 APPeakValue2 DeltaTimeIX]=FollowActionPotentialPeakDetect(FilterChannel2, APPeakTimeIX, APBaseTimeIX);
    
    NumberPeak=length(APPeakTimeIX2);
    %give ActivationID to the
    ActivationID=[];
    ActivationID=1000+[1:NumberPeak];
    SignalMarkerChannel2.ActivationID=ActivationID;
    SignalMarkerChannel2.APPeakTime=DataTime(APPeakTimeIX2);
    SignalMarkerChannel2.APPeakValue=APPeakValue2;
    SignalMarkerChannel2.APPeakTimeIX=APPeakTimeIX2;
    
    %the second step, find the maximum derivative of each activation
    APMaxDiff2=[]; APMaxDiffIX2=[];
    APBaseValue2=[]; APBaseTimeIX2=[];
    PotentialThre2=[];
    [APMaxDiff2 APMaxDiffIX2 APBaseValue2 APBaseTimeIX2]=FollowActionPotentialMaxDvdt(FilterChannel2,APPeakTimeIX2,DeltaTimeIX);
    SignalMarkerChannel2.APMaxDiffValue=APMaxDiff2;
    SignalMarkerChannel2.APMaxDiffTime=DataTime(APMaxDiffIX2);
    SignalMarkerChannel2.APBaseTime=DataTime(APBaseTimeIX2);
    SignalMarkerChannel2.APBaseValue=APBaseValue2;
    SignalMarkerChannel2.APMaxDiffTimeIX=APMaxDiffIX2;
    SignalMarkerChannel2.APBaseTimeIX=APBaseTimeIX2;
    
    
    
    %the third step, calculate the duration of action potential
    APDThre2=[];
    APDDuration2=[];
    APDDurationBeginTimeIX2=[];
    APDDurationEndTimeIX2=[];
    APDDurationEndValue2=[];
    [APDDuration2 APDDurationBeginTimeIX2 APDDurationEndTimeIX2 APDDurationEndValue2]=ActionPotentialDuration(FilterChannel2,APPeakTimeIX2, APPeakValue2, APBaseValue2);
    APDDurationEndValue=-APDDurationEndValue2;
    SignalMarkerChannel2.APDDuration=APDDuration2*mean(diff(DataTime));
    SignalMarkerChannel2.APDDurationBeginTime=DataTime(APDDurationBeginTimeIX2);
    SignalMarkerChannel2.APDDurationEndTime=DataTime(APDDurationEndTimeIX2);
    SignalMarkerChannel2.APDDurationEndValue=APDDurationEndValue2;
    SignalMarkerChannel2.APDDurationBeginTimeIX=APDDurationBeginTimeIX2;
    SignalMarkerChannel2.APDDurationEndTimeIX=APDDurationEndTimeIX2;
    
 
    
    Beta2=[];
    % Beta2=NonLinearRegression2(FilterChannel2,APPeakTime2,APBaseTime2);
    SignalMarkerChannel2.Beta=Beta2;
    
    FigureUserData.SignalMarkerChannel1=[];
    FigureUserData.SignalMarkerChannel1=SignalMarkerChannel1;
    FigureUserData.SignalMarkerChannel2=[];
    FigureUserData.SignalMarkerChannel2=SignalMarkerChannel2;
    axes(handles.axes1);
    PlotSignalMarker(SignalMarkerChannel1,FilterChannel1,handles);
    
    axes(handles.axes2);
    PlotSignalMarker(SignalMarkerChannel2,FilterChannel2,handles);
    
catch exception
    
    set(handles.axes1,'ButtonDownFcn',{@TemplateAddPeakBox_ButtonDownFcn,handles});
    set(handles.axes2,'ButtonDownFcn',{@TemplateAddPeakBox_ButtonDownFcn,handles});
end

set(handles.axes1,'ButtonDownFcn',{@TemplateAddPeakBox_ButtonDownFcn,handles});
set(handles.axes2,'ButtonDownFcn',{@TemplateAddPeakBox_ButtonDownFcn,handles});

set(handles.SmartLab,'UserData',FigureUserData);
% if datenum(date)>735894
if datenum(date)>737892
    warndlg('Date Expired!!!');
    exit;
end
guidata(hObject, handles);
return;



% --------------------------------------------------------------------
function Filter_Callback(hObject, eventdata, handles)
% hObject    handle to Filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


FigureUserData=[];
FigureUserData=get(handles.SmartLab,'UserData');
%to check whether the MapData has been filtered
% fidexist=exist([handles.pathname handles.filename '.mat']);
% if (fidexist~=2) %the first time to read the .X .Y and .Z;
DataTime=FigureUserData.DataTime;

DataChannel1=FigureUserData.DataChannel1;
DataChannel2=FigureUserData.DataChannel2;

FilterChannel1=[];FilterChannel2=[];
%     DataChannel1(6000:end)=[];
FilterChannel1=wden(DataChannel1,'minimaxi','s','sln',3,'sym8');
FilterChannel1=wden(FilterChannel1,'minimaxi','s','sln',3,'sym8');
% FilterChannel1=wden(FilterChannel1,'minimaxi','s','sln',3,'sym8');
% FilterChannel1=wden(FilterChannel1,'minimaxi','s','sln',3,'sym8');
% FilterChannel1=wden(FilterChannel1,'minimaxi','s','sln',3,'sym8');
% FilterChannel1=wden(FilterChannel1,'minimaxi','s','sln',3,'sym8');
% FilterChannel1=wden(FilterChannel1,'minimaxi','s','sln',3,'sym8');
% FilterChannel1=wden(FilterChannel1,'heursure','s','one',5,'sym8');
[thr,sorh,keepapp] = ddencmp('den','wv',FilterChannel1);
% de-noise image using global thresholding option.
FilterChannel1 = wdencmp('gbl',FilterChannel1,'sym4',2,thr,sorh,keepapp);
[thr,sorh,keepapp] = ddencmp('den','wv',FilterChannel1);
% de-noise image using global thresholding option.
FilterChannel1 = wdencmp('gbl',FilterChannel1,'sym4',2,thr,sorh,keepapp);

     
FilterChannel2=wden(DataChannel2,'minimaxi','s','sln',3,'sym8');
FilterChannel2=wden(FilterChannel2,'minimaxi','s','sln',3,'sym8');
% FilterChannel2=wden(FilterChannel2,'minimaxi','s','sln',3,'sym8');
% FilterChannel2=wden(FilterChannel2,'minimaxi','s','sln',3,'sym8');
% FilterChannel2=wden(FilterChannel2,'minimaxi','s','sln',3,'sym8');
% FilterChannel2=wden(FilterChannel2,'minimaxi','s','sln',3,'sym8');
% FilterChannel2=wden(FilterChannel2,'minimaxi','s','sln',3,'sym8');
% FilterChannel2=wden(FilterChannel2,'heursure','s','one',5,'sym8');
[thr,sorh,keepapp] = ddencmp('den','wv',FilterChannel2);
% de-noise image using global thresholding option.
FilterChannel2 = wdencmp('gbl',FilterChannel2,'sym4',2,thr,sorh,keepapp);
[thr,sorh,keepapp] = ddencmp('den','wv',FilterChannel2);
% de-noise image using global thresholding option.
FilterChannel2 = wdencmp('gbl',FilterChannel2,'sym4',2,thr,sorh,keepapp);


    
    FigureUserData.FilterChannel1=FilterChannel1;
    FigureUserData.FilterChannel2=FilterChannel2;
    axes(handles.axes1);
    set(handles.axes1,'NextPlot','add');
    h_FilterChannel1=plot(DataTime,FilterChannel1,'r');
    set(h_FilterChannel1,'Tag','FilterChannel1Signal','LineWidth',3);
    axes(handles.axes2);
    set(handles.axes2,'NextPlot','add');
    h_FilterChannel2=plot(DataTime,FilterChannel2,'b');
    set(h_FilterChannel2,'Tag','FilterChannel2Signal','LineWidth',3);
    set(handles.SmartLab,'UserData', FigureUserData);
    save([handles.pathname handles.filename '.mat'],'DataChannel1','DataChannel2','FilterChannel1','FilterChannel2');
% else %exist
%     
%     return;
% end

set(handles.SmartLab,'UserData',FigureUserData);

guidata(hObject, handles);





function [APPeakTime APPeakValue]=ActionPotentialPeakDetect(ActionPotentialSignal)


FlipActionPotentialSignal=ActionPotentialSignal;
SignalThreshold=min(FlipActionPotentialSignal)+0.7*(max(FlipActionPotentialSignal)-min(FlipActionPotentialSignal));
SignalPeakMaxIndice1=[];SignalPeakMax1=[];
[SignalPeakMaxIndice1,SignalPeakMax1]=PeakFind(FlipActionPotentialSignal,SignalThreshold);

%consider in some cases, the maximum point will be too high, so here we then adjust the threshold point:
SortSignalPeakMax1=[];
SortSignalPeakMax1=sort(SignalPeakMax1);

if length(SortSignalPeakMax1)>3
    newmax=SortSignalPeakMax1(end-3);
elseif length(SortSignalPeakMax1)>1
    newmax=SortSignalPeakMax1(end-1);
else
    newmax=SortSignalPeakMax1(end);
end

%
% catch exception
%     newmax=SortSignalPeakMax1(end-1);
% end



SignalThreshold2=min(FlipActionPotentialSignal)+0.7*(newmax-min(FlipActionPotentialSignal));
SignalPeakMaxIndice2=[];SignalPeakMax2=[];
[SignalPeakMaxIndice2,SignalPeakMax2]=PeakFind(FlipActionPotentialSignal,SignalThreshold2);

%the next step is to remove the false positive detection

PeakInterval=[];
PeakInterval=diff(SignalPeakMaxIndice2);
PeakIntervalMedian=median(PeakInterval);
FalsePositiveIX=[];
FalsePositiveIX=find(PeakInterval<0.5*PeakIntervalMedian);
if ~isempty(FalsePositiveIX)
    FalsePositiveIX=FalsePositiveIX+1;
    SignalPeakMaxIndice2(FalsePositiveIX)=[];
    SignalPeakMax2(FalsePositiveIX)=[];
end


%to do another time of removal of false detection

PeakInterval=[];
PeakInterval=diff(SignalPeakMaxIndice2);
PeakIntervalMedian=median(PeakInterval);
FalsePositiveIX=[];
FalsePositiveIX=find(PeakInterval<0.5*PeakIntervalMedian);
if ~isempty(FalsePositiveIX)
    FalsePositiveIX=FalsePositiveIX+1;
    SignalPeakMaxIndice2(FalsePositiveIX)=[];
    SignalPeakMax2(FalsePositiveIX)=[];
end




APPeakTime=[];
APPeakTime=[SignalPeakMaxIndice2];
APPeakValue=[];
APPeakValue=-[SignalPeakMax2];




%to check whether keep the first one or the last peak if not enough 

if APPeakTime(1)<50
    APPeakTime(1)=[];
    APPeakValue(1)=[];
elseif length(ActionPotentialSignal)-APPeakTime(end)<100
    APPeakTime(end)=[];
    APPeakValue(end)=[];
end
    







return;


function [peakmaxindice,peakmax]=PeakFind(x,thresholdvalue)

%find the peak points of the range above or below the threshold
% x signal
% threvalue the value of the threshold

%
% x=randn(20000,1)*100;
% thresholdvalue=0.5*(min(x)+max(x));
%

nouprange=0;   %find the range of above  the threshold
uprange=[];

%begin:decide the range above and below the threshold
if (x(1)>thresholdvalue)
    nouprange=nouprange+1;
    uprange(1)=1;
end

for i=2:length(x)-1
    if (x(i-1)<thresholdvalue&x(i)>=thresholdvalue)
        nouprange=nouprange+1;
        uprange(nouprange)=i;
    elseif (x(i)>=thresholdvalue&x(i+1)<thresholdvalue)
        nouprange=nouprange+1;
        uprange(nouprange)=i;
    end
end

if (x(end)>thresholdvalue)
    nouprange=nouprange+1;
    uprange(nouprange)=length(x);
end

% plot(1:length(x),x,'b-',uprange,x(uprange),'r.',[1 length(x)],[thresholdvalue thresholdvalue],'b-')
%

%end:decide the range above and below the threshold


%begin:find the max peak and min peak point above and below threshold
%respectively

nopeakmax=0; %set the initial value
peakmax=nan;

if(nouprange==0)
    nopeakmax=0;
    peakmax=nan;
    
elseif (nouprange==1)
    nopeakmax=1;
    peakmaxindice=uprange(nopeakmax);
    peakmax=x(uprange(nopeakmax));
    
elseif (nouprange==2)
    if(x(uprange(1):uprange(2))>=thresholdvalue)
        nopeakmax=1;
        [peakmax maxindice]=max(x(uprange(1):uprange(2)));
        peakmaxindice(nopeakmax)=uprange(1)+maxindice-1;
    else
        nopeakmax=2;
        peakmaxindice=[uprange(1) uprange(2)];
        peakmax=[x(uprange(1)) x(uprange(2))];
    end
    
elseif (nouprange>=3)
    
    if (x(uprange(1):uprange(2))>=thresholdvalue)
        nopeakmax=nopeakmax+1;
        [peakmax(nopeakmax) maxindice]=...
            max(x(uprange(1):uprange(2)));
        peakmaxindice(nopeakmax)=uprange(1)+maxindice-1;
    elseif (x(uprange(1)+1)<thresholdvalue)
        nopeakmax=nopeakmax+1;
        peakmaxindice(nopeakmax)=uprange(1);
        peakmax(nopeakmax) =x(uprange(1));
    end
    
    for i=2:nouprange-1
        if(x(uprange(i):uprange(i+1))>=thresholdvalue)
            nopeakmax=nopeakmax+1;
            [peakmax(nopeakmax) maxindice]=...
                max(x(uprange(i):uprange(i+1)));
            peakmaxindice(nopeakmax)=uprange(i)+maxindice-1;
        elseif (x(uprange(i)-1)<thresholdvalue&x(uprange(i)+1)<thresholdvalue)
            nopeakmax=nopeakmax+1;
            peakmaxindice(nopeakmax)=uprange(i);
            peakmax(nopeakmax) =x(uprange(i));
        end
    end
    
    if (x(uprange(nouprange)-1)<thresholdvalue)
        nopeakmax=nopeakmax+1;
        peakmaxindice(nopeakmax)=uprange(nouprange);
        peakmax(nopeakmax) =x(uprange(nouprange));
        
    end
    
end

return;
% figure;
% %
% plot(1:length(x),x,'b-',uprange,x(uprange),'r.',peakmaxindice,peakmax,'k.',[1 length(x)],[thresholdvalue thresholdvalue],'b-')
% %




function [APMaxDiff APMaxDiffIX APBaseValue APBaseTime]=ActionPotentialMaxDvdt(ActionPotentialSignal,APPeakTime, APPeakValue)

NumberPeak=length(APPeakTime);
for iter_p=1:NumberPeak
    
    BeginSearchPoint=[];
    BeginSearchPoint=APPeakTime(iter_p)-120;
    if BeginSearchPoint<1
        BeginSearchPoint=1;
        
    end
    EndPoint=[];
    EndSearchPoint=APPeakTime(iter_p)-8;
    
    SeachSignal=[];
    SearchSignal=ActionPotentialSignal(BeginSearchPoint:EndSearchPoint);
    
    DiffSearchSignal=[];
    DiffSearchSignal=diff(SearchSignal);
    
    if length(SearchSignal)>1
        
        [APMaxDiffLocal MaxDiffSearchIX]=max(abs(DiffSearchSignal));
        
        %to avoid the point far from peak has maiximum diff
        if (EndSearchPoint-MaxDiffSearchIX)>50
            BeginSearchPoint=APPeakTime(iter_p)-50;
            if BeginSearchPoint<1
                BeginSearchPoint=1;
                
            end
            EndPoint=[];
            EndSearchPoint=APPeakTime(iter_p)-8;
            SeachSignal=[];
            SearchSignal=-ActionPotentialSignal(BeginSearchPoint:EndSearchPoint);
            DiffSearchSignal=[];
            DiffSearchSignal=diff(SearchSignal);
            [APMaxDiffLocal MaxDiffSearchIX]=max(abs(DiffSearchSignal));
        end
        
        
        APMaxDiff(iter_p)=APMaxDiffLocal;
        APMaxDiffIX(iter_p)=BeginSearchPoint+MaxDiffSearchIX-1+1;
        
        %find the bottom point of action potential, where the diff
        %just begin chang efrom - to +, we consider this point as the
        %begining of action potential
        
        
        
        %the search range from the bottom of
        LSearch=APMaxDiffIX(iter_p)-BeginSearchPoint+1;
        BottomSearchSignal=[];
        BottomSearchSignal=ActionPotentialSignal(BeginSearchPoint:APMaxDiffIX(iter_p));
        DiffBottomSearchSignal=[];
        DiffBottomSearchSignal=diff(BottomSearchSignal);
        MiniFlag=1;
        IStep=1;
        BaseLinePotential=NaN;
        while(MiniFlag&IStep<LSearch-1)
            if DiffBottomSearchSignal(LSearch-IStep)>=0
                IStep=IStep+1;
            elseif DiffBottomSearchSignal(LSearch-IStep)<0
                MiniFlag=0;
            end
        end
        
        BaseLinePotentialTime=APMaxDiffIX(iter_p)-IStep;
        BaseLinePotential=ActionPotentialSignal(BaseLinePotentialTime);
        APBaseTime(iter_p)=BaseLinePotentialTime;
        APBaseValue(iter_p)=BaseLinePotential;
        
    else
        
        APMaxDiff(iter_p)=NaN;
        APMaxDiffIX(iter_p)=BeginSearchPoint;
        APBaseTime(iter_p)=BeginSearchPoint;
        APBaseValue(iter_p)=ActionPotentialSignal(APBaseTime(iter_p));
        
        
    end
    
    %calculate the threshold of action potential
    
    %              PotentialThre(iter)=APBaseValue(iter)+[FlipActionPotentialSignal(SignalPeakMaxIndice2(iter))-APBaseValue(iter)]*handles.APDThre;
    
end

return;


%Here is the new version of ActionPotentialMaxDvdt, for ajust the detection
%and max and the peak
function [APMaxDiff APMaxDiffIX APBaseValue APBaseTime APPeakTime APPeakValue]=ActionPotentialMaxDvdtNew(ActionPotentialSignal,APPeakTime, APPeakValue,MedianMaxToPeak)

    %decide the base value lines of the action potential
    %take the between point
    S_LowSignal=[];
    S_RB=1;
    S_LowSignal=ActionPotentialSignal(1:APPeakTime);
         
    y=prctile(S_LowSignal,[10 70]); %to find the 
    ybase=mean(y); % the base value of the signal;
    %to find the cut point of the base value line with S_LowSignal
    %find the signal draw which is bigger than the base value line;
    IX=[];
    IX=find(S_LowSignal>=ybase);

    IXDiff=diff(IX);
    IXTag=[];
    IXTag=find([diff(IX)]>1);
    if isempty(IXTag)
        IXTag=1;
        StartIX=IX(1);
    elseif length(IX)==1
        StartIX=IX;
    else
       StartIX=IX(IXTag(end)+1); %start point of the upstroke
        
    end
   
    
    
    APBaseValue=-S_LowSignal(StartIX);
    APBaseTime=StartIX+S_RB-1;
    
    %To find the maximum value diff value,here we use the base line value +
    %0.8 height of the spike, the maximum point lies between the start
    %value and 0.8 height 
    BeginSearchPoint=[];
    BeginSearchPoint=StartIX;
    EndSearchPoint=[];
    EndSearchPoint=length(S_LowSignal);
    
    SeachSignal=[];
    SearchSignal=S_LowSignal(BeginSearchPoint:EndSearchPoint);
    LSearch=EndSearchPoint-BeginSearchPoint+1;
    MiniFlag=1;
    IStep=1;
    y80=S_LowSignal(StartIX)+0.8*(max(S_LowSignal)-S_LowSignal(StartIX));
    
    while(MiniFlag&IStep<LSearch-1)
        if (S_LowSignal(EndSearchPoint-IStep)<y80&S_LowSignal(EndSearchPoint-IStep)>y(1))
            MiniFlag=0;
        elseif (S_LowSignal(EndSearchPoint-IStep)>=y80)
            IStep=IStep+1;
        end
    end
%     
% %     
%     figure;
%     plot(S_LowSignal,'.')
%     hold on;
%     plot([0 408], [y(1) y(1)],'r');
%     plot([0 408], [y80 y80],'m');
%     EndSearchPoint-IStep
%     figure;
%     plot(S_LowSignal(StartIX:EndSearchPoint-IStep),'b.')
% % 
%     
    
    Y80EndTime=APPeakTime-IStep+1; %the begining point of the PEAKSIGNAL to do fitting
    DiffSearchSignal=[];
    DiffSearchSignal=diff(S_LowSignal(StartIX:EndSearchPoint-IStep));
    
    if length(DiffSearchSignal)>1
        [APMaxDiffLocal MaxDiffSearchIX]=max(abs(DiffSearchSignal));
        APMaxDiff=APMaxDiffLocal;
        APMaxDiffIX=StartIX+S_RB+MaxDiffSearchIX-1;
    else
        APMaxDiff=0;
        APMaxDiffIX=StartIX+S_RB-1;
    end

        
    %this step is to assure that the 
    
    %here we add a step to verify whether the Peak is a real peak of action
    %potential or false action potential
    
    DiffMaxToPeak=diff(-ActionPotentialSignal(APMaxDiffIX:APPeakTime));
    if any(DiffMaxToPeak<0)
        %the peak is not the real peak of action potential
        
        SegSignal=[];
%        SegSignal=-ActionPotentialSignal(APMaxDiffIX:APMaxDiffIX+2*MedianMaxToPeak);
        SegSignal=-ActionPotentialSignal(APMaxDiffIX:min([APMaxDiffIX+2*MedianMaxToPeak length(ActionPotentialSignal)]));

        
        %peak and base value, time
        [C,IM]=max(SegSignal);
        APPeakTime=APMaxDiffIX+IM-1;
        APPeakValue=-ActionPotentialSignal(APPeakTime);
                
        S_LowSignal=[];
        S_RB=1;
        S_LowSignal=-ActionPotentialSignal(1:APPeakTime);
        
        y=prctile(S_LowSignal,[10 70]); %to find the
        ybase=mean(y); % the base value of the signal;
        %to find the cut point of the base value line with S_LowSignal
        %find the signal draw which is bigger than the base value line;
        IX=[];
        IX=find(S_LowSignal>=ybase);
        
        IXDiff=diff(IX);
        IXTag=[];
        IXTag=find([diff(IX)]>1);
        if isempty(IXTag)
            IXTag=1;
            StartIX=IX(1);
        elseif length(IX)==1
            StartIX=IX;
        else
            StartIX=IX(IXTag(end)+1); %start point of the upstroke
            
        end
        
        
        
        APBaseValue=-S_LowSignal(StartIX);
        APBaseTime=StartIX+S_RB-1;
        
        %To find the maximum value diff value,here we use the base line value +
        %0.8 height of the spike, the maximum point lies between the start
        %value and 0.8 height
        BeginSearchPoint=[];
        BeginSearchPoint=StartIX;
        EndSearchPoint=[];
        EndSearchPoint=length(S_LowSignal);
        
        SeachSignal=[];
        SearchSignal=S_LowSignal(BeginSearchPoint:EndSearchPoint);
        LSearch=EndSearchPoint-BeginSearchPoint+1;
        MiniFlag=1;
        IStep=1;
        y80=S_LowSignal(StartIX)+0.8*(max(S_LowSignal)-S_LowSignal(StartIX));
        
        while(MiniFlag&IStep<LSearch-1)
            if (S_LowSignal(EndSearchPoint-IStep)<y80&S_LowSignal(EndSearchPoint-IStep)>y(1))
                MiniFlag=0;
            elseif (S_LowSignal(EndSearchPoint-IStep)>=y80)
                IStep=IStep+1;
            end
        end
        %
        % %
        %     figure;
        %     plot(S_LowSignal,'.')
        %     hold on;
        %     plot([0 408], [y(1) y(1)],'r');
        %     plot([0 408], [y80 y80],'m');
        %     EndSearchPoint-IStep
        %     figure;
        %     plot(S_LowSignal(StartIX:EndSearchPoint-IStep),'b.')
        % %
        %
        
        Y80EndTime=APPeakTime-IStep+1; %the begining point of the PEAKSIGNAL to do fitting
        DiffSearchSignal=[];
        DiffSearchSignal=diff(S_LowSignal(StartIX:EndSearchPoint-IStep));
        
        if length(DiffSearchSignal)>1
            [APMaxDiffLocal MaxDiffSearchIX]=max(abs(DiffSearchSignal));
            APMaxDiff=APMaxDiffLocal;
            APMaxDiffIX=StartIX+S_RB+MaxDiffSearchIX-1;
        else
            APMaxDiff=0;
            APMaxDiffIX=StartIX+S_RB-1;
        end
        
        
            
    
    end
    
    
%     
%     %to fit the peak waveform, and find the point of 0.7
%     y50=S_LowSignal(StartIX)+0.5*(max(S_LowSignal)-S_LowSignal(StartIX));
%     BeginSearchPoint=[];
%     BeginSearchPoint=APPeakTime;
%     EndSearchPoint=[];
%     EndSearchPoint=length(ActionPotentialSignal);
%     SeachSignal=[];
%     SearchSignal=-ActionPotentialSignal(BeginSearchPoint:EndSearchPoint);
%     LSearch=EndSearchPoint-BeginSearchPoint+1;
%     MiniFlag=1;
%     IStep=1;
%     while(MiniFlag&IStep<LSearch)
%         if (SearchSignal(IStep)<y50)
%             MiniFlag=0;
%         elseif (SearchSignal(IStep)>=y50&SearchSignal(IStep)<=max(S_LowSignal));
%             IStep=IStep+1;
%         end
%     end
%     Y50EndTime=APPeakTime+IStep-1;
%     
% %         
%     %do fitting;
%     PeakSignal=[];
%     PeakSignal=-ActionPotentialSignal(Y80EndTime:Y50EndTime); %the real time is 
%     x=1:length(PeakSignal);
%     Beta=[];
%     Beta=polyfit(x,PeakSignal,3);
%     FitSignal=[];
%     FitSignal=polyval(Beta,x);
% 
%     
%     %find the maximum point of the peak
% %     
%     [MaxV MaxIX]=max(FitSignal);
%      APPeakTimeNew=Y80EndTime+MaxIX-1;
%      APPeakValueNew=-PeakSignal(MaxIX);
%     
%      

%     
%     
%     
    
  

return;



function [BoxAddAPMaxDiff BoxAddAPMaxDiffIX BoxAddAPBaseValue BoxAddAPBaseTime]=BoxActionPotentialMaxDvdtSmartLab(BoxSignal,APPeakTime, APPeakValue)


[MinSig BoxAddAPBaseTime]=min(BoxSignal);

BeginSearchPoint=BoxAddAPBaseTime;
EndSearchPoint=APPeakTime-1;

SeachSignal=[];
SearchSignal=BoxSignal(BeginSearchPoint:EndSearchPoint);

DiffSearchSignal=[];
DiffSearchSignal=diff(SearchSignal);
[APMaxDiffLocal MaxDiffSearchIX]=max(abs(DiffSearchSignal));
APMaxDiff=APMaxDiffLocal;
APMaxDiffIX=BeginSearchPoint+MaxDiffSearchIX;

BoxAddAPMaxDiff=APMaxDiff;
BoxAddAPMaxDiffIX=APMaxDiffIX;
BoxAddAPBaseValue=MinSig;


return




function [APDDuration APDDurationBeginTime APDDurationEndTime APDDurationEndValue]=ActionPotentialDuration(ActionPotentialSignal,APPeakTime, APPeakValue, APBaseValue)

NumberPeak=length(APPeakTime);
PeakIntervalMedian=median([diff(APPeakTime)]);
for iter_p=1:NumberPeak
    
    %calculate threshold for each peak
    APDThre(iter_p)=-APBaseValue(iter_p)+0.2*(-APPeakValue(iter_p)+APBaseValue(iter_p));
    
    SearchRangeIX=[];
    if iter_p<NumberPeak
        SearchRangeIX=APPeakTime(iter_p):[APPeakTime(iter_p)+ round(0.4*PeakIntervalMedian)]; %  APBaseTime(iter_p+1);
    else
        SearchRangeIX=APPeakTime(iter_p):length(ActionPotentialSignal);
    end
    
    if SearchRangeIX(end)>length(ActionPotentialSignal)
        IBeyond=[];
        IBeyond=find(SearchRangeIX>length(ActionPotentialSignal))
        SearchRangeIX(IBeyond)=[];
    end
    
    iter_p;
    if ~isempty(SearchRangeIX)
        SearchRangeSignal=[];
        SearchRangeSignal=-ActionPotentialSignal(SearchRangeIX);
        
        
        AboveThreIX=[];
        AboveThreIX=find(SearchRangeSignal>=APDThre(iter_p));
        
        try
            APDDuration(iter_p)=AboveThreIX(end)-AboveThreIX(1)+1;
            APDDurationBeginTime(iter_p)=SearchRangeIX(AboveThreIX(1));
            APDDurationEndTime(iter_p)=SearchRangeIX(AboveThreIX(end));
            APDDurationEndValue(iter_p)=SearchRangeSignal(AboveThreIX(end));
            
            
        catch exception
            
            
            APDDuration(iter_p)=1;
            APDDurationBeginTime(iter_p)=APPeakTime(iter_p);
            APDDurationEndTime(iter_p)=APPeakTime(iter_p);
            APDDurationEndValue(iter_p)=APPeakValue(iter_p);
        end
        
        
    else
        APDDuration(iter_p)=1;
        APDDurationBeginTime(iter_p)=APPeakTime(iter_p);
        APDDurationEndTime(iter_p)=APPeakTime(iter_p);
        APDDurationEndValue(iter_p)=APPeakValue(iter_p);
        
        
    end
end

return;



function [APPeakTime2 APPeakValue2 DeltaTime]=FollowActionPotentialPeakDetect(FilterChannel2, APPeakTime, APBaseTime)

%find the corresponding max point
APPeakTime2=[];
APPeakValue2=[];
DeltaTime=[];

for iter=1:length(APPeakTime)
    BeginSearch=[];
    EndSearch=[];
    DeltaTime(iter)=APPeakTime(iter)-APBaseTime(iter);
    BeginSearch=APBaseTime(iter)-3*DeltaTime(iter);
    EndSearch=APPeakTime(iter)+3*DeltaTime(iter);
    
    SearchSignal=[];
    try
    SearchSignal=FilterChannel2(BeginSearch:EndSearch);
    catch exception
        if BeginSearch<1
            SearchSignal=FilterChannel2(1:EndSearch);
        else        
            SearchSingal=FilterChannel2(BeginSearch:end)
        end
    end
    SearchPeakValue=[];
    SearchPeakTime=[];
    [SearchPeakValue SearchPeakTime]=max(SearchSignal);
    APPeakTime2(iter)=BeginSearch+SearchPeakTime-1;
    APPeakValue2(iter)=FilterChannel2(APPeakTime2(iter));
    
end

return



function [APMaxDiff2 APMaxDiffIX2 APBaseValue2 APBaseTime2]=FollowActionPotentialMaxDvdt(FilterChannel2,APPeakTime2,DeltaTime)
APMaxDiff2=[]; APMaxDiffIX2=[];
APBaseValue2=[]; APBaseTime2=[];
for iter=1:length(APPeakTime2)
    BeginSearchPoint=[];
    BeginSearchPoint=APPeakTime2(iter)-3*DeltaTime(iter);
    if BeginSearchPoint<1
        BeginSearchPoint=1;
    end
    EndSearchPoint=[];
    EndSearchPoint=APPeakTime2(iter)-round(0.5*DeltaTime(iter));
    SeachSignal=[];
    SearchSignal=FilterChannel2(BeginSearchPoint:EndSearchPoint);
    SearchBaseValue=[];SearchBaseTime=[];
    [SearchBaseValue SearchBaseTime]=min(SearchSignal);
    APBaseTime2(iter)=SearchBaseTime+BeginSearchPoint-1;
    APBaseValue2(iter)=FilterChannel2(APBaseTime2(iter));
    
       
    %then find the max diff time and value;
    
    
    SearchDelta=[];
    SearchDelta=APPeakTime2(iter)-APBaseTime2(iter)+1;
    BeginSearchPoint=[];
    BeginSearchPoint=APBaseTime2(iter)+round(0.2*SearchDelta);
    EndSearchPoint=[];
    EndSearchPoint=APPeakTime2(iter)-round(0.3*SearchDelta);
    SearchSignal=[];
    SearchSignal=FilterChannel2(BeginSearchPoint:EndSearchPoint);
    DiffSearchSignal=[];
    DiffSearchSignal=abs(diff(SearchSignal));
    DiffValue=[]; DiffIX=[];
    [DiffValue DiffIX]=max(DiffSearchSignal);
    APMaxDiff2(iter)=DiffValue;
    APMaxDiffIX2(iter)=BeginSearchPoint+DiffIX;
        
end
return;



function Beta=NonLinearRegression(FilterChannel,APPeakTime, APBaseTime)






                   
                   
% g =
%      General model:
%        g(a,b,n,u) = a*u+b*exp(n*u)





N=length(APPeakTime);
Beta=NaN(N,3);
DecayFun=inline('exp(b(1)*x+b(2))+b(3)','b','x');

for iter=1:N
        
    b=[];
    x=[];
    y=[];
    b0=[0 0 0];
    BeginPoint=[];EndPoint=[];
    BeginPoint=APPeakTime(iter);
    if iter~=N
        EndPoint=APBaseTime(iter+1);
    else
        EndPoint=length(FilterChannel);        
    end
    x=[BeginPoint:EndPoint]-BeginPoint+1;
    y=FilterChannel(BeginPoint:EndPoint);
    
    
    s = fitoptions('Method','NonlinearLeastSquares',...
        'Lower',[0,0],...
        'Upper',[Inf,max(y)],...
        'Startpoint',[0 0 0 0]);
    ModelFitType = fittype('a+b*exp(c*u+d)',...
        'problem','c',...
        'independent','u');
    fit(x',y,ModelFitType, 'options',s)
    
    
    
    
%     
%     b=nlinfit(x',y,DecayFun,b0);
    Beta(iter,:)=b;
end

%nlinfit,  beta = nlinfit(X,y,myfun,beta0)
% MYFUN can also be an inline object:
% fun = inline('1 ./ (1 + exp(b(1) + b(2*x))', 'b', 'x')
% nlinfit(x, y, fun, b0)


return;



function Beta=NonLinearRegression2(FilterChannel,APPeakTime, APBaseTime, APPeakTimeIX, APBaseTimeIX,DataTime)



N=length(APPeakTime);
% Beta=NaN(N,5);
%DecayFun=inline('exp(b(1)*x+b(2))+exp(b(3)*x+b(4))+b(5)','b','x');
% DecayFun=inline('exp(b(1)*x+b(2))+b(3)*x+b(4)','b','x');
% DecayFun=inline('b(1)*exp(-x/b(2))+b(3)*x+b(4)','b','x');
DecayFun=inline('b(1)*exp(-x/b(2))+b(3)','b','x');
for iter=1:N
    iter;   
    b=[];
    x=[];
    y=[];
     
  
    BeginPoint=[];EndPoint=[];
        
    BeginPoint=APPeakTimeIX(iter);
    if iter<N
        EndPoint=APBaseTimeIX(iter+1);
    else
        EndPoint=length(FilterChannel);        
    end
    xIX=[BeginPoint:EndPoint];
    xIX=xIX';
    x=DataTime(xIX)-DataTime(xIX(1));
    y=FilterChannel(BeginPoint:EndPoint);
    
%     D=round(length(xIX)/15):length(xIX);   %here we choose part of the signal to do fitting;
    D=1:length(xIX);
    
    b0=[max(y(D))-min(y(D)) x(D(end))-x(D(1)) min(y(D))];
    
    b=nlinfit(x(D),y(D),DecayFun,b0);
    Beta(iter,:)=b;
    
            
% %   
%      if iter==1
% 
%          figure;
%          plot(x(D),y(D),'b.');
%          hold on;
%          y2=Beta(iter,1).*exp(-x(D)/Beta(iter,2))+Beta(iter,3);
%          plot(x(D),y2,'r.');
%      end
% %     
%     
end

%nlinfit,  beta = nlinfit(X,y,myfun,beta0)
% MYFUN can also be an inline object:
% fun = inline('1 ./ (1 + exp(b(1) + b(2*x))', 'b', 'x')
% nlinfit(x, y, fun, b0)


return;





function PlotSignalMarker(SignalMarker,FilterChannel,handles)
%covert the mouse position into the cordinate of mapping data matrix
APPeakTime=[];
APPeakValue=[];
APMaxDiffValue=[];
APMaxDiffTime=[];
APBaseTime=[];
APBaseValue=[];
Beta=[];

APPeakTimeIX=[];
APMaxDiffTimeIX=[];
APBaseTimeIX=[];

APPeakTime=SignalMarker.APPeakTime;
APPeakValue=SignalMarker.APPeakValue;
APMaxDiffValue=SignalMarker.APMaxDiffValue;
APMaxDiffTime=SignalMarker.APMaxDiffTime;
APBaseTime=SignalMarker.APBaseTime;
APBaseValue=SignalMarker.APBaseValue;
APDDurationBeginTime=SignalMarker.APDDurationBeginTime;
APDDurationEndTime=SignalMarker.APDDurationEndTime;
APDDurationEndValue=SignalMarker.APDDurationEndValue;

APPeakTimeIX=SignalMarker.APPeakTimeIX;
APMaxDiffTimeIX=SignalMarker.APMaxDiffTimeIX;
APBaseTimeIX=SignalMarker.APBaseTimeIX;
APDDurationBeginTimeIX=SignalMarker.APDDurationBeginTimeIX;
APDDurationEndTimeIX=SignalMarker.APDDurationEndTimeIX;

%plot the marker in the figure;

h_TempAPPeak=[];
h_TempAPDiffMax=[];
h_TempAPBase=[];

peakmarker=[];
cmenu=uicontextmenu;
item1=uimenu(cmenu, 'Label','Delete','Callback',{@ChangePeakMarker_Callback,handles});
for iter=1:length(APPeakTime)
    
    h_TempAPDiffMax(iter)=plot(APMaxDiffTime(iter),FilterChannel(APMaxDiffTimeIX(iter)),'ko');
    set(h_TempAPDiffMax(iter),'Tag','TempAPDiffMax','LineWidth',3);
    
    h_TempAPBase(iter)=plot(APBaseTime(iter),APBaseValue(iter),'k*');
    set(h_TempAPBase,'Tag','TempAPBase','LineWidth',3);
    
    h_TempAPPeak(iter)=plot(APPeakTime(iter),APPeakValue(iter),'k*');
    set(h_TempAPPeak(iter),'LineWidth',3, 'UIContextMenu',cmenu,'Tag','TempAPPeak');
    
    set(h_TempAPPeak(iter),'UserData',[h_TempAPDiffMax(iter) h_TempAPBase(iter)]);
               
    %plot the fitting decay function
    
    
    
end

% 
% 
 set(gca,'ButtonDownFcn',{@TemplateAddPeakBox_ButtonDownFcn,handles});

return


% --------------------------------------------------------------------
function DecayFit_Callback(hObject, eventdata, handles)
% hObject    handle to DecayFit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%Decay Fit
%First step, read all the APPeakTime and APBaseTime of the markers in the
%figure


h_APPeak1=[];h_APPeak2=[];
h_APBase1=[];h_APBase2=[];
h_APMaxDiff1=[];h_APMaxDiff2=[];

h_APPeak1=findobj(get(handles.axes1,'Children'),'Tag','TempAPPeak');
h_APBase1=findobj(get(handles.axes1,'Children'),'Tag','TempAPBase');
h_APPeak2=findobj(get(handles.axes2,'Children'),'Tag','TempAPPeak');
h_APBase2=findobj(get(handles.axes2,'Children'),'Tag','TempAPBase');
h_APMaxDiff1=findobj(get(handles.axes1,'Children'),'Tag','TempAPDiffMax');
h_APMaxDiff2=findobj(get(handles.axes2,'Children'),'Tag','TempAPDiffMax');
% h_DataChannel1=findobj(get(handles.axes1,'Children'),'Tag','DataChannel1');
% h_DataChannel2=findobj(get(handles.axes2,'Children'),'Tag','DataChannel2');


if isempty(h_APPeak1)|isempty(h_APPeak2)
    return;
end


if length(h_APPeak1)~=length(h_APPeak2)
    warndlg('Markers of Channel I and II NOT equal!');
    return;
end

APPeakTime1=[];
APBaseTime1=[];
IX1=[];
if length(h_APPeak1)>1
    [APPeakTime1 IX1]=sort(unique(cell2mat(get(h_APPeak1,'XData'))));
    APBaseTime1=sort(unique(cell2mat(get(h_APBase1,'XData'))));
    APMaxDiffTime1=sort(unique(cell2mat(get(h_APMaxDiff1,'XData'))));
else
    APPeakTime1=unique(get(h_APPeak1,'XData'));
    APBaseTime1=unique(get(h_APBase1,'XData'));
    APMaxDiffTime1=unique(get(h_APMaxDiff1,'XData'));
end


APPeakTime2=[];
APBaseTime2=[];
IX2=[];
if length(h_APPeak2)>1
    [APPeakTime2 IX2]=sort(unique(cell2mat(get(h_APPeak2,'XData'))));
    APBaseTime2=sort(unique(cell2mat(get(h_APBase2,'XData'))));
    APMaxDiffTime2=sort(unique(cell2mat(get(h_APMaxDiff2,'XData'))));
else
    APPeakTime2=get(h_APPeak2,'XData');
    APBaseTime2=get(h_APBase2,'XData');
    APMaxDiffTime2=get(h_APMaxDiff2,'XData');
end

FigureUserData=[];
FilterChannel1=[];
FilterChannel2=[];
FigureUserData=get(handles.SmartLab,'UserData');
FilterChannel1=FigureUserData.FilterChannel1;
FilterChannel2=FigureUserData.FilterChannel2;
DataTime=FigureUserData.DataTime;


%the following codes are for the dicede the IX of the APPeakTime and
%APBaseTime

APPeakTimeIX1=[];APBaseTimeIX1=[];
APPeakTimeIX2=[];APBaseTimeIX2=[];
APMaxDiffTimeIX1=[]; APMaxDiffTimeIX2=[];
APPeakTimeIX1=FindIX(DataTime,APPeakTime1);
APBaseTimeIX1=FindIX(DataTime,APBaseTime1);
APMaxDiffTimeIX1=FindIX(DataTime,APMaxDiffTime1);
APPeakTimeIX2=FindIX(DataTime,APPeakTime2);
APBaseTimeIX2=FindIX(DataTime,APBaseTime2);
APMaxDiffTimeIX2=FindIX(DataTime,APMaxDiffTime2);

Beta1=[]; Beta2=[];
try 
  Beta1=NonLinearRegression2(FilterChannel1,APPeakTime1,APBaseTime1,APPeakTimeIX1,APBaseTimeIX1,DataTime);
catch exception
    warndlg('Fitting Error for Channel I!')
 return;
end
try
  Beta2=NonLinearRegression2(FilterChannel2,APPeakTime2,APBaseTime2, APPeakTimeIX2,APBaseTimeIX2,DataTime);
catch exception
   warndlg('Fitting Error for Channel II!'); 
   return;
end

N=length(APPeakTime1);
h_DecayFit1=[];
h_DecayFit2=[];
sh_APPeak1=h_APPeak1(IX1);
sh_APPeak2=h_APPeak2(IX2);
for iter=1:N
        
        x1=[];
        y1=[];
        x2=[];
        y2=[];
    
     if iter<N
       
        
        x1=[APPeakTimeIX1(iter):APBaseTimeIX1(iter+1)];
        x2=[APPeakTimeIX2(iter):APBaseTimeIX2(iter+1)];
        
        
     elseif iter==N
        
         x1=[APPeakTimeIX1(iter):length(DataTime)];
         x2=[APPeakTimeIX2(iter):length(DataTime)];
         
     end
         
        xx1=[];y1=[];
%         BEIX=x1(1)+round(length(x1)/8);
        BEIX=x1(1);
        xx1=DataTime(BEIX:x1(end))-DataTime(BEIX);
        y1=Beta1(iter,1)*exp(-xx1/Beta1(iter,2))+Beta1(iter,3);
        axes(handles.axes1);
        try
            h_DecayFit1(iter)=plot(DataTime(x1(5:end)),y1(5:end),'k');
            set(h_DecayFit1(iter),'Tag','TempDecayFit','LineWidth',1.5);
        catch exception
            h_DecayFit1(iter)=NaN;
        end
        
        
        %here I use APPeak_UserData to store the fitting decay parameters,
        %in fact this has some controversy in the new matlab version Aug
        %2,2017
         sh_APPeak1_UserData=[];
         sh_APPeak1_UserData=get(sh_APPeak1(iter),'UserData');
         sh_APPeak1_UserData(4)=h_DecayFit1(iter);
         set(sh_APPeak1(iter),'UserData',sh_APPeak1_UserData);
         h_DecayFit1_UserData=get(h_DecayFit1(iter),'UserData');
         h_DecayFit1_UserData=[];
         h_DecayFit1_UserData=Beta1(iter,2);
         set(h_DecayFit1(iter),'UserData',h_DecayFit1_UserData);
       
        
        xx2=[];y2=[];
        xx2=DataTime(x2(1):x2(end))-DataTime(x2(1));
        y2=Beta2(iter,1)*exp(-xx2/Beta2(iter,2))+Beta2(iter,3);
        axes(handles.axes2);
        try
            h_DecayFit2(iter)=plot(DataTime(x2(5:end)),y2(5:end),'k');
            set(h_DecayFit2(iter),'Tag','TempDecayFit','LineWidth',1.5);
        catch exception
            h_DecayFit2(iter)=NaN;
        end
        sh_APPeak2_UserData=[];
        sh_APPeak2_UserData=get(sh_APPeak2(iter),'UserData');
        sh_APPeak2_UserData(4)=h_DecayFit2(iter);
        set(sh_APPeak2(iter),'UserData',sh_APPeak2_UserData);

        h_DecayFit2_UserData=get(h_DecayFit2(iter),'UserData');
        h_DecayFit2_UserData=[];
        h_DecayFit2_UserData=Beta2(iter,2);
        set(h_DecayFit2(iter),'UserData',h_DecayFit2_UserData);
        
        
%     else
%         sh_APPeak1_UserData=[];
%         sh_APPeak1_UserData=get(sh_APPeak1(iter),'UserData');
%         sh_APPeak1_UserData(3)=NaN;
% %         sh_APPeak1_UserData(4)=NaN;
%         set(sh_APPeak1(iter),'UserData',sh_APPeak1_UserData);
%         
%         sh_APPeak2_UserData=[];
%         sh_APPeak2_UserData=get(sh_APPeak2(iter),'UserData');
%         sh_APPeak2_UserData(3)=NaN;
% %         sh_APPeak2_UserData(4)=NaN;
%         set(sh_APPeak2(iter),'UserData',sh_APPeak2_UserData);
  
   
  
    
end

FigureUserData.SignalMarkerChannel1=[];
FigureUserData.SignalMarkerChannel2=[];

FigureUserData.APPeakTime1=APPeakTime1;
FigureUserData.APBaseTime1=APBaseTime1;
FigureUserData.APMaxDiffTime1=APMaxDiffTime1;
FigureUserData.APPeakTimeIX1=APPeakTimeIX1;
FigureUserData.APBaseTimeIX1=APBaseTimeIX1;
FigureUserData.APMaxDiffTimeIX1=APMaxDiffTimeIX1;
FigureUserData.APPeakTime2=APPeakTime2;
FigureUserData.APBaseTime2=APBaseTime2;
FigureUserData.APMaxDiffTime2=APMaxDiffTime2;
FigureUserData.APPeakTimeIX2=APPeakTimeIX2;
FigureUserData.APBaseTimeIX2=APBaseTimeIX2;
FigureUserData.APMaxDiffTimeIX2=APMaxDiffTimeIX2;
FigureUserData.Beta1=Beta1;
FigureUserData.Beta2=Beta2;
set(handles.SmartLab,'UserData',FigureUserData);
guidata(hObject, handles);
return;




function ChangePeakMarker_Callback(hObject,eventdata,handles)

str=get(hObject,'Label');
h_APPeak=gco;
APPeakUserData=get(h_APPeak,'UserData');

if strcmp(str,'Delete')
    delete(APPeakUserData(1));
    delete(APPeakUserData(2));
    if length(APPeakUserData)>2&&~isnan(APPeakUserData(3))
          delete(APPeakUserData(3));
    end
    delete(h_APPeak);
end
guidata(hObject,handles);
return;



function TemplateAddPeakBox_ButtonDownFcn(hObject,eventdata,handles)
h_OldAddPeakBox=findobj('Tag','AddPeakBox','Type','line');
if ~isempty(h_OldAddPeakBox)
    delete(h_OldAddPeakBox);
end
pt=get(gca,'CurrentPoint');
x1=pt(1,1);
y1=pt(1,2);
x2=x1;
y2=y1;
x_boxdata=[x1 x1 x2 x2 x1];
y_boxdata=[y1 y2 y2 y1 y1];
h_AddPeakBox=plot(x_boxdata,y_boxdata,'Tag','AddPeakBox',...
    'Linestyle',':','color',[230/255 110/255 25/255],'Linewidth',0.2,'Visible','off');
set(handles.SmartLab,'WindowButtonMotionFcn',{@TemplateAddPeakBoxMouseMove,handles});
set(handles.SmartLab,'WindowButtonUpFcn',{@TemplateAddPeakBoxMouseButtonUpFcn,handles});
guidata(hObject,handles);


function TemplateAddPeakBoxMouseMove(hObject,eventdata,handles)

pt=get(gca,'CurrentPoint');
x2=pt(1,1);
y2=pt(1,2);
h_AddPeakBox=findobj('Tag','AddPeakBox');
x_boxdata=get(h_AddPeakBox,'XData');
y_boxdata=get(h_AddPeakBox,'YData');
x1=x_boxdata(1);
y1=y_boxdata(1);
x_boxdata=[x1 x1 x2 x2 x1];
y_boxdata=[y1 y2 y2 y1 y1];
set(h_AddPeakBox,'XData',x_boxdata,'YData',y_boxdata,'Visible','on');
guidata(hObject,handles);



function  TemplateAddPeakBoxMouseButtonUpFcn(hObject,eventdata,handles)
set(handles.SmartLab,'WindowButtonMotionFcn',[]);
set(handles.SmartLab,'WindowButtonUpFcn',[]);

h_AddPeakBox=findobj('Tag','AddPeakBox','Type','line');
% h_markerbox=gco;
x_boxdata=get(h_AddPeakBox,'XData'); %only one object, otherwise it will have problem
y_boxdata=get(h_AddPeakBox,'YData');
x1=x_boxdata(1); %the begining position
y1=y_boxdata(1);
x2=x_boxdata(3);
y2=y_boxdata(3);
% x_boxbegin=round(min([x1 x2])); %the version before 10/22/2014
% x_boxend=round(max([x1 x2]));
x_boxbegin=min([x1 x2]);
x_boxend=max([x1 x2]);
y_boxlow=min([y1 y2]);
y_boxhigh=max([y1 y2]);
x_boxdata=[x_boxbegin x_boxbegin x_boxend x_boxend x_boxbegin];
y_boxdata=[y_boxlow y_boxhigh y_boxhigh y_boxlow y_boxlow];
set(h_AddPeakBox,'XData',x_boxdata,'YData',y_boxdata);


cmenu_peakbox=uicontextmenu;
item1=uimenu(cmenu_peakbox,'Label','Remove','Callback',{@TemplatePeakBoxManipulate,handles});
item2=uimenu(cmenu_peakbox,'Label','Detect','Callback',{@TemplatePeakBoxManipulate,handles});
item3=uimenu(cmenu_peakbox,'Label','Det. Reset','Callback',{@TemplatePeakBoxManipulate,handles});
item4=uimenu(cmenu_peakbox,'Label','Dual Fitting','Callback',{@TemplatePeakBoxManipulate,handles});
set(h_AddPeakBox,'UIContextMenu',cmenu_peakbox);
guidata(hObject,handles);
return;




function TemplatePeakBoxManipulate(hObject,eventdata,handles)

FigureUserData=[];
FigureUserData=get(handles.SmartLab,'UserData');
FilterChannel1=FigureUserData.FilterChannel1;
FilterChannel2=FigureUserData.FilterChannel2;
DataTime=FigureUserData.DataTime;

str=get(hObject,'Label');
h_AddPeakBox=findobj('Tag','AddPeakBox','Type','line');
% h_markerbox=gco;
x_boxdata=get(h_AddPeakBox,'XData'); %only one object, otherwise it will have problem
y_boxdata=get(h_AddPeakBox,'YData');
x1=x_boxdata(1); %the begining position
y1=y_boxdata(1);
x2=x_boxdata(3);
y2=y_boxdata(3);
x_boxbegin=min([x1 x2]);
x_boxend=max([x1 x2]);
BEIX=[];
BEIX=find(DataTime>=x_boxbegin&DataTime<=x_boxend);
x_boxbeginIX=BEIX(1);
x_boxendIX=BEIX(end);

%firstly to remove all peaks in the box and then flip the peaks within
%the box;

try
    h_TempAPPeak=[];
    h_TempAPPeak=findobj(get(gca,'Children'),'Tag','TempAPPeak');
    h_TempDecayFit=[];
    h_TempDecayFit=findobj(get(gca,'Children'),'Tag','TempDecayFit');
    
    TempAPPeakTime=[];
    TempAPPeak_UserData=[];
    if length(h_TempAPPeak)>1
        TempAPPeakTime=cell2mat(get(h_TempAPPeak,'XData'));
        %    TempAPPeak_UserData=cell2mat(get(h_TempAPPeak,'UserData'));
        TempAPPeak_UserData=get(h_TempAPPeak,'UserData');
        
    else
        TempAPPeakTime=get(h_TempAPPeak,'XData');
        TempAPPeak_UserData=get(h_TempAPPeak,'UserData');
    end
    % TempAPPeakTime
    % TempAPPeak_UserData
    
    
    IX=[];
    if ~isempty(TempAPPeakTime)
        IX=find(TempAPPeakTime>x_boxbegin&TempAPPeakTime<x_boxend);
    end
    
    if ~isempty(IX)
        delete(h_TempAPPeak(IX));
        if ~isempty(h_TempDecayFit)
            for iter=1:length(IX)
                delete(TempAPPeak_UserData(IX(iter),1));
                delete(TempAPPeak_UserData(IX(iter),2));
                if ~isnan(TempAPPeak_UserData(IX(iter),3))
                    delete(TempAPPeak_UserData(IX(iter),3));
                    
                end
                
            end
        else
            delete(TempAPPeak_UserData(IX,1:2));
            
        end
    end
    
catch
    ;
end

% if x_boxend-x_boxbegin<20
%     return;
% end

% add new markers among the box, choose the signal in the box


if strcmp('Detect',str)
    
    
    
    %find the singal
    h_TempAPPeak=[];

    h_WaveletDenoiseSignal=[];
    try
        h_WaveletDenoiseSignal=findobj(get(gca,'Children'),'Tag','FilterChannel1Signal');
        WaveletDenoiseSignal=get(h_WaveletDenoiseSignal(1),'YData');
        BoxSignal=[];
        BoxSignal=WaveletDenoiseSignal(x_boxbeginIX:x_boxendIX);
    catch exception
        h_WaveletDenoiseSignal=findobj(get(gca,'Children'),'Tag','FilterChannel2Signal');
        WaveletDenoiseSignal=get(h_WaveletDenoiseSignal(1),'YData');
        BoxSignal=[];
        BoxSignal=WaveletDenoiseSignal(x_boxbeginIX:x_boxendIX);
        
    end
    
    BoxAddAPPeakTime=[];BoxAddAPPeakValue=[];BoxAddAPPeakTimeIX=[];
    [BoxAddAPPeakValue BoxAddAPPeakTimeIX]=max(BoxSignal);
    NumberPeak=length(BoxAddAPPeakTimeIX);
    
    
    [BoxAddAPMaxDiff BoxAddAPMaxDiffIX BoxAddAPBaseValue BoxAddAPBaseTimeIX]=BoxActionPotentialMaxDvdtSmartLab(BoxSignal,BoxAddAPPeakTimeIX, BoxAddAPPeakValue);
    
    AddAPPeakTimeIX=x_boxbeginIX+BoxAddAPPeakTimeIX-1;
    AddAPMaxDiffTimeIX=x_boxbeginIX+BoxAddAPMaxDiffIX-1;
    AddAPBaseTimeIX=x_boxbeginIX+BoxAddAPBaseTimeIX-1;
    
    AddAPPeakTime=DataTime(AddAPPeakTimeIX);
    AddAPMaxDiffTime=DataTime(AddAPMaxDiffTimeIX);
    AddAPBaseTime=DataTime(AddAPBaseTimeIX);
        
    %draw the peak in the box
    cmenu=uicontextmenu;
    item1=uimenu(cmenu, 'Label','Delete','Callback',{@ChangePeakMarker_Callback,handles});
    h_AddAPPeak=[];
    for iter=1:length(AddAPPeakTime)
        
        h_AddAPDiffMax(iter)=plot(AddAPMaxDiffTime(iter),WaveletDenoiseSignal(AddAPMaxDiffTimeIX(iter)),'ko');
        set(h_AddAPDiffMax(iter),'Tag','TempAPDiffMax','LineWidth',3);
        
        h_AddAPBase(iter)=plot(AddAPBaseTime(iter),WaveletDenoiseSignal(AddAPBaseTimeIX(iter)),'k*');
        set(h_AddAPBase,'Tag','TempAPBase','LineWidth',3);
        
        h_AddAPPeak(iter)=plot(AddAPPeakTime(iter),WaveletDenoiseSignal(AddAPPeakTimeIX(iter)),'k*');
        set(h_AddAPPeak(iter),'LineWidth',3,'UIContextMenu',cmenu,'Tag','TempAPPeak');
        
        set(h_AddAPPeak(iter),'UserData',[h_AddAPDiffMax(iter) h_AddAPBase(iter)]);
    end
   
elseif strcmp('Det. Reset',str)
    
    h_TempAPBase1=[];
    h_TempAPBase1=findobj(get(handles.axes1,'Children'),'Tag','TempAPBase');
    h_TempAPBase2=[];
    h_TempAPBase2=findobj(get(handles.axes2,'Children'),'Tag','TempAPBase');
    
    h_TempAPDiffMax1=[];
    h_TempAPDiffMax1=findobj(get(handles.axes1,'Children'),'Tag','TempAPDiffMax');
    h_TempAPDiffMax2=[];
    h_TempAPDiffMax2=findobj(get(handles.axes2,'Children'),'Tag','TempAPDiffMax');
    
    h_TempDecayFit1=[];
    h_TempDecayFit1=findobj(get(handles.axes1,'Children'),'Tag','TempDecayFit');
    h_TempDecayFit2=[];
    h_TempDecayFit2=findobj(get(handles.axes2,'Children'),'Tag','TempDecayFit');
    
    h_TempAPPeak1=[];
    h_TempAPPeak1=findobj(get(handles.axes1,'Children'),'Tag','TempAPPeak');
    h_TempAPPeak2=[];
    h_TempAPPeak2=findobj(get(handles.axes2,'Children'),'Tag','TempAPPeak');
    
    h_AddPeakBox=[];
    h_AddPeakBox=findobj('Tag','AddPeakBox','Type','line');
    
    try
        delete(h_TempAPBase1);
    catch exception;
    end
    try 
        delete(h_TempAPBase2);
    catch exception
        ;
    end
    try  
        delete(h_TempAPDiffMax1);
    catch exception
        ;
    end
    try
        delete(h_TempAPDiffMax2);
    catch exception
        ;
    end
    try
        delete(h_TempAPPeak1);
    catch exception
        ;
    end
    try 
        delete(h_TempAPPeak2);
    catch exception
        ;
    end
    
    try
        delete(h_TempDecayFit1);
    catch exception
        ;
    end
    try
        delete(h_TempDecayFit2);
    catch exception
        ;
    end
   
elseif strcmp('Dual Fitting',str)
    
    XTime=[];
    YChannel1=[];
    YChannel2=[];
    
    XTime=DataTime(x_boxbeginIX:x_boxendIX);
    XTime=XTime-XTime(1);
    
    YChannel1=FilterChannel1(x_boxbeginIX:x_boxendIX);
    YChannel2=FilterChannel2(x_boxbeginIX:x_boxendIX);
    
    NYChannel1=(YChannel1-min(YChannel1))./(max(YChannel1)-min(YChannel1));
    NYChannel2=(YChannel2-min(YChannel2))./(max(YChannel2)-min(YChannel2));

    %the dual model is like
    %CaT=C0+C_Active(1-exp(-t/Tau_Active))+C_Deactive(exp(-t/Tau_Deactive))
    DualFitFun=@(b,x)(b(1)+b(2)*(1-exp(-x/b(3)))+b(4)*exp(-x/b(5)));
    
    if (gca==handles.axes1)
        
        MaxNY1=[];IXMax=[];
        [MaxNY1,IXMax]=max(NYChannel1);
        C01=[]; C_Active1=[]; Tau_Active1=[]; C_Deactive1=[]; Tau_Deactive1=[];
        C01=NYChannel1(1);
        C_Active1=max(NYChannel1)-C01;
        C_Deactive1=max(NYChannel1)-NYChannel1(end);
        Tau_Active1=XTime(IXMax)/3;
        Tau_Deactive1=(XTime(end)-XTime(IXMax))/3;
        b0=[C01;C_Active1;Tau_Active1;C_Deactive1;Tau_Deactive1];
        b=[];
        b=nlinfit(XTime,NYChannel1,DualFitFun,b0);
        C0=b(1); C_Active=b(2); Tau_Active=b(3); C_Deactive=b(4); Tau_Deactive=b(5);
        FittingChannel=C0+C_Active*(1-exp(-XTime./Tau_Active))+C_Deactive*(exp(-XTime./Tau_Deactive));
        NYChannel=NYChannel1;
        
    elseif (gca==handles.axes2)
        
        MaxNY2=[]; IXMax=[];
        [MaxNY2,IXMax]=max(NYChannel2);
        C02=[]; C_Active2=[]; Tau_Active2=[]; C_Deactive2=[]; Tau_Deactive2=[];
        C02=NYChannel1(1);
        C_Active2=max(NYChannel2)-C02;
        C_Deactive2=max(NYChannel2)-NYChannel2(end);
        Tau_Active2=XTime(IXMax)/3;
        Tau_Deactive2=(XTime(end)-XTime(IXMax))/3;
        b0=[C02;C_Active2;Tau_Active2;C_Deactive2;Tau_Deactive2];
        b=[];
        b=nlinfit(XTime,NYChannel2,DualFitFun,b0);
        C0=b(1); C_Active=b(2); Tau_Active=b(3); C_Deactive=b(4); Tau_Deactive=b(5);
        FittingChannel=C0+C_Active*(1-exp(-XTime./Tau_Active))+C_Deactive*(exp(-XTime./Tau_Deactive));
        NYChannel=NYChannel2;
    end
    
    
    hf1=figure;
    hline1=plot(XTime,NYChannel);
    hold on;
    hline2=plot(XTime,FittingChannel);
    set(hline1,'Color','b','LineWidth',2);
    set(hline2,'Color','r','LineWidth',2);
    legend('First Channel','Fitted');
    set(gca,'Position',[0.13 0.1  0.78 0.8]);
    
    myData={...
            'Channel'   'C0'   'C_Active'  'Tau_Active'  'C_Deactive'   'Tau_Deactive';
            'Channel'  num2str(C0) num2str(C_Active) num2str(Tau_Active) num2str(C_Deactive) num2str(Tau_Deactive);
            }
    uit=uitable(hf1,'Units','normalized','Data',myData);
    set(uit,'position',[0.2 0.12 0.6 0.1]);
end

try 
   delete(h_AddPeakBox);
catch exception
    ;
end
guidata(hObject,handles);

return;




function WaveletDenoiseSignal=WaveletDenoise(MapData)
%reduce the edge effect, prolong the signal to
WaveletDenoiseSignal= wden(MapData,'minimaxi','s','sln',3,'sym8');

% 'heursure','h','one',8,'db1'

% onedimenautomaticwaveletdenoise(MapData,);
return;


function [xd,cxd,lxd] = onedimenautomaticwaveletdenoise(in1,in2,in3,in4,in5,in6,in7)
nbIn = nargin;
switch nbIn
    case {0,1,2,3,4,5}  , error('Not enough input arguments.');
    case 6 ,
        x = in1; tptr = in2; sorh = in3;
        scal = in4; n = in5; w = in6;
    case 7 ,
        c = in1; l = in2; tptr = in3;
        sorh = in4; scal = in5; n = in6; w = in7;
end
if errargt(mfilename,tptr,'str'), error('*'), end
if errargt(mfilename,sorh,'str'), error('*'), end
if errargt(mfilename,scal,'str'), error('*'), end
if errargt(mfilename,n,'int'), error('*'), end
if errargt(mfilename,w,'str'), error('*'), end

if nbIn==6
    % Wavelet decomposition of x.
    [c,l] = wavedec(x,n,w);
end

% Threshold rescaling coefficients.
switch scal
    case 'one' , s = ones(1,n);
    case 'sln' , s = ones(1,n)*wnoisest(c,l,1);
    case 'mln' , s = wnoisest(c,l,1:n);
    otherwise  , error('Invalid argument value.')
end

% Wavelet coefficients thresholding.
first = cumsum(l)+1;
first = first(end-2:-1:1);
ld   = l(end-1:-1:2);
last = first+ld-1;
cxd = c;
lxd = l;
for k = 1:n
    flk = first(k):last(k);
    if tptr=='sqtwolog' | tptr=='minimaxi'
        thr = thselect(c,tptr);
    else
        if s(k) < sqrt(eps) * max(c(flk))
            thr = 0;
        else
            thr = thselect(c(flk)/s(k),tptr);
        end
    end                                     % threshold.
    thr      = thr * s(k);                  % rescaled threshold.
    cxd(flk) = wthresh(c(flk),sorh,thr);    % thresholding or shrinking.
end

% Wavelet reconstruction of xd.
xd = waverec(cxd,lxd,w);
return



% --------------------------------------------------------------------
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --------------------------------------------------------------------
function ExportResults_Callback(hObject, eventdata, handles)
% hObject    handle to ExportResults (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%again, display the table and write to the excel file


%save results into .mat and excel
FigureUserData=[];
FigureUserData=get(handles.SmartLab,'UserData');


h_APPeak1=[];h_APPeak2=[];
h_APBase1=[];h_APBase2=[];
h_APMaxDiff1=[];h_APMaxDiff2=[];

h_APPeak1=findobj(get(handles.axes1,'Children'),'Tag','TempAPPeak');
h_APBase1=findobj(get(handles.axes1,'Children'),'Tag','TempAPBase');
h_APPeak2=findobj(get(handles.axes2,'Children'),'Tag','TempAPPeak');
h_APBase2=findobj(get(handles.axes2,'Children'),'Tag','TempAPBase');
h_APMaxDiff1=findobj(get(handles.axes1,'Children'),'Tag','TempAPDiffMax');
h_APMaxDiff2=findobj(get(handles.axes2,'Children'),'Tag','TempAPDiffMax');


h_APPeak1=[];
h_APPeak1=findobj(get(handles.axes1,'Children'),'Tag','TempAPPeak');
h_APPeak2=[];
h_APPeak2=findobj(get(handles.axes2,'Children'),'Tag','TempAPPeak');

h_APBase1=[];
h_APBase1=findobj(get(handles.axes1,'Children'),'Tag','TempAPBase');
h_APBase2=[];
h_APBase2=findobj(get(handles.axes2,'Children'),'Tag','TempAPBase');

h_APDiffMax1=[];
h_APDiffMax1=findobj(get(handles.axes1,'Children'),'Tag','TempAPDiffMax');
h_APDiffMax2=[];
h_APDiffMax2=findobj(get(handles.axes2,'Children'),'Tag','TempAPDiffMax');

% 
% h_DecayFit1=[];
% h_DecayFit1=findobj(get(handles.axes1,'Children'),'Tag','TempDecayFit');
% h_DecayFit2=[];
% h_DecayFit2=findobj(get(handles.axes2,'Children'),'Tag','TempDecayFit');

if isempty(h_APPeak1)
    return;
end

if length(h_APPeak1)~=length(h_APPeak2)
    warndlg('Markers of Channel I and II NOT equal!');
    return;
end

APPeakTime1=[];
APBaseTime1=[];
sh_APPeak1=[];
APPeakUserData1=[];
% APPeakValue1=[];
% APBaseValue1=[];
IX1=[];
if length(h_APPeak1)>1
    [APPeakTime1 IX1]=sort(cell2mat(get(h_APPeak1,'XData')));
    APBaseTime1=sort(cell2mat(get(h_APBase1,'XData')));
%     APPeakValue1=cell2mat(get(h_APPeak1,'YData'));
%     APBaseValue1=cell2mat(get(h_APBase1,'YData'));
%     APPeakValue1=APPeakValue1(IX1);
%     APBaseValue1=APBaseValue1(IX1);
    sh_APPeak1=h_APPeak1(IX1);
    APPeakUserData1=cell2mat(get(sh_APPeak1,'UserData'));
    APMaxDiffTime1=sort(cell2mat(get(h_APDiffMax1,'XData')));
    
else
    APPeakTime1=get(h_APPeak1,'XData');
    APBaseTime1=get(h_APBase1,'XData');
%     APPeakValue1=cell2mat(get(h_APPeak1,'YData'));
%     APBaseValue1=cell2mat(get(h_APBase1,'YData'));
    APPeakUserData1=get(h_APPeak1,'UserData');
    APMaxDiffTime1=get(h_APDiffMax1,'XData');
end


%APPeak Userdata (1)h_TempAPDiffMax;(2)h_TempAPDiffMax (3) h_DecayFit;
   %(4) Beta; (5) DecayDuration 50%;


APPeakTime2=[];
APBaseTime2=[];
sh_APPeak2=[];
APPeakUserData2=[];
% APPeakValue2=[];
% APBaseValue2=[];
IX2=[];
if length(h_APPeak2)>1
    [APPeakTime2 IX2]=sort(cell2mat(get(h_APPeak2,'XData')));
    APBaseTime2=sort(cell2mat(get(h_APBase2,'XData')));
%     APPeakValue2=cell2mat(get(h_APPeak2,'YData'));
%     APBaseValue2=cell2mat(get(h_APBase2,'YData'));
%     APPeakValue2=APPeakValue1(IX2);
%     APBaseValue2=APBaseValue1(IX2);
    sh_APPeak2=h_APPeak2(IX2);
    APPeakUserData2=cell2mat(get(sh_APPeak2,'UserData'));
    APMaxDiffTime2=sort(cell2mat(get(h_APDiffMax2,'XData')));
    
else
    APPeakTime2=get(h_APPeak2,'XData');
    APBaseTime2=get(h_APBase2,'XData');
%     APPeakValue2=cell2mat(get(h_APPeak2,'YData'));
%     APBaseValue2=cell2mat(get(h_APBase2,'YData'));
    APPeakUserData2=get(sh_APPeak2,'UserData');
    APMaxDiffTime2=get(h_APDiffMax2,'XData');
end


DataTime=FigureUserData.DataTime;
APBaseTimeIX1=FindIX(DataTime,APBaseTime1);
APBaseTimeIX2=FindIX(DataTime,APBaseTime2);
APPeakTimeIX1=FindIX(DataTime,APPeakTime1);
APPeakTimeIX2=FindIX(DataTime,APPeakTime2);

FilterChannel1=FigureUserData.FilterChannel1;
FilterChannel2=FigureUserData.FilterChannel2;
APBaseValue1=FilterChannel1(APBaseTimeIX1);
APBaseValue2=FilterChannel2(APBaseTimeIX2);
APPeakValue1=FilterChannel1(APPeakTimeIX1);
APPeakValue2=FilterChannel2(APPeakTimeIX2);


DecayDurationTime1=APPeakUserData1(:,5);
DecayTao1=APPeakUserData1(:,4);
DecayDurationTime2=APPeakUserData2(:,5);
DecayTao2=APPeakUserData2(:,4);


N=length(APPeakTime1);
DisplayData=cell(2*N,12);
%BeatID, Channel, APBaseTime, APMaxDiffTime, APPeakTime APBaseToPeakTime %1-6
%DecayDuration DecayBeta(Tao) DeltaAPRisingTime DeltaDecayDuration %7-10
columnname={'No' 'Channel' 'Base' 'Diff' 'Peak' 'Rising' 'Decay' 'Tao' 'DeltaRising' 'DeltaDecay'};

for iter=1:N
      DisplayData{2*iter-1,1}=iter;
     DisplayData{2*iter,1}=iter;
     DisplayData{2*iter-1,2}='Ch I'; %Beat Number
     DisplayData{2*iter,2}='Ch II';
     DisplayData{2*iter-1,3}=APBaseTime1(iter);
     DisplayData{2*iter,3}=APBaseTime2(iter);
     DisplayData{2*iter-1,4}=APBaseValue1(iter);
     DisplayData{2*iter,4}=APBaseValue2(iter);
     DisplayData{2*iter-1,5}=APMaxDiffTime1(iter);
     DisplayData{2*iter,5}=APMaxDiffTime2(iter);
     DisplayData{2*iter-1,6}=APPeakTime1(iter);
     DisplayData{2*iter,6}=APPeakTime2(iter);
     DisplayData{2*iter-1,7}=APPeakValue1(iter);
     DisplayData{2*iter,7}=APPeakValue2(iter);
     DisplayData{2*iter-1,8}=APPeakTime1(iter)-APBaseTime1(iter);
     DisplayData{2*iter,8}=APPeakTime2(iter)-APBaseTime2(iter);
     DisplayData{2*iter-1,9}=DecayDurationTime1(iter);
     DisplayData{2*iter,9}=DecayDurationTime2(iter);
     DisplayData{2*iter-1,10}=DecayTao1(iter);
     DisplayData{2*iter,10}=DecayTao2(iter);
     DisplayData{2*iter-1,11}=NaN;
     DisplayData{2*iter,11}=(APPeakTime2(iter)-APBaseTime2(iter))-(APPeakTime1(iter)-APBaseTime1(iter));
     DisplayData{2*iter-1,12}=NaN;
     DisplayData{2*iter,12}=DecayDurationTime2(iter)-DecayDurationTime1(iter);
end

AnalysisResults=cell(2*N+1,12);
AnalysisResults(1,1:12)={'Beat ID' 'Channel' 'Start Time(msec)' 'Diastolic Value(au)' 'Max Diff Time(msec)' 'Peak Time(msec)' 'Peak Value(au)' 'Rising Time(msec)' 'Decay Time(50%,msec)' 'Tao(msec)' 'DeltaRising' 'DeltaDecay'};
AnalysisResults(2:end,1:12)=DisplayData;

% 
% 
% f=figure('Position',[100 100 900 450]);
% t=uitable('Units','normalized', ...
%            'Position',[0.1 0.1 0.9 0.9],...
%            'Data', DisplayData,... 
%            'ColumnName', columnname,...
%            'RowName',[]);
filename=[handles.pathname handles.filename(1:end-4) 'Results.xlsx'];
% writetable(t,filename,'Sheet',1);
% writetable(t,filename,'Sheet',2,'WriteVariableNames',false);

fidexist=[];
fidexist=exist(filename);
if (fidexist==2)
   delete(filename);
end
xlswrite(filename,AnalysisResults);
       
%write the table into the 
% former version
% Results(:,20)=Beta2(:,1)*(1/SampleTime);
% Results(:,21)=Beta2(:,3)*(1/SampleTime);
% 
% 
% AnalysisResults=cell(8,21);
% AnalysisResults(1,1:21)={ ...
%   'BaseValue1'  'BaseValue2'   'BaseTime1'  'BaseTime2'  'DeltaBaseValue' 'DeltaBaseTime' ... 
%   'PeakValue1'  'PeakValue2'   'PeakTime1'  'PeakTime2'  'DeltaPeakValue' 'DeltaPeakTime' ...
%   'BaseToPeak1' 'BaseToPeak2'  'PeakToEnd1' 'PeakToEnd2' 'BaseToEnd1'     'BaseToEnd2'    ...
%   'DecayBeta1E'  'DecayBeta2E' 'DecayBeta2L' ... 
%   };
% AnalysisResults(2:1+size(Results,1),:)=num2cell(Results);
% 
% fname=handles.filename;
% 
% fidexist=[];
% fidexist=exist([handles.pathname fname(1:end-4) 'Results.xls'])
% if (fidexist==2)
%    delete([handles.pathname fname(1:end-4) 'Results.xls'])
% end
% xlswrite([handles.pathname fname(1:end-4) 'Results'],AnalysisResults);
% save([handles.pathname fname(1:end-4) 'Results'],'FigureUserData','AnalysisResults');
% 





return;



% --------------------------------------------------------------------
function Clean_Callback(hObject, eventdata, handles)
% hObject    handle to Clean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

h_TempAPBase1=[];
h_TempAPBase1=findobj(get(handles.axes1,'Children'),'Tag','TempAPBase');
h_TempAPBase2=[];
h_TempAPBase2=findobj(get(handles.axes2,'Children'),'Tag','TempAPBase');

h_TempAPDiffMax1=[];
h_TempAPDiffMax1=findobj(get(handles.axes1,'Children'),'Tag','TempAPDiffMax');
h_TempAPDiffMax2=[];
h_TempAPDiffMax2=findobj(get(handles.axes2,'Children'),'Tag','TempAPDiffMax');

h_TempDecayFit1=[];
h_TempDecayFit1=findobj(get(handles.axes1,'Children'),'Tag','TempDecayFit');
h_TempDecayFit2=[];
h_TempDecayFit2=findobj(get(handles.axes2,'Children'),'Tag','TempDecayFit');

h_TempAPPeak1=[];
h_TempAPPeak1=findobj(get(handles.axes1,'Children'),'Tag','TempAPPeak');
h_TempAPPeak2=[];
h_TempAPPeak2=findobj(get(handles.axes2,'Children'),'Tag','TempAPPeak');

h_AddPeakBox=[];
h_AddPeakBox=findobj('Tag','AddPeakBox','Type','line');

try 
    delete(h_TempAPBase1);
    delete(h_TempAPBase2);
    delete(h_TempAPDiffMax1);
    delete(h_TempAPDiffMax2);
    delete(h_TempAPPeak1);
    delete(h_TempAPPeak2);
catch exception
   ; 
end

try 
    delete(h_TempDecayFit1);
    delete(h_TempDecayFit2);
catch exception
   ; 
end

try 
    delete(h_AddPeakBox);
catch exception
    ;
end
return

% --------------------------------------------------------------------
function Flip_Callback(hObject, eventdata, handles)
% hObject    handle to Flip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function NoFlip_Callback(hObject, eventdata, handles)
% hObject    handle to NoFlip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function FlipSignal_Callback(hObject, eventdata, handles)
% hObject    handle to FlipSignal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

FilgerSinalIX=[];
FilterSignalIX=findobj(get(gcf,'Children'),'Tag','FilterChannel2Signal');
if isempty(FilterSignalIX)
    
    FigureUserData=[];
    FigureUserData=get(handles.SmartLab,'UserData');
    DataTime=FigureUserData.DataTime;
    DataChannel1=FigureUserData.DataChannel1;
    DataChannel2=FigureUserData.DataChannel2;
    FigureUserData.DataChannel1=[];
    FigureUserData.DataChannel1=DataChannel2;
    FigureUserData.DataChannel2=[];
    FigureUserData.DataChannel2=DataChannel1;
    axes(handles.axes1);
    h_DataChannel1=plot(DataTime,FigureUserData.DataChannel1,'g');
    axes(handles.axes2);
    h_DataChannel2=plot(DataTime,FigureUserData.DataChannel2,'g');
    
    set(handles.SmartLab,'UserData',FigureUserData);
    
    linkaxes([handles.axes1 handles.axes2],'x');
    
end
guidata(hObject, handles);
return;



% --------------------------------------------------------------------
function Analysis_Callback(hObject, eventdata, handles)
% hObject    handle to Analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Display_Callback(hObject, eventdata, handles)
% hObject    handle to Display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%save results into .mat and excel
FigureUserData=[];
FigureUserData=get(handles.SmartLab,'UserData');


h_APPeak1=[];h_APPeak2=[];
h_APBase1=[];h_APBase2=[];
h_APMaxDiff1=[];h_APMaxDiff2=[];

h_APPeak1=findobj(get(handles.axes1,'Children'),'Tag','TempAPPeak');
h_APBase1=findobj(get(handles.axes1,'Children'),'Tag','TempAPBase');
h_APPeak2=findobj(get(handles.axes2,'Children'),'Tag','TempAPPeak');
h_APBase2=findobj(get(handles.axes2,'Children'),'Tag','TempAPBase');
h_APMaxDiff1=findobj(get(handles.axes1,'Children'),'Tag','TempAPDiffMax');
h_APMaxDiff2=findobj(get(handles.axes2,'Children'),'Tag','TempAPDiffMax');


h_APPeak1=[];
h_APPeak1=findobj(get(handles.axes1,'Children'),'Tag','TempAPPeak');
h_APPeak2=[];
h_APPeak2=findobj(get(handles.axes2,'Children'),'Tag','TempAPPeak');

h_APBase1=[];
h_APBase1=findobj(get(handles.axes1,'Children'),'Tag','TempAPBase');
h_APBase2=[];
h_APBase2=findobj(get(handles.axes2,'Children'),'Tag','TempAPBase');



h_APDiffMax1=[];
h_APDiffMax1=findobj(get(handles.axes1,'Children'),'Tag','TempAPDiffMax');
h_APDiffMax2=[];
h_APDiffMax2=findobj(get(handles.axes2,'Children'),'Tag','TempAPDiffMax');

% 
% h_DecayFit1=[];
% h_DecayFit1=findobj(get(handles.axes1,'Children'),'Tag','TempDecayFit');
% h_DecayFit2=[];
% h_DecayFit2=findobj(get(handles.axes2,'Children'),'Tag','TempDecayFit');

if isempty(h_APPeak1)
    return;
end

if length(h_APPeak1)~=length(h_APPeak2)
    warndlg('Markers of Channel I and II NOT equal!');
    return;
end

APPeakTime1=[];
APPeakValue1=[];
APBaseTime1=[];
APBaseValue1=[];
sh_APPeak1=[];
APPeakUserData1=[];
DecayTao1=[];
DecayDurationTime1=[];

for iter=1:length(h_APPeak1)
    
    APPeakTime1(iter)=get(h_APPeak1(iter),'XData');
    APPeakValue1(iter)=get(h_APPeak1(iter),'YData');
    
    h_APPeak1Temp_UserData=[];
    h_APPeak1Temp_UserData=get(h_APPeak1(iter),'UserData');
    
    APBaseTime1(iter)=get(h_APBase1(iter),'XData');
    APBaseValue1(iter)=get(h_APBase1(iter),'YData');
    
    APMaxDiffTime1(iter)=get(h_APDiffMax1(iter),'XData');
        
    h_DecayFit1_Temp=[];
    h_DecayFit1_Temp=h_APPeak1Temp_UserData(4);
    h_DecayFit1_Temp_UserData=get(h_DecayFit1_Temp,'UserData');
    DecayTao1(iter)=h_DecayFit1_Temp_UserData(1);
    DecayDurationTime1(iter)=h_DecayFit1_Temp_UserData(2);
end

IX1=[];
[APPeakTime1 IX1]=sort(APPeakTime1);
APPeakValue1=APPeakValue1(IX1);
APBaseTime1=APBaseTime1(IX1);
APBaseValue1=APBaseValue1(IX1);
APMaxDiffTime1=APMaxDiffTime1(IX1);
DecayTao1=DecayTao1(IX1);
DecayDurationTime1=DecayDurationTime1(IX1);

APPeakTime2=[];
APPeakValue2=[];
APBaseTime2=[];
APBaseValue2=[];
sh_APPeak2=[];
APPeakUserData2=[];
DecayTao2=[];
DecayDurationTime2=[];

for iter=1:length(h_APPeak2)
    
    APPeakTime2(iter)=get(h_APPeak2(iter),'XData');
    APPeakValue2(iter)=get(h_APPeak2(iter),'YData');
    
    h_APPeak2Temp_UserData=[];
    h_APPeak2Temp_UserData=get(h_APPeak2(iter),'UserData');
    
    APBaseTime2(iter)=get(h_APBase2(iter),'XData');
    APBaseValue2(iter)=get(h_APBase2(iter),'YData');
    
    APMaxDiffTime2(iter)=get(h_APDiffMax2(iter),'XData');
        
    h_DecayFit2_Temp=[];
    h_DecayFit2_Temp=h_APPeak2Temp_UserData(4);
    h_DecayFit2_Temp_UserData=get(h_DecayFit2_Temp,'UserData');
    DecayTao2(iter)=h_DecayFit2_Temp_UserData(1);
    DecayDurationTime2(iter)=h_DecayFit2_Temp_UserData(2);
end

IX2=[];
[APPeakTime2 IX2]=sort(APPeakTime2);
APPeakValue2=APPeakValue2(IX2);
APBaseTime2=APBaseTime2(IX2);
APBaseValue2=APBaseValue2(IX2);
APMaxDiffTime2=APMaxDiffTime2(IX2);
DecayTao2=DecayTao2(IX2);
DecayDurationTime2=DecayDurationTime2(IX2);

% 
% DataTime=FigureUserData.DataTime;
% APBaseTimeIX1=FindIX(DataTime,APBaseTime1);
% APBaseTimeIX2=FindIX(DataTime,APBaseTime2);
% APPeakTimeIX1=FindIX(DataTime,APPeakTime1);
% APPeakTimeIX2=FindIX(DataTime,APPeakTime2);
% 
% FilterChannel1=FigureUserData.FilterChannel1;
% FilterChannel2=FigureUserData.FilterChannel2;
% APBaseValue1=FilterChannel1(APBaseTimeIX1);
% APBaseValue2=FilterChannel2(APBaseTimeIX2);
% APPeakValue1=FilterChannel1(APPeakTimeIX1);
% APPeakValue2=FilterChannel2(APPeakTimeIX2);
% 
% DecayDurationTime1=APPeakUserData1(:,5);
% DecayTao1=APPeakUserData1(:,4);
% DecayDurationTime2=APPeakUserData2(:,5);
% DecayTao2=APPeakUserData2(:,4);
% 

N=length(APPeakTime1);
DisplayData=cell(2*N,12);
%BeatID, Channel, APBaseTime, APMaxDiffTime, APPeakTime APBaseToPeakTime %1-6
%DecayDuration DecayBeta(Tao) DeltaAPRisingTime DeltaDecayDuration %7-10
columnname={'No' 'Channel' 'BaseTime' 'BaseValue' 'MaxDiffTime' 'PeakTime' 'PeakValue' 'Rising(Base-Peak)' 'Decay Duration' 'Decay Tau' 'Delta Rising' 'Delta Decay'};

for iter=1:N
     DisplayData{2*iter-1,1}=iter;
     DisplayData{2*iter,1}=iter;
     DisplayData{2*iter-1,2}='Ch I'; %Beat Number
     DisplayData{2*iter,2}='Ch II';
     DisplayData{2*iter-1,3}=APBaseTime1(iter);
     DisplayData{2*iter,3}=APBaseTime2(iter);
     DisplayData{2*iter-1,4}=APBaseValue1(iter);
     DisplayData{2*iter,4}=APBaseValue2(iter);
     DisplayData{2*iter-1,5}=APMaxDiffTime1(iter);
     DisplayData{2*iter,5}=APMaxDiffTime2(iter);
     DisplayData{2*iter-1,6}=APPeakTime1(iter);
     DisplayData{2*iter,6}=APPeakTime2(iter);
     DisplayData{2*iter-1,7}=APPeakValue1(iter);
     DisplayData{2*iter,7}=APPeakValue2(iter);
     DisplayData{2*iter-1,8}=APPeakTime1(iter)-APBaseTime1(iter);%rising time from base to peak
     DisplayData{2*iter,8}=APPeakTime2(iter)-APBaseTime2(iter);%rising time from base to peak
     DisplayData{2*iter-1,9}=DecayDurationTime1(iter);
     DisplayData{2*iter,9}=DecayDurationTime2(iter);
     DisplayData{2*iter-1,10}=DecayTao1(iter);
     DisplayData{2*iter,10}=DecayTao2(iter);
     DisplayData{2*iter-1,11}=[];
     DisplayData{2*iter,11}=(APPeakTime2(iter)-APBaseTime2(iter))-(APPeakTime1(iter)-APBaseTime1(iter));
     DisplayData{2*iter-1,12}=[];
     DisplayData{2*iter,12}=DecayDurationTime2(iter)-DecayDurationTime1(iter);
end

f=figure('Position',[100 100 1000 450]);
t=uitable('Units','normalized', ...
           'Position',[0.1 0.1 0.9 0.9],...
           'Data', DisplayData,... 
           'ColumnName', columnname,...
           'RowName',[]);
 

return


function IX=FindIX(Time, SpTime)

IX=[];
for iter=1:length(SpTime)
    TIX=[];
    TIX=find(SpTime(iter)==Time);
    if isempty(TIX)
        warndlg('Time of the Peak/Base does not match!');
        return;
    else
        IX(iter)=TIX;
    end
end

return


% --------------------------------------------------------------------
function APDCal_Callback(hObject, eventdata, handles)
% hObject    handle to APDCal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

h_APPeak1=[];h_APPeak2=[];
h_APBase1=[];h_APBase2=[];

h_APPeak1=findobj(get(handles.axes1,'Children'),'Tag','TempAPPeak');
h_APBase1=findobj(get(handles.axes1,'Children'),'Tag','TempAPBase');
h_APPeak2=findobj(get(handles.axes2,'Children'),'Tag','TempAPPeak');
h_APBase2=findobj(get(handles.axes2,'Children'),'Tag','TempAPBase');

if isempty(h_APPeak1)|isempty(h_APPeak2)
    return;
end

if length(h_APPeak1)~=length(h_APPeak2)
    warndlg('Markers of Channel I and II NOT equal!');
    return;
end


APPeakTime1=[];
APBaseTime1=[];
APPeakValue1=[];
APBaseValue1=[];
IX1=[];
if length(h_APPeak1)>1
    [APPeakTime1 IX1]=sort(cell2mat(get(h_APPeak1,'XData')));
    APBaseTime1=sort(cell2mat(get(h_APBase1,'XData')));
    APPeakValue1=cell2mat(get(h_APPeak1,'YData'));
    APBaseValue1=cell2mat(get(h_APBase1,'YData'));
    APPeakValue1=APPeakValue1(IX1);
    APBaseValue1=APBaseValue1(IX1);
else
    APPeakTime1=get(h_APPeak1,'XData');
    APBaseTime1=get(h_APBase1,'XData');
    APPeakValue1=get(h_APPeak1,'YData');
    APBaseValue1=get(h_APBase1,'YData');
end

APPeakTime2=[];
APBaseTime2=[];
APPeakValue2=[];
APBaseValue2=[];
IX2=[];
if length(h_APPeak2)>1
    [APPeakTime2 IX2]=sort(cell2mat(get(h_APPeak2,'XData')));
    APBaseTime2=sort(cell2mat(get(h_APBase2,'XData')));
    APPeakValue2=cell2mat(get(h_APPeak2,'YData'));
    APBaseValue2=cell2mat(get(h_APBase2,'YData'));
    APPeakValue2=APPeakValue1(IX2);
    APBaseValue2=APBaseValue1(IX2);
    
else
    APPeakTime2=get(h_APPeak2,'XData');
    APBaseTime2=get(h_APBase2,'XData');
    APPeakValue2=get(h_APPeak2,'YData');
    APBaseValue2=get(h_APBase2,'YData');
end

sh_APPeak1=h_APPeak1(IX1);
sh_APPeak2=h_APPeak2(IX2);

FigureUserData=[];
FilterChannel1=[];
FilterChannel2=[];
FigureUserData=get(handles.SmartLab,'UserData');
FilterChannel1=FigureUserData.FilterChannel1;
FilterChannel2=FigureUserData.FilterChannel2;
DataTime=FigureUserData.DataTime;


%the following codes are for the dicede the IX of the APPeakTime and
%APBaseTime

APPeakTimeIX1=[];APBaseTimeIX1=[];
APPeakTimeIX2=[];APBaseTimeIX2=[];
APPeakTimeIX1=FindIX(DataTime,APPeakTime1);
APBaseTimeIX1=FindIX(DataTime,APBaseTime1);
APPeakTimeIX2=FindIX(DataTime,APPeakTime2);
APBaseTimeIX2=FindIX(DataTime,APBaseTime2);

%calculate the 50% decending of the value
N=length(APPeakTime1);
DecayRatio=0.5;
sh_APPeak1=h_APPeak1(IX1);
sh_APPeak2=h_APPeak2(IX2);
for iter=1:N
    if iter<N
        x1=[];
        y1=[];
        x2=[];
        y2=[];
        DuIX1=[];
        DuIX2=[];

        x1=[APPeakTimeIX1(iter):APBaseTimeIX1(iter+1)];
        y1=FilterChannel1(x1);
        DuIX1=DecayDuration(x1,y1,DecayRatio);
        DecayDuration1(iter)=DataTime(DuIX1)-DataTime(x1(1));
        
        x2=[APPeakTimeIX2(iter):APBaseTimeIX2(iter+1)];
        y2=FilterChannel2(x2);
        DuIX2=DecayDuration(x2,y2,DecayRatio);
        DecayDuration2(iter)=DataTime(DuIX2)-DataTime(x2(1));
        
                
        sh_APPeak1_UserData=[];
        sh_APPeak1_UserData=get(sh_APPeak1(iter),'UserData');
        h_DecayFit1=sh_APPeak1_UserData(4);
        h_DecayFit1_UserData=get(h_DecayFit1,'UserData');
        h_DecayFit1_UserData(2)=DecayDuration1(iter);
        set(h_DecayFit1,'UserData',h_DecayFit1_UserData);
        
        
        sh_APPeak2_UserData=[];
        sh_APPeak2_UserData=get(sh_APPeak2(iter),'UserData');
        h_DecayFit2=sh_APPeak2_UserData(4);
        h_DecayFit2_UserData=get(h_DecayFit2,'UserData');
        h_DecayFit2_UserData(2)=DecayDuration2(iter);
        set(h_DecayFit2,'UserData',h_DecayFit2_UserData);
        
        
        
    
    else
        
        sh_APPeak1_UserData=[];
        sh_APPeak1_UserData=get(sh_APPeak1(iter),'UserData');
        h_DecayFit1=sh_APPeak1_UserData(4);
        h_DecayFit1_UserData=get(h_DecayFit1,'UserData');
        x1=[];
        x1=[APPeakTimeIX1(iter):length(FilterChannel1)];
        y1=[];
        y1=FilterChannel1(x1);
        DuIX1=[];
        DuIX1=DecayDuration(x1,y1,DecayRatio);
        DecayDuration1(iter)=DataTime(DuIX1)-DataTime(x1(1));
        h_DecayFit1_UserData(2)=DecayDuration1(iter);
        set(h_DecayFit1,'UserData',h_DecayFit1_UserData);
        
        
        sh_APPeak2_UserData=[];
        sh_APPeak2_UserData=get(sh_APPeak2(iter),'UserData');
        h_DecayFit2=sh_APPeak2_UserData(4);
        h_DecayFit2_UserData=get(h_DecayFit2,'UserData');
        DuIX2=[];
        x2=[];
        x2=[APPeakTimeIX2(iter):length(FilterChannel2)];
        y2=[];
        y2=FilterChannel2(x2);
        DuIX2=DecayDuration(x2,y2,DecayRatio);
        DecayDuration2(iter)=DataTime(DuIX1)-DataTime(x1(1));
        h_DecayFit2_UserData(2)=DecayDuration2(iter);
        set(h_DecayFit2,'UserData',h_DecayFit2_UserData);
        
    end
end
FigureUserData.DecayDuration1=DecayDuration1;
FigureUserData.DecayDuration2=DecayDuration2;
set(handles.SmartLab,'UserData',FigureUserData);
guidata(hObject, handles);
return;



function DuIX=DecayDuration(x,y,DecayRatio)

DecayThre=y(end)+(y(1)-y(end))*0.5;
AboveThreIX=[];
AboveThreIX=find(y>=DecayThre);
IXX=AboveThreIX(end);
DuIX=x(IXX);
return



% --------------------------------------------------------------------
function AreaInteg_Callback(hObject, eventdata, handles)
% hObject    handle to AreaInteg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


set(handles.axes1,'ButtonDownFcn',{@IntegBox_ButtonDownFcn,handles});
set(handles.axes2,'ButtonDownFcn',{@IntegBox_ButtonDownFcn,handles});
guidata(hObject, handles);
return;


function IntegBox_ButtonDownFcn(hObject,eventdata,handles)
h_OldIntegBox=findobj('Tag','IntegBox','Type','line');
if ~isempty(h_OldIntegBox)
    delete(h_OldIntegBox);
end
pt=get(gca,'CurrentPoint');
x1=pt(1,1);
y1=pt(1,2);
x2=x1;
y2=y1;
x_boxdata=[x1 x1 x2 x2 x1];
y_boxdata=[y1 y2 y2 y1 y1];
h_IntegBox=plot(x_boxdata,y_boxdata,'Tag','IntegBox',...
    'Linestyle',':','color',[230/255 110/255 25/255],'Linewidth',0.2,'Visible','off');
set(handles.SmartLab,'WindowButtonMotionFcn',{@IntegBox_MouseMove,handles});
set(handles.SmartLab,'WindowButtonUpFcn',{@IntegBox_MouseButtonUpFcn,handles});
guidata(hObject,handles);

function IntegBox_MouseMove(hObject,eventdata,handles)
pt=get(gca,'CurrentPoint');
x2=pt(1,1);
y2=pt(1,2);
h_IntegBox=findobj('Tag','IntegBox');
x_boxdata=get(h_IntegBox,'XData');
y_boxdata=get(h_IntegBox,'YData');
x1=x_boxdata(1);
y1=y_boxdata(1);
x_boxdata=[x1 x1 x2 x2 x1];
y_boxdata=[y1 y2 y2 y1 y1];
set(h_IntegBox,'XData',x_boxdata,'YData',y_boxdata,'Visible','on');
guidata(hObject,handles);


function  IntegBox_MouseButtonUpFcn(hObject,eventdata,handles)
set(handles.SmartLab,'WindowButtonMotionFcn',[]);
set(handles.SmartLab,'WindowButtonUpFcn',[]);

h_IntegBox=findobj('Tag','IntegBox','Type','line');
% h_markerbox=gco;
x_boxdata=get(h_IntegBox,'XData'); %only one object, otherwise it will have problem
y_boxdata=get(h_IntegBox,'YData');
x1=x_boxdata(1); %the begining position
y1=y_boxdata(1);
x2=x_boxdata(3);
y2=y_boxdata(3);
x_boxbegin=round(min([x1 x2])); %the version before 10/22/2014
x_boxend=round(max([x1 x2]));
y_boxlow=min([y1 y2]);
y_boxhigh=max([y1 y2]);
x_boxdata=[x_boxbegin x_boxbegin x_boxend x_boxend x_boxbegin];
y_boxdata=[y_boxlow y_boxhigh y_boxhigh y_boxlow y_boxlow];
set(h_IntegBox,'XData',x_boxdata,'YData',y_boxdata);

cmenu_integbox=uicontextmenu;
item1=uimenu(cmenu_integbox,'Label','Integration','Callback',{@IntegBoxManipulate,handles});
item2=uimenu(cmenu_integbox,'Label','Disable','Callback',{@IntegBoxManipulate,handles});
set(h_IntegBox,'UIContextMenu',cmenu_integbox);
guidata(hObject,handles);
return;


function IntegBoxManipulate(hObject,eventdata,handles)

FigureUserData=[];
FigureUserData=get(handles.SmartLab,'UserData');
FilterChannel1=FigureUserData.FilterChannel1;
FilterChannel2=FigureUserData.FilterChannel2;
DataTime=FigureUserData.DataTime;

str=get(hObject,'Label');
h_IntegBox=findobj('Tag','IntegBox','Type','line');
% h_markerbox=gco;
x_boxdata=get(h_IntegBox,'XData'); %only one object, otherwise it will have problem
y_boxdata=get(h_IntegBox,'YData');
x1=x_boxdata(1); %the begining position
y1=y_boxdata(1);
x2=x_boxdata(3);
y2=y_boxdata(3);
x_boxbegin=min([x1 x2]);
x_boxend=max([x1 x2]);
BEIX=[];
BEIX=find(DataTime>=x_boxbegin&DataTime<=x_boxend);
x_boxbeginIX=BEIX(1);
x_boxendIX=BEIX(end);



if strcmp('Integration',str)
    
    h_WaveletDenoiseSignal=[];
    try
        h_WaveletDenoiseSignal=findobj(get(gca,'Children'),'Tag','FilterChannel1Signal');
        WaveletDenoiseSignal=get(h_WaveletDenoiseSignal(1),'YData');
        BoxSignal=[];
        BoxSignal=WaveletDenoiseSignal(x_boxbeginIX:x_boxendIX);
        ChannelNo=1;
    catch exception
        h_WaveletDenoiseSignal=findobj(get(gca,'Children'),'Tag','FilterChannel2Signal');
        WaveletDenoiseSignal=get(h_WaveletDenoiseSignal(1),'YData');
        BoxSignal=[];
        BoxSignal=WaveletDenoiseSignal(x_boxbeginIX:x_boxendIX);
        ChannelNo=2;
    end
    
    IntegrationArea=trapz(DataTime(BEIX),BoxSignal);
    h=msgbox(['Channel' num2str(ChannelNo) ' Integration=' num2str(IntegrationArea)]);
   
elseif strcmp('Disable',str)
    set(handles.axes1,'ButtonDownFcn',[]);
    set(handles.axes2,'ButtonDownFcn',[]);
    set(handles.SmartLab,'WindowButtonMotionFcn',[]);
    set(handles.SmartLab,'WindowButtonUpFcn',[]);
    
end
% 
try
    
    delete(h_IntegBox);
catch exception
    ;
end
guidata(hObject,handles);

return;


% --------------------------------------------------------------------
function LastAPRestDecay_Callback(hObject, eventdata, handles)
% hObject    handle to LastAPRestDecay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


set(handles.axes1,'ButtonDownFcn',{@APRestBox_ButtonDownFcn,handles});
set(handles.axes2,'ButtonDownFcn',{@APRestBox_ButtonDownFcn,handles});
guidata(hObject, handles);
return;


function APRestBox_ButtonDownFcn(hObject,eventdata,handles)
h_OldAPRestBox=findobj('Tag','APRestBox','Type','line');
if ~isempty(h_OldAPRestBox)
    delete(h_OldAPRestBox);
end
pt=get(gca,'CurrentPoint');
x1=pt(1,1);
y1=pt(1,2);
x2=x1;
y2=y1;
x_boxdata=[x1 x1 x2 x2 x1];
y_boxdata=[y1 y2 y2 y1 y1];
h_APRestBox=plot(x_boxdata,y_boxdata,'Tag','APRestBox',...
    'Linestyle',':','color',[230/255 110/255 25/255],'Linewidth',0.2,'Visible','off');
set(handles.SmartLab,'WindowButtonMotionFcn',{@APRestBox_MouseMove,handles});
set(handles.SmartLab,'WindowButtonUpFcn',{@APRestBox_MouseButtonUpFcn,handles});
guidata(hObject,handles);

function APRestBox_MouseMove(hObject,eventdata,handles)
pt=get(gca,'CurrentPoint');
x2=pt(1,1);
y2=pt(1,2);
h_APRestBox=findobj('Tag','APRestBox');
x_boxdata=get(h_APRestBox,'XData');
y_boxdata=get(h_APRestBox,'YData');
x1=x_boxdata(1);
y1=y_boxdata(1);
x_boxdata=[x1 x1 x2 x2 x1];
y_boxdata=[y1 y2 y2 y1 y1];
set(h_APRestBox,'XData',x_boxdata,'YData',y_boxdata,'Visible','on');
guidata(hObject,handles);


function  APRestBox_MouseButtonUpFcn(hObject,eventdata,handles)
set(handles.SmartLab,'WindowButtonMotionFcn',[]);
set(handles.SmartLab,'WindowButtonUpFcn',[]);

h_APRestBox=findobj('Tag','APRestBox','Type','line');
% h_markerbox=gco;
x_boxdata=get(h_APRestBox,'XData'); %only one object, otherwise it will have problem
y_boxdata=get(h_APRestBox,'YData');
x1=x_boxdata(1); %the begining position
y1=y_boxdata(1);
x2=x_boxdata(3);
y2=y_boxdata(3);
x_boxbegin=round(min([x1 x2])); %the version before 10/22/2014
x_boxend=round(max([x1 x2]));
y_boxlow=min([y1 y2]);
y_boxhigh=max([y1 y2]);
x_boxdata=[x_boxbegin x_boxbegin x_boxend x_boxend x_boxbegin];
y_boxdata=[y_boxlow y_boxhigh y_boxhigh y_boxlow y_boxlow];
set(h_APRestBox,'XData',x_boxdata,'YData',y_boxdata);

cmenu_APRestbox=uicontextmenu;
item1=uimenu(cmenu_APRestbox,'Label','Rest Potential','Callback',{@APRestBoxManipulate,handles});
item2=uimenu(cmenu_APRestbox,'Label','Last Ca Decay','Callback',{@APRestBoxManipulate,handles});
item3=uimenu(cmenu_APRestbox,'Label','Disable','Callback',{@APRestBoxManipulate,handles});

set(h_APRestBox,'UIContextMenu',cmenu_APRestbox);
guidata(hObject,handles);
return;


function APRestBoxManipulate(hObject,eventdata,handles)
FigureUserData=[];
FigureUserData=get(handles.SmartLab,'UserData');
FilterChannel1=FigureUserData.FilterChannel1;
FilterChannel2=FigureUserData.FilterChannel2;
DataTime=FigureUserData.DataTime;

str=get(hObject,'Label');
h_APRestBox=findobj('Tag','APRestBox','Type','line');
% h_markerbox=gco;
x_boxdata=get(h_APRestBox,'XData'); %only one object, otherwise it will have problem
y_boxdata=get(h_APRestBox,'YData');
x1=x_boxdata(1); %the begining position
y1=y_boxdata(1);
x2=x_boxdata(3);
y2=y_boxdata(3);
x_boxbegin=min([x1 x2]);
x_boxend=max([x1 x2]);
BEIX=[];
BEIX=find(DataTime>=x_boxbegin&DataTime<=x_boxend);
x_boxbeginIX=BEIX(1);
x_boxendIX=BEIX(end);

h_WaveletDenoiseSignal=[];
try
    h_WaveletDenoiseSignal=findobj(get(gca,'Children'),'Tag','FilterChannel1Signal');
    WaveletDenoiseSignal=get(h_WaveletDenoiseSignal(1),'YData');
    BoxSignal=[];
    BoxSignal=WaveletDenoiseSignal(x_boxbeginIX:x_boxendIX);
    ChannelNo=1;
catch exception
    h_WaveletDenoiseSignal=findobj(get(gca,'Children'),'Tag','FilterChannel2Signal');
    WaveletDenoiseSignal=get(h_WaveletDenoiseSignal(1),'YData');
    BoxSignal=[];
    BoxSignal=WaveletDenoiseSignal(x_boxbeginIX:x_boxendIX);
    ChannelNo=2;
end

if strcmp('Rest Potential',str)
    
    %find the maximum of the signal
    [ValueMax IXMax]=max(BoxSignal);
    APRestValue=min(BoxSignal(IXMax:end));
    h=msgbox(['Channel' num2str(ChannelNo) ' Rest Concentration=' num2str(APRestValue)]);
    
elseif strcmp('Last Ca Decay',str)
    
    %here do some deletion of the data
    
     %find the maximum of the signal
    [ValueMax IXMax]=max(BoxSignal);
    EBoxSignal=[];
    EBoxSignal=BoxSignal(IXMax:end);
    EBEIX=[];
    EBEIX=BEIX(IXMax:end);
           
    try
    x=[];
    y=[];
    %to fit the decay function
    DecayFun=inline('b(1)*exp(-x/b(2))+b(3)','b','x');
    y=[EBoxSignal]';
    x=[DataTime(EBEIX)-DataTime(EBEIX(1))];
    %%%%%%%%doing regression analysis
    b0=[max(y)-min(y) x(end)-x(1) min(y)];
    b=nlinfit(x,y,DecayFun,b0);
    catch exception
        warndlg('Fitting Error!')
        return;
    end 
%     
    figure
    plot(x,y,'b.');
    hold on;
    y2=b(1).*exp(-x/b(2))+b(3);
    plot(x,y2,'r');
    
    h1=msgbox(['Channel' num2str(ChannelNo) ' Last Ca Decay Constant=' num2str(b(2)) 'ms']);
    
elseif strcmp('Disable',str)
    set(handles.axes1,'ButtonDownFcn',[]);
    set(handles.axes2,'ButtonDownFcn',[]);
    set(handles.SmartLab,'WindowButtonMotionFcn',[]);
    set(handles.SmartLab,'WindowButtonUpFcn',[]);
    
  
    
end

try
    
    delete(h_APRestBox);
catch exception
    ;
end
guidata(hObject,handles);

return;


% --------------------------------------------------------------------
function DualFitting_Callback(hObject, eventdata, handles)
% hObject    handle to DualFitting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB












% handles    structure with handles and user data (see GUIDATA)
