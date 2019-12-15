  function varargout = DICOM_READER(varargin)
% DICOM_READER MATLAB code for DICOM_READER.fig
%      DICOM_READER, by itself, creates a new DICOM_READER or raises the existing
%      singleton*.
%
%      H = DICOM_READER returns the handle to a new DICOM_READER or the handle to
%      the existing singleton*.
%
%      DICOM_READER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DICOM_READER.M with the given input arguments.
%
%      DICOM_READER('Property','Value',...) creates a new DICOM_READER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DICOM_READER_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DICOM_READER_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DICOM_READER

% Last Modified by GUIDE v2.5 28-Mar-2015 22:51:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DICOM_READER_OpeningFcn, ...
                   'gui_OutputFcn',  @DICOM_READER_OutputFcn, ...
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


% --- Executes just before DICOM_READER is made visible.
function DICOM_READER_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DICOM_READER (see VARARGIN)

% Choose default command line output for DICOM_READER
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DICOM_READER wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DICOM_READER_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;






function EditInput2_Callback(hObject, eventdata, handles)
% hObject    handle to EditInput2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditInput2 as text
%        str2double(get(hObject,'String')) returns contents of EditInput2 as a double


% --- Executes during object creation, after setting all properties.
function EditInput2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditInput2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function EditBrowse_Callback(hObject, eventdata, handles)
% hObject    handle to EditBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditBrowse as text
%        str2double(get(hObject,'String')) returns contents of EditBrowse as a double


% --- Executes during object creation, after setting all properties.
function EditBrowse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ButtonBrowse.
function ButtonBrowse_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%[FileName, PathName] = uigetfile('*.*', 'Select an Image');     % A window is opened for the user to select an image
[FileName, PathName] = uigetfile('*.*', 'Select an Image');     % A window is opened for the user to select an image
set (handles.EditBrowse, 'string', strcat(PathName,FileName));  % Directory path of the selected image is written to the Edit box.



% --- Executes on button press in ButtonLoadBrowsed.
function ButtonLoadBrowsed_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonLoadBrowsed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Global variables are defined here.


global Image;


%axes(handles.AxesOutputImagePlot1);

DirectoryPath = get(handles.EditBrowse, 'String');  % Directory path that image is selected is read.
LengthOfDirectory = length(DirectoryPath);

%Extension(i.e. jpg, jpeg, bmp, png...) of the image file is detected
%below.
for i=LengthOfDirectory:-1:1
    if (DirectoryPath(i)== '.')
        FileExtension = DirectoryPath(i+1 : LengthOfDirectory);
    end
end

Image = imread(DirectoryPath, FileExtension);  % Image is read from the selected directory


% if(strcmp(FileExtension, 'png'))
%     imshow(Image);
%     imagesc(Image);
% else
%     imshow(Image);
%     imagesc(Image);
% end

[a, b, c] = size(Image);

if(c > 1)
Image = rgb2gray(Image);
end

imshow(Image);

axes(handles.AxesOutputImagePlot2);
imshow(Image);




guidata(hObject, handles);







% --- Executes on button press in ButtonCLEAR.
function ButtonCLEAR_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonCLEAR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.AxesOutputImagePlot1);

cla(handles.AxesOutputImagePlot1,'reset')
guidata(hObject, handles);



function EditInput1_Callback(hObject, eventdata, handles)
% hObject    handle to EditInput1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditInput1 as text
%        str2double(get(hObject,'String')) returns contents of EditInput1 as a double


% --- Executes during object creation, after setting all properties.
function EditInput1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditInput1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ButtonPrevious.
function ButtonPrevious_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonPrevious (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



global Image;
global Counter;
global DicomImage;
global NumberOfFrames;
global RoiExistsFlag;
global FirstCoordinate;
global SecondCoordinate;
global ThirdCoordinate;
global FourthCoordinate;

if(Counter >= 1)
      
        if(Counter == 1)
            Counter = NumberOfFrames;
        else
            
            Counter = Counter - 1;
        end
   
elseif(Counter == 0)    % ilk basýlan tuþ PREVIOUS olursa Counter 0 baþlar.
    Counter = NumberOfFrames;
end

Image = DicomImage(:,:,Counter);

if (RoiExistsFlag == 1)
    axes(handles.AxesOutputImagePlot2);
    hold off;
    
    % CROP the image according to ROI
    Width = SecondCoordinate(1,1)- FirstCoordinate(1,1);
    Height = ThirdCoordinate(1,2)- FirstCoordinate(1,2);
    CroppedImage = imcrop(DicomImage(:,:,Counter), [FirstCoordinate(1,1), FirstCoordinate(1,2),Width, Height]);
    %%%%%%%%%%%%
    
    Image = CroppedImage;   % Kýrpýlmýþ resim üzerinde çalýþmak için, kýrpýlmýþ resim globalize edilmeli. 
    
    ClassOfImage = class(Image); 
    if(strcmp(ClassOfImage, 'uint8'))
        %imshow(DicomImage(:,:,Counter));
        imshow(CroppedImage);
    else
        
        %imagesc(DicomImage(:,:,Counter));
        imagesc(CroppedImage);
    end
    
%     
%     hold on;
%     % plot from first coord to second
%     x1 = FirstCoordinate(1,1);
%     y1 = FirstCoordinate(1,2);
%     x2 = SecondCoordinate(1,1);
%     y2 = SecondCoordinate(1,2);
%     
%     coord1 = [x1, x2];
%     coord2 = [y1, y2];
%     plot(coord1, coord2, 'b-','LineWidth',2);
%     
%     
%     % plot from second coord to fourth
%     x1 = SecondCoordinate(1,1);
%     y1 = SecondCoordinate(1,2);
%     x2 = FourthCoordinate(1,1);
%     y2 = FourthCoordinate(1,2);
%     
%     coord1 = [x1, x2];
%     coord2 = [y1, y2];
%     plot(coord1, coord2, 'b-','LineWidth',2);
%     
%     
%     % plot from fourth coord to third
%     x1 = FourthCoordinate(1,1);
%     y1 = FourthCoordinate(1,2);
%     x2 = ThirdCoordinate(1,1);
%     y2 = ThirdCoordinate(1,2);
%     
%     coord1 = [x1, x2];
%     coord2 = [y1, y2];
%     plot(coord1, coord2, 'b-','LineWidth',2);
%     
%     
%     % plot from third coord to first
%     x1 = ThirdCoordinate(1,1);
%     y1 = ThirdCoordinate(1,2);
%     x2 = FirstCoordinate(1,1);
%     y2 = FirstCoordinate(1,2);
%     
%     coord1 = [x1, x2];
%     coord2 = [y1, y2];
%     plot(coord1, coord2, 'b-','LineWidth',2);

else
    axes(handles.AxesOutputImagePlot2);
    hold off;
    
    ClassOfImage = class(Image); 
    if(strcmp(ClassOfImage, 'uint8'))
        imshow(DicomImage(:,:,Counter));
    else
        
        imagesc(DicomImage(:,:,Counter));
    end
    
    
    
end

   


%imagesc(Image);






counter = num2str(Counter);
numberOfFrames = num2str(NumberOfFrames);
set(handles.StaticTextFileNumber, 'string', strcat(counter,' /',  numberOfFrames));


% --- Executes on button press in ButtonNext.
function ButtonNext_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonNext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



global Image;
global Counter;
global DicomImage;
global NumberOfFrames;
global FileName;
global PathName;
global DicomInfo;
global RoiExistsFlag;
global FirstCoordinate;
global SecondCoordinate;
global ThirdCoordinate;
global FourthCoordinate;


if(Counter <= NumberOfFrames)
    
    if(Counter == NumberOfFrames)
        Counter = 1;
    else
        Counter = Counter + 1;
    end
        
end

Image = DicomImage(:,:,Counter);
% Int16Image = int16(Image);
% imshow(Int16Image);
% imagesc(Int16Image);

if(RoiExistsFlag == 1)
    
    axes(handles.AxesOutputImagePlot2);
    hold off;
    
    % CROP the image according to ROI
    Width = SecondCoordinate(1,1)- FirstCoordinate(1,1);
    Height = ThirdCoordinate(1,2)- FirstCoordinate(1,2);
    CroppedImage = imcrop(DicomImage(:,:,Counter), [FirstCoordinate(1,1), FirstCoordinate(1,2),Width, Height]);
    %%%%%%%%%%%%
    Image = CroppedImage;   % Kýrpýlmýþ resim üzerinde çalýþmak için, kýrpýlmýþ resim globalize edilmeli. 

    ClassOfImage = class(Image); 
    if(strcmp(ClassOfImage, 'uint8'))
        %imshow(DicomImage(:,:,Counter));
        imshow(CroppedImage);
    else
        %imshow(DicomImage(:,:,Counter), [0 255]);
        %imagesc(DicomImage(:,:,Counter));
        imagesc(CroppedImage);
    end
    
%     
%     hold on;
%     % plot from first coord to second
%     x1 = FirstCoordinate(1,1);
%     y1 = FirstCoordinate(1,2);
%     x2 = SecondCoordinate(1,1);
%     y2 = SecondCoordinate(1,2);
%     
%     coord1 = [x1, x2];
%     coord2 = [y1, y2];
%     plot(coord1, coord2, 'b-','LineWidth',2);
%     
%     
%     % plot from second coord to fourth
%     x1 = SecondCoordinate(1,1);
%     y1 = SecondCoordinate(1,2);
%     x2 = FourthCoordinate(1,1);
%     y2 = FourthCoordinate(1,2);
%     
%     coord1 = [x1, x2];
%     coord2 = [y1, y2];
%     plot(coord1, coord2, 'b-','LineWidth',2);
%     
%     
%     % plot from fourth coord to third
%     x1 = FourthCoordinate(1,1);
%     y1 = FourthCoordinate(1,2);
%     x2 = ThirdCoordinate(1,1);
%     y2 = ThirdCoordinate(1,2);
%     
%     coord1 = [x1, x2];
%     coord2 = [y1, y2];
%     plot(coord1, coord2, 'b-','LineWidth',2);
%     
%     
%     % plot from third coord to first
%     x1 = ThirdCoordinate(1,1);
%     y1 = ThirdCoordinate(1,2);
%     x2 = FirstCoordinate(1,1);
%     y2 = FirstCoordinate(1,2);
%     
%     coord1 = [x1, x2];
%     coord2 = [y1, y2];
%     plot(coord1, coord2, 'b-','LineWidth',2);
%     
    
    
    
    
else
    axes(handles.AxesOutputImagePlot2);
    hold off;
    ClassOfImage = class(Image);
    
    if(strcmp(ClassOfImage, 'uint8'))
        imshow(DicomImage(:,:,Counter));
    else
        
        %imshow(int16(DicomImage(:,:,Counter)), 'DisplayRange', [0 65535]);
        imagesc(DicomImage(:,:,Counter));
    end
    
    
    
end



%Image = im2double(Image);
% axes(handles.AxesOutputImagePlot1);
% imshow(Image);
% axes(handles.AxesOutputImagePlot2);
% imshow(Image);



%%%%%%%%%%%%%%%%%   DENEME
% MyFileName = strcat(PathName, FileName);
% MyFileName = GetFileName(MyFileName);
% SaveImage( DicomImage, DicomInfo);



%%%%%%%%%%%%%%%%%%%%%%%%%
counter = num2str(Counter);
numberOfFrames = num2str(NumberOfFrames);
set(handles.StaticTextFileNumber, 'string', strcat(counter,' / ', numberOfFrames));
    
    


    



function EditBrowseForAFile_Callback(hObject, eventdata, handles)
% hObject    handle to EditBrowseForAFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditBrowseForAFile as text
%        str2double(get(hObject,'String')) returns contents of EditBrowseForAFile as a double


% --- Executes during object creation, after setting all properties.
function EditBrowseForAFile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditBrowseForAFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ButtonBrowseForAFile.
function ButtonBrowseForAFile_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonBrowseForAFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%global ReadedFiles;
global Counter;
global FileName;
global PathName;


global DicomImage;
global DicomInfo;
global NumberOfFrames;
global FullPath;



[FileName, PathName] = uigetfile('*.dcm','Please Select a DICOM File');
set(handles.EditBrowseForAFile, 'string', strcat(PathName, FileName)); % Directory path of the selected image is written to the Edit box.
set(handles.StaticTextFileName, 'string', FileName);




FullPath = strcat(PathName,FileName);
Waitbar = waitbar(0, 'DICOM files are being read...');
DicomImage = dicomread(FullPath);
waitbar(1);
close(Waitbar);
DicomInfo = dicominfo(FullPath);

NumberOfFrames = DicomInfo.NumberOfFrames; 
PositionerPrimaryAngle = DicomInfo.PositionerPrimaryAngle;
PositionerSecondaryAngle = DicomInfo.PositionerSecondaryAngle;
PatientName = DicomInfo.PatientName.FamilyName;
PatientAge = DicomInfo.PatientBirthDate;
Counter = 0;

set(handles.StaticTextFileNumber, 'string', '');
set(handles.StaticTextPPA, 'string', PositionerPrimaryAngle);
set(handles.StaticTextPSA, 'string', PositionerSecondaryAngle);
set(handles.StaticTextPatientName, 'string', PatientName);
set(handles.StaticTextPatientAge, 'string', PatientAge);
%cla(handles.AxesOutputImagePlot1,'reset');

% --- Executes on button press in ButtonReadDCM.
function ButtonReadDCM_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonReadDCM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global FileName; 
global PathName;
global DicomImage;
global DicomInfo;
global NumberOfFrames;
global FullPath;
global Counter;

%%%%%%   deneme     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Files = dir(PathName);
% 
% for k=3:length(Files)
%    FileName = Files(k).name;
%    FullPath = strcat(PathName,FileName);
%    DicomInfo = dicominfo(FullPath);
%    PatientName = DicomInfo.PatientName.FamilyName;
%    DirInfo(k-2).PatientName = PatientName;
%    DirInfo(k-2).FileName = FileName;
%    
%    
%  
% end
% 
% 
% f = fopen('CD3.txt', 'w');
% for n = 1:1:length(Files)-2
%     fprintf(f, '%s\t%s\n', DirInfo(n).PatientName, DirInfo(n).FileName);
% end
% fclose(f);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


FullPath = strcat(PathName,FileName);
Waitbar = waitbar(0, 'DICOM files are being read...');
DicomImage = dicomread(FullPath);
waitbar(1);
close(Waitbar);
DicomInfo = dicominfo(FullPath);

NumberOfFrames = DicomInfo.NumberOfFrames; 
PositionerPrimaryAngle = DicomInfo.PositionerPrimaryAngle;
PositionerSecondaryAngle = DicomInfo.PositionerSecondaryAngle;
PatientName = DicomInfo.PatientName.FamilyName;
PatientAge = DicomInfo.PatientBirthDate;
Counter = 0;

set(handles.StaticTextFileNumber, 'string', '');
set(handles.StaticTextPPA, 'string', PositionerPrimaryAngle);
set(handles.StaticTextPSA, 'string', PositionerSecondaryAngle);
set(handles.StaticTextPatientName, 'string', PatientName);
set(handles.StaticTextPatientAge, 'string', PatientAge);
%cla(handles.AxesOutputImagePlot1,'reset');


% --- Executes on button press in ButtonShowAll.
function ButtonShowAll_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonShowAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global NumberOfFrames;
global DicomImage;


numberOfFrames = num2str(NumberOfFrames);

myTimer = timer('TimerFcn', @MyCallBackFun, 'Period', 100);
for i=1:1:NumberOfFrames
    counter = num2str(i);
    set(handles.StaticTextFileNumber, 'string', strcat(counter,' / ', numberOfFrames));
    imshow(DicomImage(:,:,i));
    start(myTimer);
    wait(myTimer);
    %stop(t);
end
    


% --- Executes on button press in ButtonSaveDCM.
function ButtonSaveDCM_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonSaveDCM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global DicomImage;
global DicomInfo;

SaveImage( DicomImage, DicomInfo);


% --- Executes on button press in ButtonDoSthg.
function ButtonDoSthg_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonDoSthg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Image;
global AnisotropicDiffusedImage;
global CompositeEnergy;

global ControlPoints1;
global ControlPoints2;
global OptimizedControlPoints1;
global OptimizedControlPoints2;


%NoisedImage = imnoise(Image, 'gaussian' , 0.02);
% NoisedImage = imnoise(Image, 'salt & pepper');

% RotatedImage = imrotate(Image, 30);
% 
% axes(handles.AxesOutputImagePlot2);
% %imshow(NoisedImage);
% imshow(RotatedImage);
% Image = RotatedImage;
% 
% imwrite(NoisedImage, 'SaltAndPepperNoisedImage-2.jpg');


%%%%%%%%%%%% EDGE DETECTORS (canny) %%%%%%%%%%%%%%%%%%%%
% %EdgeImage = edge(Image,'canny');
% EdgeImage = edge(AnisotropicDiffusedImage,'canny');
% CompositeEnergy = EdgeImage;
% %%%EdgeImage = edge(AnisotropicDiffusedImage,'canny');   Canny için PMAD
% %%%gereksiz bir adým
% axes(handles.AxesOutputImagePlot2);
% imshow(EdgeImage);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%% UNCONSTRAINED OPTIMIZATION   %%%%%%%

opts = optimset('Algorithm','interior-point', 'MaxIter', 2);
[OptimizedControlPoints1,fval,exitflag,output] = fminunc(@UnconstOptFunc,ControlPoints1, opts );
[OptimizedControlPoints2,fval,exitflag,output] = fminunc(@UnconstOptFunc,ControlPoints2, opts );


hold on;
 plot(OptimizedControlPoints1(:,1),OptimizedControlPoints1(:,2),'ro','MarkerSize',3,'MarkerFaceColor','r');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




% %Global variables are defined here.
% global Image;
% 
% 
% %%%%  TAKE INPUTS FROM THE USER
% IterationNumber = str2double(get(handles.EditInput1, 'String'));                                                                                                                                                                                                                                                                                                        
% r = str2double(get(handles.EditInput2, 'String'));
% 
% 
% %%%%% CALL THE FUNCTION
% [ OutputImage, Average, Std, StdOriginal ] = Diffuse( Image, IterationNumber, r );



%%%%% DISPLAY OUTPUTS
% set(handles.StaticTextAverage, 'string', Average);
% set(handles.StaticTextStdDevOrg, 'string', StdOriginal);
% set(handles.StaticTextStdDev, 'string',Std );

% %imshow(ResultantImage);
% imagesc(OutputImage);
% 
% 
% 
% %HisteqImage = histeq(Image);
% %imshow(HisteqImage);
% guidata(hObject, handles);


% --- Executes on button press in ButtonSplineInit.
function ButtonSplineInit_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonSplineInit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Image;
global CLAHEimage;
global ControlPoints1;
global SplinePoints1;
global ControlPoints2;
global SplinePoints2;

global SplinePointsOfGroundTruth1;
global SplinePointsOfGroundTruth2;

global CompositeEnergy;




%%%% Automatic Spline Initialization  %%%%%

% [y,x] = size(CompositeEnergy);
% 
% 
% XaxisOfCompositeEnergy = 1:1:x;
% YaxisOfCompositeEnergy = 1:1:y;

% uiwait(msgbox('Select the first point', 'WARNING', 'warn'));
% FirstPoint = ceil(ginput(1));
% 
% uiwait(msgbox('Select the second point', 'WARNING', 'warn'));
% SecondPoint = ceil(ginput(1));
% 
% %%% iki noktasý bilinen doðru denklemi bulunur
% slope = (SecondPoint(1,2) - FirstPoint(1,2))/ (SecondPoint(1,1) - FirstPoint(1,1));
% n = FirstPoint(1,2) - (slope*FirstPoint(1,1));
% % now we have the line eqn. as          "y = slope*x + n"
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% 
% DistanceInX = abs(FirstPoint(1,1) - SecondPoint(1,1));
% DistanceInY = abs(FirstPoint(1,2) - SecondPoint(1,2));
% 
% 
% if (DistanceInX > DistanceInY)
%     %%% X deki mesafe daha uzunsa X de eþit aralýklý noktalar belirlenir
%     
%     Xnoktalari = linspace(FirstPoint(1,1), SecondPoint(1,1), 10);    % 10 tane nokta seçilir
%     
%     % X noktalarýna karþýlýk gelen Y noktalarý bulunur
%     for i=1:1:length(Xnoktalari)
%         XYnoktaCiftleri(i,1) = Xnoktalari(i);       % X noktasý
%         XYnoktaCiftleri(i,2) = slope*Xnoktalari(i) + n;     % Y noktasý
%         
%     end
%     
%     
%     for i=2:1:length(Xnoktalari)
%         [ slope2 , n2] = PerpendicularLineEquation2Pts(FirstPoint, XYnoktaCiftleri(i,:) );
%         % eqn of the perpendicular line is    "y = slope2*x + n"
%         
%         %%% þimdi Y noktalarý üzerinde linspace yapýlýr (Right Spline)
%         PerpendicularLineYpoints = XYnoktaCiftleri(i,2) : 0.5 : XYnoktaCiftleri(i,2)+5;
%         PerpendicularLineXpoints = (PerpendicularLineYpoints - n2)/slope2;
%         %%% þimdi DÝK doðru üzerinde bulunan bu nokta çiftlerinin enerji
%         %%% deðerlerine bakýlýr
%         
%         
%         max = interp2(XaxisOfCompositeEnergy, YaxisOfCompositeEnergy, CompositeEnergy, PerpendicularLineXpoints(1), PerpendicularLineYpoints(1)); % 2D interpolation yapýlarak verilen noktanýn enerjisi bulunur.
%         for j=1:1: length(PerpendicularLineYpoints)
%             if( interp2(XaxisOfCompositeEnergy, YaxisOfCompositeEnergy, CompositeEnergy, PerpendicularLineXpoints(j), PerpendicularLineYpoints(j)) > max)
%                 %max = CompositeEnergy(PerpendicularLineXpoints(j), PerpendicularLineYpoints(j));
%                 max = interp2(XaxisOfCompositeEnergy, YaxisOfCompositeEnergy, CompositeEnergy, PerpendicularLineXpoints(j), PerpendicularLineYpoints(j));
%                 RightSplineControlPoints(i,:) = [PerpendicularLineXpoints(j), PerpendicularLineYpoints(j)];
%                 
%             end
%             
%         end
%         
%         
%         %%% þimdi Y noktalarý üzerinde linspace yapýlýr (Left Spline)
%         PerpendicularLineYpoints = XYnoktaCiftleri(i,2)-5 : 0.5 : XYnoktaCiftleri(i,2);
%         PerpendicularLineXpoints = (PerpendicularLineYpoints - n2)/slope2;
%         
%         max = CompositeEnergy(PerpendicularLineXpoints(1), PerpendicularLineYpoints(1));
%         for j=1:1: length(PerpendicularLineYpoints)
%             if( CompositeEnergy(PerpendicularLineXpoints(j), PerpendicularLineYpoints(j)) > max)
%                 max = CompositeEnergy(PerpendicularLineXpoints(j), PerpendicularLineYpoints(j));
%                 LeftSplineControlPoints(i,:) = [PerpendicularLineXpoints(j), PerpendicularLineYpoints(j)];
%                 
%             end
%             
%         end
%         
%         
%         
%         
%         
%         
%         
%         
%         
%         
%     end
%     
%     
%     
%     
% else %%% Y deki mesafe daha uzunsa Y de eþit aralýklý noktalar belirlenir
%     
%     Ynoktalari = linspace(FirstPoint(1,2), SecondPoint(1,2), 10);    % 10 tane nokta seçilir
%     
%     % Y noktalarýna karþýlýk gelen X noktalarý bulunur
%     for i=1:1:length(Ynoktalari)
%         XYnoktaCiftleri(i,2) = Ynoktalari(i);       % Y noktasý
%         XYnoktaCiftleri(i,1) = (Ynoktalari(i) - n)/slope;     % X noktasý
%         
%     end
%     
%     
%     
%     for i=2:1:length(Ynoktalari)
%         [ slope2 , n2] = PerpendicularLineEquation2Pts(FirstPoint, XYnoktaCiftleri(i,:) );
%         % eqn of the perpendicular line is    "y = slope2*x + n"
%         
%         %%% þimdi X noktalarý üzerinde linspace yapýlýr (Right Spline)
%         PerpendicularLineXpoints = XYnoktaCiftleri(i,1) : 1 : XYnoktaCiftleri(i,1)+15;
%         PerpendicularLineYpoints =  slope2*PerpendicularLineXpoints + n2;
%         %%% þimdi DÝK doðru üzerinde bulunan bu nokta çiftlerinin enerji
%         %%% deðerlerine bakýlýr
%         
%         
%         max = interp2(XaxisOfCompositeEnergy, YaxisOfCompositeEnergy, CompositeEnergy, PerpendicularLineXpoints(1), PerpendicularLineYpoints(1)); % 2D interpolation yapýlarak verilen noktanýn enerjisi bulunur.
%         for j=1:1: length(PerpendicularLineYpoints)
%             if( interp2(XaxisOfCompositeEnergy, YaxisOfCompositeEnergy, CompositeEnergy, PerpendicularLineXpoints(j), PerpendicularLineYpoints(j)) > max)
%                 %max = CompositeEnergy(PerpendicularLineXpoints(j), PerpendicularLineYpoints(j));
%                 max = interp2(XaxisOfCompositeEnergy, YaxisOfCompositeEnergy, CompositeEnergy, PerpendicularLineXpoints(j), PerpendicularLineYpoints(j));
%                 RightSplineControlPoints(i-1,:) = [PerpendicularLineXpoints(j), PerpendicularLineYpoints(j)];
%                 
%             end
%             
%         end
%         
%         
%         %%% þimdi X noktalarý üzerinde linspace yapýlýr (Left Spline)
%         PerpendicularLineXpoints = XYnoktaCiftleri(i,1) : -1 : XYnoktaCiftleri(i,1)-15;
%         PerpendicularLineYpoints = slope2*PerpendicularLineXpoints + n2;
%         
%         
%         max = interp2(XaxisOfCompositeEnergy, YaxisOfCompositeEnergy, CompositeEnergy, PerpendicularLineXpoints(1), PerpendicularLineYpoints(1)); % 2D interpolation yapýlarak verilen noktanýn enerjisi bulunur.
%         for j=1:1: length(PerpendicularLineYpoints)
%             if( interp2(XaxisOfCompositeEnergy, YaxisOfCompositeEnergy, CompositeEnergy, PerpendicularLineXpoints(j), PerpendicularLineYpoints(j)) > max)
%                 %max = CompositeEnergy(PerpendicularLineXpoints(j), PerpendicularLineYpoints(j));
%                 max = interp2(XaxisOfCompositeEnergy, YaxisOfCompositeEnergy, CompositeEnergy, PerpendicularLineXpoints(j), PerpendicularLineYpoints(j));
%                 LeftSplineControlPoints(i-1,:) = [PerpendicularLineXpoints(j), PerpendicularLineYpoints(j)];
%                 
%             end
%             
%         end
%         
%        
%     end
%     
%     
%     
%     
%     
% end
% 
% 
% 
% hold on;
% plot(XYnoktaCiftleri(:,1),XYnoktaCiftleri(:,2),'ro','MarkerSize',2,'MarkerFaceColor','r');
% plot(RightSplineControlPoints(:,1),RightSplineControlPoints(:,2),'ro','MarkerSize',2,'MarkerFaceColor','r');
% plot(LeftSplineControlPoints(:,1),LeftSplineControlPoints(:,2),'ro','MarkerSize',2,'MarkerFaceColor','r');
% 
% %%% form a SPLINE 
% T = linspace(0,1,8);    %% 9 kontrol noktasý için
% y = linspace(0,1,1000);  %% spline points will be composed of 500 pts.
% orderOfSpline = 3;
% 
% RightSplinePoints = DEBOOR(T, RightSplineControlPoints, y, orderOfSpline);
% LeftSplinePoints = DEBOOR(T, LeftSplineControlPoints, y, orderOfSpline);
% 
% %%% plot the splines
% plot(RightSplinePoints(:,1),RightSplinePoints(:,2),'b-','LineWidth',2);
% plot(LeftSplinePoints(:,1),LeftSplinePoints(:,2),'b-','LineWidth',2);
% 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%%%%% Initail Spline ý kaydetme ve yükleme  %%%%%%%

% LOADING PART
% CommonSpline1 = load('SplinePoints1.mat');
% CommonSpline2 = load('SplinePoints2.mat');
% CommonCP1 = load('ControlPoints1.mat');
% CommonCP2 = load('ControlPoints2.mat');
% 
% SplinePoints1 = CommonSpline1.SplinePoints1;
% SplinePoints2 = CommonSpline2.SplinePoints2;
% ControlPoints1 = CommonCP1.ControlPoints1;
% ControlPoints2 = CommonCP2.ControlPoints2;


% SAVING PART
% save('SplinePoints1.mat','SplinePoints1' );
% save('SplinePoints2.mat','SplinePoints2');
% save('ControlPoints1.mat','ControlPoints1' );
% save('ControlPoints2.mat','ControlPoints2');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



NoOfControlPts = str2double(get(handles.EditNoOfControlPts, 'String'));

CLAHEimage = adapthisteq(Image);
%CLAHEimage = histeq(Image);      %%%% for testing and plotting
axes(handles.AxesOutputImagePlot2);
hold off;
imshow(CLAHEimage);

%%% GROUND TRUTH IMAGE referans olarak görsellenir...
% hold on;
% plot(SplinePointsOfGroundTruth1(:,1),SplinePointsOfGroundTruth1(:,2),'b-','LineWidth',2);
% plot(SplinePointsOfGroundTruth2(:,1),SplinePointsOfGroundTruth2(:,2),'b-','LineWidth',2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%AnisotropicDiffusedCLAHE = AnisotropicDiffusion(CLAHEimage, 30, 0.2);



%imagesc(AnisotropicDiffusedCLAHE);
%imshow(AnisotropicDiffusedCLAHE);

uiwait(msgbox('Initialize the first SPLINE', 'WARNING', 'warn'));
[ControlPoints1, SplinePoints1] = spline(NoOfControlPts,3);

uiwait(msgbox('Initialize the second SPLINE', 'WARNING', 'warn'));
[ControlPoints2, SplinePoints2] = spline(NoOfControlPts,3);



%%%%%%   GROUND TRUTH IMAGE    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% uiwait(msgbox('Initialize the GROUND TRUTH first SPLINE', 'WARNING', 'warn'));
% [ControlPointsOfGroundTruth1, SplinePointsOfGroundTruth1] = spline(NoOfControlPts,3);
% 
% uiwait(msgbox('Initialize the GROUND TRUTH second SPLINE', 'WARNING', 'warn'));
% [ControlPointsOfGroundTruth2, SplinePointsOfGroundTruth2] = spline(NoOfControlPts,3);


% --- Executes on button press in ButtonClearSpline.
function ButtonClearSpline_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonClearSpline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Image;
global CLAHEimage;

axes(handles.AxesOutputImagePlot2);
hold off;
imshow(CLAHEimage);


% % --- Executes on button press in ButtonSGaborFilter.
function ButtonSGaborFilter_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonSGaborFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Image;
global AbsOfGaborFilteredImages;
global m;
global n;
global CompositeEnergy;
global AnisotropicDiffusedImage;



sigmaX = 1;
sigmaY = 1;
%orientation = 6;
orientation = 6;
gaborArray1 = GaborFilterBankmhrrm(orientation, sigmaX, sigmaY, 9, 9);

%%%%%%%%%%     anisotropic diff       %%%%%%%%%%%%
% IterationNumber = 10;
% r=0.2;
% AnisotropicDiffusedImage  = AnisotropicDiffusion( Image, IterationNumber, r );
% imshow(AnisotropicDiffusedImage);
% imwrite(AnisotropicDiffusedImage, 'deneme.jpg');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%      FILTER BANK DENEME ALANI   %%%%%%%%%
% scale = 5;
% orientation = 12;
% gaborArray = GaborFilterBank(scale,orientation, 41, 41);
% 
% gaborArray2 = GaborFilterBankmdfd(scale,orientation, 9, 9);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%    ZERO MEAN GABOR FILTER     %%%%%%%%%
gaborArray1 = zeroMean(gaborArray1);



d1 = 2;
d2 = 2;
%GaborFilteredImages = GaborFeatures( Image,gaborArray1,d1,d2 );
GaborFilteredImages = GaborFeatures( AnisotropicDiffusedImage,gaborArray1,d1,d2 );

[m ,n] = size(GaborFilteredImages);

AbsOfGaborFilteredImages = cell(m,n);
for i = 1:m
    for j = 1:n        
          
        AbsOfGaborFilteredImages{i,j} = abs(GaborFilteredImages{i,j});
    end
end

CompositeEnergy = CalculateCompositeEnergy(AbsOfGaborFilteredImages);
%CompositeEnergy2 = SumGaborResponses(AbsOfGaborFilteredImages);

axes(handles.AxesOutputImagePlot2);
hold off;
imagesc(CompositeEnergy);
%imagesc(CompositeEnergy2);


%%% display response of each gabor filter %%%%%
% for i=1:1:m
%     for j=1:1:n
%         imagesc(AbsOfGaborFilteredImages{i,j});
%     end
% end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% NoOfScales = 3;
% NoOfOrientation = 6;
% 
% Sx = 1;
% Sy = 1;
% f = 64;
% theta = pi/2;
% 
% [ G,gaborFilteredImage] = gaborfilterv2( Image,Sx,Sy,f,theta );
% imagesc(gaborFilteredImage);
% 
% OrientationStep = pi/NoOfOrientation;
% 
% gaborFilteredImages = cell(NoOfScales,NoOfOrientation );
% gaborFilteredImages2 = cell(NoOfScales,NoOfOrientation );
% index = 0;
% for i=1:1:NoOfScales
%     for j=0:OrientationStep:(pi - OrientationStep)
%         index = index + 1;
%         %[ G,gaborFilteredImages{i,index}] = gaborfilterv2( Image,i,i,f,j );
%         [ G1, G2,gaborFilteredImages{i,index}, gaborFilteredImages2{i, index}] = gaborfilterv3( Image,i,i,f,j );
%         
%         if(index == NoOfOrientation)
%          index = 0;
%         end
%     end
% end
% 
% figure('NumberTitle','Off','Name','Real parts of Gabor filters');
% for i = 1:NoOfScales
%     for j = 1:NoOfOrientation       
%         subplot(NoOfScales,NoOfOrientation,(i-1)*NoOfOrientation+j);        
%         imshow(gaborFilteredImages2{i,j},[]);
%     end
% end
% 
% CompositeEnergy = CalculateCompositeEnergy(gaborFilteredImages2);
% imagesc(CompositeEnergy);
% 
% for i=1:1:NoOfScales
%     for j=1:1:NoOfOrientation
%         imshow(gaborFilteredImages{i,j});
%     end
% end
% 
% 
% imagesc(gabout);



% --- Executes on button press in ButtonShowInputImage.
function ButtonShowInputImage_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonShowInputImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Image;
axes(handles.AxesOutputImagePlot2);

imshow(Image);


% --- Executes on button press in ButtonShowFilteredImages.
function ButtonShowFilteredImages_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonShowFilteredImages (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global AbsOfGaborFilteredImages;
global m;
global n;
global CompositeEnergy;

axes(handles.AxesOutputImagePlot2);

hold off;

%%%%%  Convert CompositeEnergy to binary image
% %level = graythresh(CompositeEnergy);
% level = 0.005;
% BW = im2bw(CompositeEnergy,level);
% imshow(BW)
%%%%%%%%

imagesc(CompositeEnergy);

% for i=1:1:m
%     for j=1:1:n
%         imagesc(AbsOfGaborFilteredImages{i,j});
%     end
% end


% --- Executes on button press in ButtonOptimizeSpline.
function ButtonOptimizeSpline_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonOptimizeSpline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


global ControlPoints1;
global ControlPoints2;
global SplinePoints1;
global CompositeEnergy;
global CLAHEimage;
global Image;
global OptimizedControlPoints1;
global OptimizedSplinePoints1;
global OptimizedControlPoints2;
global OptimizedSplinePoints2;


% 
% [ControlPointsAfterOptimization, SplinePointsAfterOptimization, EnergyOfTheSpline ] = OptimizeEnergyOfTheSpline2(ControlPoints1, CompositeEnergy);
% EnergyVector(1) = EnergyOfTheSpline;
% ControlPointsStorage = cell(20,1);
% 
% ControlPointsStorage{1,1} = ControlPointsAfterOptimization;
% for i=1:1:20
% [ControlPointsAfterOptimization, SplinePointsAfterOptimization, EnergyOfTheSpline ] = OptimizeEnergyOfTheSpline2(ControlPointsAfterOptimization, CompositeEnergy);
% 
% EnergyVector(i+1) = EnergyOfTheSpline;
% ControlPointsStorage{i+1,1} = ControlPointsAfterOptimization;
% 
% 
% axes(handles.AxesOutputImagePlot2);
% 
% hold off;
% imshow(CLAHEimage);
% hold on;
% plot(ControlPointsAfterOptimization(:,1),ControlPointsAfterOptimization(:,2),'ro','MarkerSize',5,'MarkerFaceColor','r');
% plot(SplinePointsAfterOptimization(:,1),SplinePointsAfterOptimization(:,2),'b-','LineWidth',2);
% 
% end






%%%%%%%     her iterasyondaki spline þeklini görüntülemek için kullanýlýr    %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% [NoOfControlPoints, b] = size(ControlPoints1);
% %ModifiedControlPoints = zeros(NoOfControlPoints, b);
% ModifiedControlPoints = ControlPoints1;
% 
% NoOfIteration = NoOfControlPoints - 4 - 1;
% 
% ControlPointsStorage = cell(NoOfControlPoints,1);
% 
% k = 1;
% while(true)
%     
%     index = 1;
%     
%     % TAKE  the first 4 control points of the spline
%     CP1 = ModifiedControlPoints(index, :);
%     CP2 = ModifiedControlPoints(index+1, :);
%     CP3 = ModifiedControlPoints(index+2, :);
%     CP4 = ModifiedControlPoints(index+3, :);
%     
%     SetOfControlPoints = [CP1; CP2; CP3; CP4];
%     
%     % optimize the three points of the span
%     [ ControlPointsAfterOptimization, EnergyOfTheSplineAfterOptimization  ] = OptimizeEnergyOfTheSpan3PTS(SetOfControlPoints, CompositeEnergy, k, 1, 55555);
%     
%     % store the optimized control points
%     ModifiedControlPoints(index, :) = ControlPointsAfterOptimization(index, :);
%     ModifiedControlPoints(index+1, :) = ControlPointsAfterOptimization(index+1, :);
%     ModifiedControlPoints(index+2, :) = ControlPointsAfterOptimization(index+2, :);
%     ModifiedControlPoints(index+3, :) = ControlPointsAfterOptimization(index+3, :);
%     
%     
%     
%     
%     for i=1:1:NoOfIteration
%         
%         index = index + 1;
%         CP1 = ModifiedControlPoints(index, :);
%         CP2 = ModifiedControlPoints(index+1, :);
%         CP3 = ModifiedControlPoints(index+2, :);
%         CP4 = ModifiedControlPoints(index+3, :);
%         
%         SetOfControlPoints = [CP1; CP2; CP3; CP4];
%         [ ControlPointsAfterOptimization, EnergyOfTheSplineAfterOptimization  ] = OptimizeEnergyOfTheSpan1PT(SetOfControlPoints, CompositeEnergy);
%         
%         % only last point of the span is modified
%         ModifiedControlPoints(index+3, :) = ControlPointsAfterOptimization(4, :);
%         
%         
%         
%     end
%     
%     
%     
%     [NormalizedEnergyOfTheSpline, ModifiedSplinePoints] = CalculateNormalizedEnergyOfTheWholeSpline(ModifiedControlPoints, CompositeEnergy);
%     
%     % store both energy and the control points for the current configuration of
%     % the spline
%     EnergyVector(k) = NormalizedEnergyOfTheSpline;
%     ControlPointsStorage{k,1} = ModifiedControlPoints;
%     SplinePointsStorage{k,1} = ModifiedSplinePoints;
%     if (k>1)
%         DeltaEnergy(k-1) = EnergyVector(k) - EnergyVector(k-1);
%         
% %         if(abs(DeltaEnergy(k-1)) < 0.0001)
% %             % plot the current config of the spline and control points,
% %             % then break
% %             axes(handles.AxesOutputImagePlot2);
% %             hold off;
% %             imshow(Image);
% %             hold on;
% %             plot(ModifiedControlPoints(:,1),ModifiedControlPoints(:,2),'ro','MarkerSize',3,'MarkerFaceColor','r');
% %             plot(ModifiedSplinePoints(:,1),ModifiedSplinePoints(:,2),'b-','LineWidth',1);
% %             
% %             break;
% %         end
%     end
%     
%     
%     % plot the current config of the spline and control points
%     axes(handles.AxesOutputImagePlot2); 
%     hold off;
%     imshow(Image);
%     hold on;
%     plot(ModifiedControlPoints(:,1),ModifiedControlPoints(:,2),'ro','MarkerSize',3,'MarkerFaceColor','r');
%     plot(ModifiedSplinePoints(:,1),ModifiedSplinePoints(:,2),'b-','LineWidth',1);
%     
%     k = k + 1;
%     
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



A = get(get(handles.ButtonGroupDynamicProgramming, 'SelectedObject'), 'Tag');


switch A
    case 'RadioButtonLowComplexity',    %Complexity is  O(n^3 + N.n)
        SplineNumber = 1;
        t1 = clock;
        [ OptimizedControlPoints1, OptimizedSplinePoints1, IterationNumber1 ] = OptimizeGivenSpline( ControlPoints1, CompositeEnergy, SplineNumber );
        t2 = clock;
        ElapsedTime = etime(t2, t1);        % in seconds
        
        hold off;
        imshow(Image);
        hold on;
        plot(OptimizedControlPoints1(:,1),OptimizedControlPoints1(:,2),'ro','MarkerSize',3,'MarkerFaceColor','r');
        plot(OptimizedSplinePoints1(:,1),OptimizedSplinePoints1(:,2),'b-','LineWidth',1);
        
        SplineNumber = 2;
        t1 = clock;
        [ OptimizedControlPoints2, OptimizedSplinePoints2, IterationNumber2 ] = OptimizeGivenSpline( ControlPoints2, CompositeEnergy, SplineNumber );
        t2 = clock;
        ElapsedTime = etime(t2, t1);        % in seconds
        
        
        % plot the current config of the spline and control points
        axes(handles.AxesOutputImagePlot2);
        
        hold off;
        imshow(Image);
        hold on;
        plot(OptimizedControlPoints1(:,1),OptimizedControlPoints1(:,2),'ro','MarkerSize',3,'MarkerFaceColor','r');
        plot(OptimizedSplinePoints1(:,1),OptimizedSplinePoints1(:,2),'b-','LineWidth',1);
        
        plot(OptimizedControlPoints2(:,1),OptimizedControlPoints2(:,2),'ro','MarkerSize',3,'MarkerFaceColor','r');
        plot(OptimizedSplinePoints2(:,1),OptimizedSplinePoints2(:,2),'b-','LineWidth',1);
        
        
        
        
    case 'RadioButtonHighComplexity',   %   Complexity is  O(n^4.N)
        SplineNumber = 1;
        t1 = clock;
        [ OptimizedControlPoints1, OptimizedSplinePoints1, IterationNumber1 ] = OptimizeGivenSplineHighComplexity(ControlPoints1, CompositeEnergy, SplineNumber );
        %[ OptimizedControlPoints1, OptimizedSplinePoints1, IterationNumber1 ] = OptimizeGivenSplineHighComplexity(Image, ControlPoints1, CompositeEnergy, SplineNumber );
        t2 = clock;
        ElapsedTime = etime(t2, t1);        % in seconds
        
        hold off;
        imshow(Image);
        hold on;
        plot(OptimizedControlPoints1(:,1),OptimizedControlPoints1(:,2),'ro','MarkerSize',3,'MarkerFaceColor','r');
        plot(OptimizedSplinePoints1(:,1),OptimizedSplinePoints1(:,2),'b-','LineWidth',1);
        
        
        
        SplineNumber = 2;
        t1 = clock;
        [ OptimizedControlPoints2, OptimizedSplinePoints2, IterationNumber2 ] = OptimizeGivenSplineHighComplexity(ControlPoints2, CompositeEnergy, SplineNumber );
        %[ OptimizedControlPoints2, OptimizedSplinePoints2, IterationNumber2 ] = OptimizeGivenSplineHighComplexity(Image, ControlPoints2, CompositeEnergy, SplineNumber );
        % plot the current config of the spline and control points
        t2 = clock;
        ElapsedTime = etime(t2, t1);        % in seconds
        
        axes(handles.AxesOutputImagePlot2);
        
        hold off;
        imshow(Image);
        hold on;
        plot(OptimizedControlPoints1(:,1),OptimizedControlPoints1(:,2),'ro','MarkerSize',3,'MarkerFaceColor','r');
        plot(OptimizedSplinePoints1(:,1),OptimizedSplinePoints1(:,2),'b-','LineWidth',1);
        
        plot(OptimizedControlPoints2(:,1),OptimizedControlPoints2(:,2),'ro','MarkerSize',3,'MarkerFaceColor','r');
        plot(OptimizedSplinePoints2(:,1),OptimizedSplinePoints2(:,2),'b-','LineWidth',1);
        
        
        case 'RadioButtonLowLowComplexity',    %Complexity is  O(N.n)
            
        
        
        
end










function EditNoOfControlPts_Callback(hObject, eventdata, handles)
% hObject    handle to EditNoOfControlPts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditNoOfControlPts as text
%        str2double(get(hObject,'String')) returns contents of EditNoOfControlPts as a double


% --- Executes during object creation, after setting all properties.
function EditNoOfControlPts_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditNoOfControlPts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ButtonAnisDiffusion.
function ButtonAnisDiffusion_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonAnisDiffusion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Image;
global AnisotropicDiffusedImage;

%%%%% median filtering
% DoubleImage = im2double(Image);
% MedianImage = medfilt2(DoubleImage);
% AnisotropicDiffusedImage = medfilt2(DoubleImage);
% imshow(AnisotropicDiffusedImage);
% 
%%% Gaussian filtering 
%  hsize = [7 7];
%  h = fspecial('gaussian', hsize, 0.5);
%  AnisotropicDiffusedImage = imfilter(AnisotropicDiffusedImage,h,'replicate');
%  imshow(AnisotropicDiffusedImage);
%  
% axes(handles.AxesOutputImagePlot2);
% imshow(MedianImage);
%imagesc(MedianImage);


%%%%%  anisotropic diff
IterationNumber = 20;
r=0.25;
AnisotropicDiffusedImage  = AnisotropicDiffusion( Image, IterationNumber, r );
%%%%%%%%%%%%%%%%%%%%%%%%%%%


axes(handles.AxesOutputImagePlot2);
imshow(AnisotropicDiffusedImage);
%imagesc(AnisotropicDiffusedImage);


%%%%% deneme      %%%%%%
%%%  Anisotropic diff image a CLAHE uygula
% AnisotropicDiffusedImage = adapthisteq(AnisotropicDiffusedImage);
% imshow(AnisotropicDiffusedImage);



% imwrite(AnisotropicDiffusedImage, 'deneme.jpg');


% --- Executes on button press in ButtonShowDiffImage.
function ButtonShowDiffImage_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonShowDiffImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global AnisotropicDiffusedImage;

axes(handles.AxesOutputImagePlot2);
imshow(AnisotropicDiffusedImage);


% --- Executes on button press in ButtonShowInitSpline.
function ButtonShowInitSpline_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonShowInitSpline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Image;
global ControlPoints1;
global SplinePoints1;
global ControlPoints2;
global SplinePoints2;
axes(handles.AxesOutputImagePlot2);

hold off;
imshow(Image);
hold on;
plot(ControlPoints1(:,1),ControlPoints1(:,2),'ro','MarkerSize',3,'MarkerFaceColor','r');
plot(SplinePoints1(:,1),SplinePoints1(:,2),'b-','LineWidth',1);

plot(ControlPoints2(:,1),ControlPoints2(:,2),'ro','MarkerSize',3,'MarkerFaceColor','r');
plot(SplinePoints2(:,1),SplinePoints2(:,2),'b-','LineWidth',1);


% --- Executes on button press in ButtonShowOptSpline.
function ButtonShowOptSpline_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonShowOptSpline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Image;
global OptimizedSplinePoints1;
global OptimizedControlPoints1;
global OptimizedSplinePoints2;
global OptimizedControlPoints2;
global Centerline;
global CenterlineInPixels;


axes(handles.AxesOutputImagePlot2);

hold off;
imshow(Image);
hold on;
plot(OptimizedControlPoints1(:,1),OptimizedControlPoints1(:,2),'ro','MarkerSize',2,'MarkerFaceColor','r');
%plot(OptimizedSplinePoints1(:,1),OptimizedSplinePoints1(:,2),'b-','LineWidth',1);

plot(OptimizedControlPoints2(:,1),OptimizedControlPoints2(:,2),'ro','MarkerSize',2,'MarkerFaceColor','r');
%plot(OptimizedSplinePoints2(:,1),OptimizedSplinePoints2(:,2),'b-','LineWidth',1);


%%%%%  calculate centerline  %%%%%

Length = length(OptimizedSplinePoints1);

for i=1:1:Length
    Centerline(i,:) = (OptimizedSplinePoints1(i,:) + OptimizedSplinePoints2(i,:))/2;
end

% plot(Centerline(:,1),Centerline(:,2),'r-','LineWidth',2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% % CenterlineInPixels = ConvertSpline2Pixels(Centerline);
% OptimizedSplinePoints1InPixels = ConvertSpline2Pixels(OptimizedSplinePoints1);
% OptimizedSplinePoints2InPixels = ConvertSpline2Pixels(OptimizedSplinePoints2);
% 
% %%% choose the smallest length
% if (length(OptimizedSplinePoints1InPixels) < length(OptimizedSplinePoints2InPixels))
%     Length = length(OptimizedSplinePoints1InPixels);
% else
%     Length = length(OptimizedSplinePoints2InPixels);
% end
% 
% 
% for i=1:1:Length
%     CenterlineInPixels(i,:) = (OptimizedSplinePoints1InPixels(i,:) + OptimizedSplinePoints2InPixels(i,:))/2;
% end
% 
% 
% hold off;
% imshow(Image);
% hold on;
% plot(OptimizedControlPoints1(:,1),OptimizedControlPoints1(:,2),'ro','MarkerSize',3,'MarkerFaceColor','r');
% plot(OptimizedSplinePoints1InPixels(:,1),OptimizedSplinePoints1InPixels(:,2),'b-','LineWidth',2);
% 
% plot(OptimizedControlPoints2(:,1),OptimizedControlPoints2(:,2),'ro','MarkerSize',3,'MarkerFaceColor','r');
% plot(OptimizedSplinePoints2InPixels(:,1),OptimizedSplinePoints2InPixels(:,2),'b-','LineWidth',2);
% 
% plot(CenterlineInPixels(:,1),CenterlineInPixels(:,2),'r-','LineWidth',2);


% --- Executes on button press in ButtonDiameterEstimation.
function ButtonDiameterEstimation_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonDiameterEstimation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Image;
global OptimizedSplinePoints1;
global OptimizedControlPoints1;
global OptimizedSplinePoints2;
global OptimizedControlPoints2;

global TracePointsOnSmallerSpline;
global TracePointsOnBiggerSpline;
global ModifiedTracePointsOnBiggerSpline;

global IndexOfMinDiamter;
global IndexOfStenosisBeginning;
global IndexOfStenosisEnding;

global StenosisDetectedFlag;

global LengthOfTraces;

% global ControlPoints1;
% global SplinePoints1;
% global ControlPoints2;
% global SplinePoints2;


A = get(get(handles.ButtonGroupTraceAlgorithms, 'SelectedObject'), 'Tag');


switch A
    case 'RadioButtonDirectAlg',
        [ TracePointsOnSmallerSpline, TracePointsOnBiggerSpline, SmallerSpline, BiggerSpline] = Match2Splinesv2( OptimizedSplinePoints1, OptimizedSplinePoints2 );
        
        axes(handles.AxesOutputImagePlot2);
        Plot2SplineSWithGivenImage( Image, OptimizedControlPoints1, OptimizedSplinePoints1, OptimizedControlPoints2, OptimizedSplinePoints2  );
        
        
        %%% PLOT each trace one by one
        [a,b] = size(TracePointsOnSmallerSpline);
        for i=1:1:a
            
            x1 = TracePointsOnSmallerSpline(i,1);
            y1 = TracePointsOnSmallerSpline(i,2);
            x2 = TracePointsOnBiggerSpline(i,1);
            y2 = TracePointsOnBiggerSpline(i,2);
            
            
            % x1 = point1(1,1);
            % y1 = point1(1,2);
            % x2 = intersectingPoint(1,1);
            % y2 = intersectingPoint(1,2);
            
            coord1 = [x1, x2];
            coord2 = [y1, y2];
            plot(coord1, coord2, 'b-','LineWidth',2);
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        %%%%% now find the lengths of each trace to detect stenotic region.
        LengthOfTraces = zeros(length(TracePointsOnSmallerSpline),1);
        for i=1:1:length(TracePointsOnSmallerSpline)
            LengthOfTraces(i) = sqrt((TracePointsOnSmallerSpline(i,1) - TracePointsOnBiggerSpline(i,1))^2 +...
                (TracePointsOnSmallerSpline(i,2) - TracePointsOnBiggerSpline(i,2))^2);
            
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
    case 'RadioButtonShortestDistanceAlg',
        [ TracePointsOnSmallerSpline, TracePointsOnBiggerSpline, SmallerSpline, BiggerSpline] = Match2Splinesv2( OptimizedSplinePoints1, OptimizedSplinePoints2 );
        ModifiedTracePointsOnBiggerSpline = SearchForShortestDiameter(SmallerSpline, BiggerSpline, TracePointsOnSmallerSpline,TracePointsOnBiggerSpline );
        
        axes(handles.AxesOutputImagePlot2);
        Plot2SplineSWithGivenImage( Image, OptimizedControlPoints1, OptimizedSplinePoints1, OptimizedControlPoints2, OptimizedSplinePoints2  );
        
        
        
        
        %%% PLOT each trace one by one
        [a,b] = size(TracePointsOnSmallerSpline);
        for i=1:1:a
            
            x1 = TracePointsOnSmallerSpline(i,1);
            y1 = TracePointsOnSmallerSpline(i,2);
            x2 = ModifiedTracePointsOnBiggerSpline(i,1);
            y2 = ModifiedTracePointsOnBiggerSpline(i,2);
            
            
            % x1 = point1(1,1);
            % y1 = point1(1,2);
            % x2 = intersectingPoint(1,1);
            % y2 = intersectingPoint(1,2);
            
            coord1 = [x1, x2];
            coord2 = [y1, y2];
            plot(coord1, coord2, 'b-','LineWidth',2);
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        
        %%%%% now find the lengths of each trace to detect stenotic region.
        LengthOfTraces = zeros(length(TracePointsOnSmallerSpline),1);
        for i=1:1:length(TracePointsOnSmallerSpline)
            LengthOfTraces(i) = sqrt((TracePointsOnSmallerSpline(i,1) - ModifiedTracePointsOnBiggerSpline(i,1))^2 +...
                (TracePointsOnSmallerSpline(i,2) - ModifiedTracePointsOnBiggerSpline(i,2))^2);
            
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
    case 'RadioButtonSimilarSlopeAlg',
        [ TracePointsOnSmallerSpline, TracePointsOnBiggerSpline, SmallerSpline, BiggerSpline] = Match2Splinesv2( OptimizedSplinePoints1, OptimizedSplinePoints2 );
        ModifiedTracePointsOnBiggerSpline = SearchForSimilarSlope(SmallerSpline, BiggerSpline, TracePointsOnSmallerSpline,TracePointsOnBiggerSpline);
        
        axes(handles.AxesOutputImagePlot2);
        Plot2SplineSWithGivenImage( Image, OptimizedControlPoints1, OptimizedSplinePoints1, OptimizedControlPoints2, OptimizedSplinePoints2  );
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        
        %%% PLOT each trace one by one
        [a,b] = size(TracePointsOnSmallerSpline);
        for i=1:1:a
            
            x1 = TracePointsOnSmallerSpline(i,1);
            y1 = TracePointsOnSmallerSpline(i,2);
            x2 = ModifiedTracePointsOnBiggerSpline(i,1);
            y2 = ModifiedTracePointsOnBiggerSpline(i,2);
            
            
            % x1 = point1(1,1);
            % y1 = point1(1,2);
            % x2 = intersectingPoint(1,1);
            % y2 = intersectingPoint(1,2);
            
            coord1 = [x1, x2];
            coord2 = [y1, y2];
            plot(coord1, coord2, 'b-','LineWidth',2);
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        %%%%% now find the lengths of each trace to detect stenotic region.
        LengthOfTraces = zeros(length(TracePointsOnSmallerSpline),1);
        for i=1:1:length(TracePointsOnSmallerSpline)
            LengthOfTraces(i) = sqrt((TracePointsOnSmallerSpline(i,1) - ModifiedTracePointsOnBiggerSpline(i,1))^2 +...
                (TracePointsOnSmallerSpline(i,2) - ModifiedTracePointsOnBiggerSpline(i,2))^2);
            
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
    case 'RadioButtonHybridAlg',
        [ TracePointsOnSmallerSpline, TracePointsOnBiggerSpline, SmallerSpline, BiggerSpline] = Match2Splinesv2( OptimizedSplinePoints1, OptimizedSplinePoints2 );
        ModifiedTracePointsOnBiggerSpline = SearchForShortestDiameterWithCorrection(SmallerSpline, BiggerSpline, TracePointsOnSmallerSpline,TracePointsOnBiggerSpline );
        
        axes(handles.AxesOutputImagePlot2);
        Plot2SplineSWithGivenImage( Image, OptimizedControlPoints1, OptimizedSplinePoints1, OptimizedControlPoints2, OptimizedSplinePoints2  );
        
        
        %%% PLOT each trace one by one
        [a,b] = size(TracePointsOnSmallerSpline);
        for i=1:1:a
            
            x1 = TracePointsOnSmallerSpline(i,1);
            y1 = TracePointsOnSmallerSpline(i,2);
            x2 = ModifiedTracePointsOnBiggerSpline(i,1);
            y2 = ModifiedTracePointsOnBiggerSpline(i,2);
            
            
            % x1 = point1(1,1);
            % y1 = point1(1,2);
            % x2 = intersectingPoint(1,1);
            % y2 = intersectingPoint(1,2);
            
            coord1 = [x1, x2];
            coord2 = [y1, y2];
            plot(coord1, coord2, 'b-','LineWidth',2);
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        
        
        
        %%%%% now find the lengths of each trace to detect stenotic region.
        LengthOfTraces = zeros(length(TracePointsOnSmallerSpline),1);
        SlopeOfTraces = zeros(length(TracePointsOnSmallerSpline),1);
        for i=1:1:length(TracePointsOnSmallerSpline)
            LengthOfTraces(i) = sqrt((TracePointsOnSmallerSpline(i,1) - ModifiedTracePointsOnBiggerSpline(i,1))^2 +...
                (TracePointsOnSmallerSpline(i,2) - ModifiedTracePointsOnBiggerSpline(i,2))^2);
            SlopeOfTraces(i) = (TracePointsOnSmallerSpline(i,2) - ModifiedTracePointsOnBiggerSpline(i,2))/(TracePointsOnSmallerSpline(i,1) - ModifiedTracePointsOnBiggerSpline(i,1));
            
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %%%% TRACE PERFORMANCE MEASURE   %%%%%
        RoundedSpline1 = round(TracePointsOnSmallerSpline);
        RoundedSpline2 = round(ModifiedTracePointsOnBiggerSpline);
        
        True = 0;
        False = 0;
%         for i=1:1:length(TracePointsOnSmallerSpline)
%             if(RoundedSpline1(i,2) == RoundedSpline2(i,2))
%                 True = True + 1;
%             else
%                 False = False + 1;
%             end
%                 
%         end
        
        for i=1:1:length(SlopeOfTraces)
            if(abs(SlopeOfTraces(i)) < 0.1)
                True = True + 1;
            else
                False = False + 1;
            end
                
        end
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
end



        
        
        
        
        
        
        



% [ TracePointsOnSmallerSpline, TracePointsOnBiggerSpline, SmallerSpline, BiggerSpline] = Match2Splinesv2( OptimizedSplinePoints1, OptimizedSplinePoints2 );
% 
% ModifiedTracePointsOnBiggerSpline = SearchForShortestDiameter(SmallerSpline, BiggerSpline, TracePointsOnSmallerSpline,TracePointsOnBiggerSpline );
% %ModifiedTracePointsOnBiggerSpline = SearchForSimilarSlope(SmallerSpline, BiggerSpline, TracePointsOnSmallerSpline,TracePointsOnBiggerSpline);
% 
% %%%% Plot the optimized splines
% axes(handles.AxesOutputImagePlot2);
% hold off;
% imshow(Image);
% hold on;
% plot(OptimizedControlPoints1(:,1),OptimizedControlPoints1(:,2),'ro','MarkerSize',3,'MarkerFaceColor','r');
% plot(OptimizedSplinePoints1(:,1),OptimizedSplinePoints1(:,2),'b-','LineWidth',1);
% 
% plot(OptimizedControlPoints2(:,1),OptimizedControlPoints2(:,2),'ro','MarkerSize',3,'MarkerFaceColor','r');
% plot(OptimizedSplinePoints2(:,1),OptimizedSplinePoints2(:,2),'b-','LineWidth',1);


% 
% %%% PLOT each trace one by one
% [a,b] = size(TracePointsOnSmallerSpline);
% for i=1:1:a
%     
%     x1 = TracePointsOnSmallerSpline(i,1);
%     y1 = TracePointsOnSmallerSpline(i,2);
%     x2 = ModifiedTracePointsOnBiggerSpline(i,1);
%     y2 = ModifiedTracePointsOnBiggerSpline(i,2);
%     
%     
%     % x1 = point1(1,1);
%     % y1 = point1(1,2);
%     % x2 = intersectingPoint(1,1);
%     % y2 = intersectingPoint(1,2);
%     
%     coord1 = [x1, x2];
%     coord2 = [y1, y2];
%     plot(coord1, coord2, 'b-','LineWidth',2);
% end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




% %%%%% now find the lengths of each trace to detect stenotic region.
% LengthOfTraces = zeros(length(TracePointsOnSmallerSpline),1);
% for i=1:1:length(TracePointsOnSmallerSpline)
%     LengthOfTraces(i) = sqrt((TracePointsOnSmallerSpline(i,1) - ModifiedTracePointsOnBiggerSpline(i,1))^2 +...
%         (TracePointsOnSmallerSpline(i,2) - ModifiedTracePointsOnBiggerSpline(i,2))^2);
%    
% end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




% initilize stenosis detection flags to zero.
BeginningOfStenosisDetected = 0;
EndOfStenosisDetected = 0;
IndexOfStenosisBeginning = 0;
IndexOfStenosisEnding = 0;

for i=2:1:length(LengthOfTraces)
    DeltaOfLengthOfTraces(i-1) = LengthOfTraces(i)- LengthOfTraces(i-1);
    
    if((DeltaOfLengthOfTraces(i-1) < -0.1) && (BeginningOfStenosisDetected == 0))
        BeginningOfStenosisDetected = 1;
        IndexOfStenosisBeginning = i;
    end
    
    if(DeltaOfLengthOfTraces(i-1) > 0.1 && (BeginningOfStenosisDetected == 1))
        EndOfStenosisDetected = 1;
        IndexOfStenosisEnding = i;
        %break;  % end point is also detected, quit the loop
    end
end



%%% STENOSIS is detected, now plot stenotic region
% what if no stenosis is detected.


% 
% hold off;
% imshow(Image);
% hold on;
% plot(OptimizedControlPoints1(:,1),OptimizedControlPoints1(:,2),'ro','MarkerSize',3,'MarkerFaceColor','r');
% plot(OptimizedSplinePoints1(:,1),OptimizedSplinePoints1(:,2),'b-','LineWidth',1);
% 
% plot(OptimizedControlPoints2(:,1),OptimizedControlPoints2(:,2),'ro','MarkerSize',3,'MarkerFaceColor','r');
% plot(OptimizedSplinePoints2(:,1),OptimizedSplinePoints2(:,2),'b-','LineWidth',1);
% 
% 
% %%% Plot beginning of the stenosis
% x1 = TracePointsOnSmallerSpline(IndexOfStenosisBeginning,1);
% y1 = TracePointsOnSmallerSpline(IndexOfStenosisBeginning,2);
% x2 = ModifiedTracePointsOnBiggerSpline(IndexOfStenosisBeginning,1);
% y2 = ModifiedTracePointsOnBiggerSpline(IndexOfStenosisBeginning,2);
% coord1 = [x1, x2];
% coord2 = [y1, y2];
% plot(coord1, coord2, 'b-','LineWidth',2);
% 
% 
% %%% plot end point of stenosis
% x1 = TracePointsOnSmallerSpline(IndexOfStenosisEnding,1);
% y1 = TracePointsOnSmallerSpline(IndexOfStenosisEnding,2);
% x2 = ModifiedTracePointsOnBiggerSpline(IndexOfStenosisEnding,1);
% y2 = ModifiedTracePointsOnBiggerSpline(IndexOfStenosisEnding,2);
% coord1 = [x1, x2];
% coord2 = [y1, y2];
% plot(coord1, coord2, 'b-','LineWidth',2);
% 







%%%% if a STENOSIS is detected, quantify it. Else do not any quantification
if((BeginningOfStenosisDetected == 1) && (EndOfStenosisDetected == 1))
    
    StenosisDetectedFlag = 1;
    Sum = 0;
    NumberOfTraces = 0;
    IndexOfMinDiamter = 0;
    MinimumDiameter = LengthOfTraces(IndexOfStenosisBeginning); %% take the first one as minimum
    for i=1:1:length(LengthOfTraces)
        
        if(((i>0) && (i<IndexOfStenosisBeginning)) || ((i>IndexOfStenosisEnding) && i<= length(LengthOfTraces)))
            Sum = Sum + LengthOfTraces(i);
            NumberOfTraces = NumberOfTraces + 1;
            
            
        elseif(LengthOfTraces(i) < MinimumDiameter)
            MinimumDiameter = LengthOfTraces(i);
            IndexOfMinDiamter = i;
            
        end
        
    end
    MeanOfNonStenoticRegion = Sum/NumberOfTraces;
    
    
    PercentLengthStenosis = (1-(MinimumDiameter/MeanOfNonStenoticRegion))*100;
    PercentAreaStenosis = (1- (MinimumDiameter^2/MeanOfNonStenoticRegion^2))*100;
    MLA = pi * (MinimumDiameter/2)^2; % circular cros section assumption
    
    set (handles.StaticTextPercentLengthStenosis, 'string', PercentLengthStenosis);
    set (handles.StaticTextPercentAreaStenosis, 'string', PercentAreaStenosis);
    set(handles.StaticTextMLD, 'string', MinimumDiameter);
    set(handles.StaticTextMLA, 'string', MLA);
    set(handles.StaticTextStenosisLength, 'string', '');
    
else
    uiwait(msgbox('No STENOSIS is detected', 'WARNING', 'warn'));
    StenosisDetectedFlag = 0;
    set (handles.StaticTextPercentLengthStenosis, 'string', '');
    set (handles.StaticTextPercentAreaStenosis, 'string', '');
    set(handles.StaticTextMLD, 'string', '');
    set(handles.StaticTextMLA, 'string', '');
    set(handles.StaticTextStenosisLength, 'string', '');
    
    
end






% --- Executes on button press in ButtonShowInitialTraces.
function ButtonShowInitialTraces_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonShowInitialTraces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Image;
global OptimizedSplinePoints1;
global OptimizedControlPoints1;
global OptimizedSplinePoints2;
global OptimizedControlPoints2;

global TracePointsOnSmallerSpline;
global TracePointsOnBiggerSpline;



axes(handles.AxesOutputImagePlot2);

hold off;
imshow(Image);
hold on;
plot(OptimizedControlPoints1(:,1),OptimizedControlPoints1(:,2),'ro','MarkerSize',5,'MarkerFaceColor','r');
plot(OptimizedSplinePoints1(:,1),OptimizedSplinePoints1(:,2),'b-','LineWidth',2);

plot(OptimizedControlPoints2(:,1),OptimizedControlPoints2(:,2),'ro','MarkerSize',5,'MarkerFaceColor','r');
plot(OptimizedSplinePoints2(:,1),OptimizedSplinePoints2(:,2),'b-','LineWidth',2);

[a,b] = size(TracePointsOnSmallerSpline);

for i=1:1:a
    
    x1 = TracePointsOnSmallerSpline(i,1);
    y1 = TracePointsOnSmallerSpline(i,2);
    x2 = TracePointsOnBiggerSpline(i,1);
    y2 = TracePointsOnBiggerSpline(i,2);
    
    
    % x1 = point1(1,1);
    % y1 = point1(1,2);
    % x2 = intersectingPoint(1,1);
    % y2 = intersectingPoint(1,2);
    
    coord1 = [x1, x2];
    coord2 = [y1, y2];
    plot(coord1, coord2, 'b-','LineWidth',2);
end



% --- Executes on button press in ButtonShowRefinedTraces.
function ButtonShowRefinedTraces_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonShowRefinedTraces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Image;
global OptimizedSplinePoints1;
global OptimizedControlPoints1;
global OptimizedSplinePoints2;
global OptimizedControlPoints2;

global TracePointsOnSmallerSpline;
global ModifiedTracePointsOnBiggerSpline;



axes(handles.AxesOutputImagePlot2);

hold off;
imshow(Image);
hold on;
plot(OptimizedControlPoints1(:,1),OptimizedControlPoints1(:,2),'ro','MarkerSize',5,'MarkerFaceColor','r');
plot(OptimizedSplinePoints1(:,1),OptimizedSplinePoints1(:,2),'b-','LineWidth',2);

plot(OptimizedControlPoints2(:,1),OptimizedControlPoints2(:,2),'ro','MarkerSize',5,'MarkerFaceColor','r');
plot(OptimizedSplinePoints2(:,1),OptimizedSplinePoints2(:,2),'b-','LineWidth',2);

[a,b] = size(TracePointsOnSmallerSpline);

for i=1:1:a
    
    x1 = TracePointsOnSmallerSpline(i,1);
    y1 = TracePointsOnSmallerSpline(i,2);
    x2 = ModifiedTracePointsOnBiggerSpline(i,1);
    y2 = ModifiedTracePointsOnBiggerSpline(i,2);
    
    
    % x1 = point1(1,1);
    % y1 = point1(1,2);
    % x2 = intersectingPoint(1,1);
    % y2 = intersectingPoint(1,2);
    
    coord1 = [x1, x2];
    coord2 = [y1, y2];
    plot(coord1, coord2, 'b-','LineWidth',2);
end


% --- Executes on button press in ButtonGetFrame.
function ButtonGetFrame_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonGetFrame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%%%%%%%%%%%%%%  GET FRAME    %%%%%%%%%%%%%%%%%
% F = getframe(handles.AxesOutputImagePlot2);
% FileName = get(handles.EditGetFrameFileName, 'String');
% 
% % a = strcmp(FileName,'');
% % b= blanks(1);
% c = isempty(FileName);
% if (c)
%     warndlg('Please enter the name of the file');
% else
%     
%     
%     %image(F.cdata);
%     imwrite(F.cdata, strcat(FileName, '.jpg'));
% end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%   export_fig    %%%%%%%%%%%%%%%%%%%%%%%%%
FileName = get(handles.EditGetFrameFileName, 'String');

c = isempty(FileName);
if (c)
    warndlg('Please enter the name of the file');
else
 
    exportedImage = export_fig(handles.AxesOutputImagePlot2);
    imwrite(exportedImage, strcat(FileName, '.jpg'));
end





function EditGetFrameFileName_Callback(hObject, eventdata, handles)
% hObject    handle to EditGetFrameFileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditGetFrameFileName as text
%        str2double(get(hObject,'String')) returns contents of EditGetFrameFileName as a double


% --- Executes during object creation, after setting all properties.
function EditGetFrameFileName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditGetFrameFileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ButtonPlotResults.
function ButtonPlotResults_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonPlotResults (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



axes(handles.AxesOutputImagePlot2);
% 
% Filter = fspecial('gaussian', 5);
% imagesc(Gaussian2D(7,2.5))
% 
% %[N,b] = size(Image);%%% SQUARE image is assumed
% 
sigma = 1;     % increasing sigma means increasing blurring
sigmaY = 1;
lambda = 0.005;
N = 7;

% f = Gabor2D(N, sigmaX, sigmaY, 'ODD');
% hold off;
% imagesc(f);
% 
% [ gaborArray ] = GaborFilterBank( 1, 3, 7, 7);
% 
% imagesc(abs(cell2mat(gaborArray(1,1))));


% Gabor1D function can be called with both 'EVEN' and 'ODD' parameters.
[func, x] = Gabor1D(N, sigma, 'EVEN');
hold off;
plot(x, func);
xlabel('x');
ylabel('S(x)');
title('Odd Gabor Function');
%  line properties
xL = [-4,4];
yL = [-1,1];
line([0 0], yL, 'Color','k');  %plot x-axis
line(xL, [0 0], 'Color','k');  % plot y-axis


%%%%   take zero mean of gabor filter
zeroMeanGabor = func - mean(func);

% %[func,x] = Gabor1Dwhole( N, sigma );
% 

[FourierOfFunc, NFFT] = Take1DfourierTransform(zeroMeanGabor);
%[FourierOfFunc, NFFT] = Take1DfourierTransform(func);
AbsOfFourierOfFunc = abs(FourierOfFunc);
AbsOfFourierOfFunc = fftshift(AbsOfFourierOfFunc);
%F = (0: (NFFT -1))/NFFT;

F = (-NFFT/2: (NFFT/2 -1))/NFFT;

hold off;
plot(F, AbsOfFourierOfFunc);
axis([-0.2 0.2 -2 14]);
xL = [-0.2,0.2];
yL = [-2,14];
line([0 0], yL, 'Color','k');  %x-axis
line(xL, [0 0], 'Color','k');  %y-axis
xlabel('\omega');
ylabel('|C(\omega)|');
title('Fourier Transform of Zero Mean Even Gabor Function ');



% [func2,x] = SGabor1D(N, sigma, lambda, 'EVEN');
% 
% [FourierOfFunc, NFFT] = Take1DfourierTransform(func2);
% AbsOfFourierOfFunc = abs(FourierOfFunc);
% AbsOfFourierOfFunc = fftshift(AbsOfFourierOfFunc);
% %F = (0: (NFFT -1))/NFFT;
% 
% F = (-NFFT/2: (NFFT/2 -1))/NFFT;
% 
% hold on;
% plot(F, AbsOfFourierOfFunc, '--r');
% 
% 
% hold on;
% plot(x, func2, '--r');
% 
% meanGabor = mean(func);
% meanSGabor = mean(func2);

[func, x] = Gabor1D(N, sigma, 'EVEN');
hold off;
plot(x, func);


% [func2,x] = SGabor1D(N, sigma,lambda,  'EVEN');
% hold on;
% plot(x, func2, '--r');

Nfft = nextpow2(length(x));
FFTfunc = fft(func, Nfft);
plot(real(FFTfunc));
[func, x] = Gabor1D(N, sigma, 'EVEN');
plot(x,func);
% 
% gaussianFunc1D = Gaussian1D(N, sigma);
% plot(gaussianFunc1D);
% gaussianFunc2D = Gaussian2D(N,sigma);
% plot(gaussianFunc2D);
% 
% FilteredImage=conv2(Image,gaussianFunc2D,'same');


% --- Executes on button press in ButtonShowStenoticRegion.
function ButtonShowStenoticRegion_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonShowStenoticRegion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global OptimizedControlPoints1;
global OptimizedSplinePoints1;
global OptimizedControlPoints2;
global OptimizedSplinePoints2;

global IndexOfStenosisBeginning;
global IndexOfStenosisEnding;

global TracePointsOnSmallerSpline;
global ModifiedTracePointsOnBiggerSpline;
global TracePointsOnBiggerSpline;

global IndexOfMinDiamter;

global Image;
global AnisotropicDiffusedImage;
global StenosisDetectedFlag;


if( StenosisDetectedFlag == 1)
    
    
    hold off;
    axes(handles.AxesOutputImagePlot2);
    imshow(Image);
    %imshow(AnisotropicDiffusedImage);
    hold on;
    plot(OptimizedControlPoints1(:,1),OptimizedControlPoints1(:,2),'ro','MarkerSize',3,'MarkerFaceColor','r');
    plot(OptimizedSplinePoints1(:,1),OptimizedSplinePoints1(:,2),'b-','LineWidth',1);
    
    plot(OptimizedControlPoints2(:,1),OptimizedControlPoints2(:,2),'ro','MarkerSize',3,'MarkerFaceColor','r');
    plot(OptimizedSplinePoints2(:,1),OptimizedSplinePoints2(:,2),'b-','LineWidth',1);
    
    A = get(get(handles.ButtonGroupTraceAlgorithms, 'SelectedObject'), 'Tag');
    if(strcmp(A, 'RadioButtonDirectAlg'))
        
        %%% Plot beginning of the stenosis
        x1 = TracePointsOnSmallerSpline(IndexOfStenosisBeginning,1);
        y1 = TracePointsOnSmallerSpline(IndexOfStenosisBeginning,2);
        x2 = TracePointsOnBiggerSpline(IndexOfStenosisBeginning,1);
        y2 = TracePointsOnBiggerSpline(IndexOfStenosisBeginning,2);
        coord1 = [x1, x2];
        coord2 = [y1, y2];
        plot(coord1, coord2, 'b-','LineWidth',2);
        
        
        %%% plot end point of stenosis
        x1 = TracePointsOnSmallerSpline(IndexOfStenosisEnding,1);
        y1 = TracePointsOnSmallerSpline(IndexOfStenosisEnding,2);
        x2 = TracePointsOnBiggerSpline(IndexOfStenosisEnding,1);
        y2 = TracePointsOnBiggerSpline(IndexOfStenosisEnding,2);
        coord1 = [x1, x2];
        coord2 = [y1, y2];
        plot(coord1, coord2, 'b-','LineWidth',2);
        
        
        %%%% plot the min diameter
        x1 = TracePointsOnSmallerSpline(IndexOfMinDiamter,1);
        y1 = TracePointsOnSmallerSpline(IndexOfMinDiamter,2);
        x2 = TracePointsOnBiggerSpline(IndexOfMinDiamter,1);
        y2 = TracePointsOnBiggerSpline(IndexOfMinDiamter,2);
        coord1 = [x1, x2];
        coord2 = [y1, y2];
        plot(coord1, coord2, 'b-','LineWidth',2);
    else
        
        %%% Plot beginning of the stenosis
        x1 = TracePointsOnSmallerSpline(IndexOfStenosisBeginning,1);
        y1 = TracePointsOnSmallerSpline(IndexOfStenosisBeginning,2);
        x2 = ModifiedTracePointsOnBiggerSpline(IndexOfStenosisBeginning,1);
        y2 = ModifiedTracePointsOnBiggerSpline(IndexOfStenosisBeginning,2);
        coord1 = [x1, x2];
        coord2 = [y1, y2];
        plot(coord1, coord2, 'b-','LineWidth',2);
        
        
        %%% plot end point of stenosis
        x1 = TracePointsOnSmallerSpline(IndexOfStenosisEnding,1);
        y1 = TracePointsOnSmallerSpline(IndexOfStenosisEnding,2);
        x2 = ModifiedTracePointsOnBiggerSpline(IndexOfStenosisEnding,1);
        y2 = ModifiedTracePointsOnBiggerSpline(IndexOfStenosisEnding,2);
        coord1 = [x1, x2];
        coord2 = [y1, y2];
        plot(coord1, coord2, 'b-','LineWidth',2);
        
        
        %%%% plot the min diameter
        x1 = TracePointsOnSmallerSpline(IndexOfMinDiamter,1);
        y1 = TracePointsOnSmallerSpline(IndexOfMinDiamter,2);
        x2 = ModifiedTracePointsOnBiggerSpline(IndexOfMinDiamter,1);
        y2 = ModifiedTracePointsOnBiggerSpline(IndexOfMinDiamter,2);
        coord1 = [x1, x2];
        coord2 = [y1, y2];
        plot(coord1, coord2, 'b-','LineWidth',2);
        
        
    end
    
    
else
    uiwait(msgbox('No STENOSIS is detected', 'WARNING', 'warn'));
    
    
end








% --- Executes on button press in ButtonShowOptSplineAndEnergyField.
function ButtonShowOptSplineAndEnergyField_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonShowOptSplineAndEnergyField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global CompositeEnergy;
%global Image;
global OptimizedSplinePoints1;
global OptimizedControlPoints1;
global OptimizedSplinePoints2;
global OptimizedControlPoints2;


axes(handles.AxesOutputImagePlot2);

hold off;
imagesc(CompositeEnergy);
hold on;
plot(OptimizedControlPoints1(:,1),OptimizedControlPoints1(:,2),'ro','MarkerSize',5,'MarkerFaceColor','r');
plot(OptimizedSplinePoints1(:,1),OptimizedSplinePoints1(:,2),'b-','LineWidth',2);

plot(OptimizedControlPoints2(:,1),OptimizedControlPoints2(:,2),'ro','MarkerSize',5,'MarkerFaceColor','r');
plot(OptimizedSplinePoints2(:,1),OptimizedSplinePoints2(:,2),'b-','LineWidth',2);


% --- Executes on button press in ShowInitalSplineOnEnergyField.
function ShowInitalSplineOnEnergyField_Callback(hObject, eventdata, handles)
% hObject    handle to ShowInitalSplineOnEnergyField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


global CompositeEnergy;
%global Image;
global ControlPoints1;
global SplinePoints1;
global ControlPoints2;
global SplinePoints2;
axes(handles.AxesOutputImagePlot2);

hold off;
imagesc(CompositeEnergy);
hold on;
plot(ControlPoints1(:,1),ControlPoints1(:,2),'ro','MarkerSize',5,'MarkerFaceColor','r');
plot(SplinePoints1(:,1),SplinePoints1(:,2),'b-','LineWidth',2);

plot(ControlPoints2(:,1),ControlPoints2(:,2),'ro','MarkerSize',5,'MarkerFaceColor','r');
plot(SplinePoints2(:,1),SplinePoints2(:,2),'b-','LineWidth',2);


% --- Executes on button press in ButtonShowStenosisLength.
function ButtonShowStenosisLength_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonShowStenosisLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global TracePointsOnSmallerSpline;
global ModifiedTracePointsOnBiggerSpline;
global TracePointsOnBiggerSpline;

global OptimizedControlPoints1;
global OptimizedSplinePoints1;
global OptimizedControlPoints2;
global OptimizedSplinePoints2;

global IndexOfMinDiamter;

global Image;

global StenosisDetectedFlag;


global IndexOfStenosisBeginning;
global IndexOfStenosisEnding;

if( StenosisDetectedFlag == 1)
    
    
    A = get(get(handles.ButtonGroupTraceAlgorithms, 'SelectedObject'), 'Tag');
    if(strcmp(A, 'RadioButtonDirectAlg'))
        
        point1 = TracePointsOnSmallerSpline(IndexOfStenosisBeginning,:);
        point2 = TracePointsOnBiggerSpline(IndexOfStenosisBeginning,:);
        
        
        
        point3 = TracePointsOnSmallerSpline(IndexOfStenosisEnding,:);
        point4 = TracePointsOnBiggerSpline(IndexOfStenosisEnding,:);
        
        MiddlePointOnFirstTrace = (point1 + point2)/2;
        MiddlePointOnSecondTrace = (point3 + point4)/2;
        
        
        %LengthOfTheStenosis = sqrt((MiddlePointOnFirstTrace(1,1) - MiddlePointOnSecondTrace(1,1))^2 +...
            %(MiddlePointOnFirstTrace(1,2) - MiddlePointOnSecondTrace(1,2))^2);
        
        
        hold off;
        axes(handles.AxesOutputImagePlot2);
        imshow(Image);
        hold on;
        plot(OptimizedControlPoints1(:,1),OptimizedControlPoints1(:,2),'ro','MarkerSize',3,'MarkerFaceColor','r');
        plot(OptimizedSplinePoints1(:,1),OptimizedSplinePoints1(:,2),'b-','LineWidth',1);
        
        plot(OptimizedControlPoints2(:,1),OptimizedControlPoints2(:,2),'ro','MarkerSize',3,'MarkerFaceColor','r');
        plot(OptimizedSplinePoints2(:,1),OptimizedSplinePoints2(:,2),'b-','LineWidth',1);
        
        
        %%% Plot beginning of the stenosis
        x1 = TracePointsOnSmallerSpline(IndexOfStenosisBeginning,1);
        y1 = TracePointsOnSmallerSpline(IndexOfStenosisBeginning,2);
        x2 = TracePointsOnBiggerSpline(IndexOfStenosisBeginning,1);
        y2 = TracePointsOnBiggerSpline(IndexOfStenosisBeginning,2);
        coord1 = [x1, x2];
        coord2 = [y1, y2];
        plot(coord1, coord2, 'b-','LineWidth',2);
        
        
        %%% plot end point of stenosis
        x1 = TracePointsOnSmallerSpline(IndexOfStenosisEnding,1);
        y1 = TracePointsOnSmallerSpline(IndexOfStenosisEnding,2);
        x2 = TracePointsOnBiggerSpline(IndexOfStenosisEnding,1);
        y2 = TracePointsOnBiggerSpline(IndexOfStenosisEnding,2);
        coord1 = [x1, x2];
        coord2 = [y1, y2];
        plot(coord1, coord2, 'b-','LineWidth',2);
        
        
        %%%%%%%%%%%%  calculate centerline  %%%%%%%%%%
        Length = length(OptimizedSplinePoints1);
        
        for i=1:1:Length
            Centerline(i,:) = (OptimizedSplinePoints1(i,:) + OptimizedSplinePoints2(i,:))/2;
        end
        
        % centerline ýn tamamýný çizer
        %plot(Centerline(:,1),Centerline(:,2),'r-','LineWidth',2);
        
        %%% Yöntem-1
        [~, Index1] = min(abs(Centerline - MiddlePointOnFirstTrace(1,1)));
        [~, Index2] = min(abs(Centerline - MiddlePointOnSecondTrace(1,1)));
        
        LesionLengthArray = Centerline((Index1: Index2) , [1 2]);
        plot(LesionLengthArray(:,1),LesionLengthArray(:,2),'r-','LineWidth',2);
        LengthOfTheStenosis = CalculateLengthOfTheSpline(LesionLengthArray);
        
        
        
        %%% Yöntem-2
        [a,b] = size(Centerline);
        
        minDistance =  FindDistanceBetweenTwoPoints(MiddlePointOnFirstTrace, Centerline(1,:));
        for i=1:1:a
            distance = FindDistanceBetweenTwoPoints(MiddlePointOnFirstTrace, Centerline(i,:));
            if(distance < minDistance)
                minDistance = distance;
                LesionStartPoint = Centerline(i,:);
                LesionStartPointIndex = i;
            end
            
        end
        
        
        minDistance =  FindDistanceBetweenTwoPoints(MiddlePointOnSecondTrace, Centerline(1,:));
        for i=1:1:a
            distance = FindDistanceBetweenTwoPoints(MiddlePointOnSecondTrace, Centerline(i,:));
            if(distance < minDistance)
                minDistance = distance;
                LesionEndPoint = Centerline(i,:);
                LesionEndPointIndex = i;
            end
            
        end
        
        
        LesionLengthArray = Centerline((LesionStartPointIndex: LesionEndPointIndex) , [1 2]);
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        %PlotLineBetweenTwoPoints(MiddlePointOnFirstTrace, MiddlePointOnSecondTrace);
        
        plot(LesionLengthArray(:,1),LesionLengthArray(:,2),'r-','LineWidth',2);
        LengthOfTheStenosis = CalculateLengthOfTheSpline(LesionLengthArray);
        set (handles.StaticTextStenosisLength, 'string', LengthOfTheStenosis);
        
        
    else
        
        point1 = TracePointsOnSmallerSpline(IndexOfStenosisBeginning,:);
        point2 = ModifiedTracePointsOnBiggerSpline(IndexOfStenosisBeginning,:);
        
        
        
        point3 = TracePointsOnSmallerSpline(IndexOfStenosisEnding,:);
        point4 = ModifiedTracePointsOnBiggerSpline(IndexOfStenosisEnding,:);
        
        MiddlePointOnFirstTrace = (point1 + point2)/2;
        MiddlePointOnSecondTrace = (point3 + point4)/2;
        
        
        %LengthOfTheStenosis = sqrt((MiddlePointOnFirstTrace(1,1) - MiddlePointOnSecondTrace(1,1))^2 +...
            %(MiddlePointOnFirstTrace(1,2) - MiddlePointOnSecondTrace(1,2))^2);
        
        
        hold off;
        axes(handles.AxesOutputImagePlot2);
        imshow(Image);
        hold on;
        plot(OptimizedControlPoints1(:,1),OptimizedControlPoints1(:,2),'ro','MarkerSize',3,'MarkerFaceColor','r');
        plot(OptimizedSplinePoints1(:,1),OptimizedSplinePoints1(:,2),'b-','LineWidth',1);
        
        plot(OptimizedControlPoints2(:,1),OptimizedControlPoints2(:,2),'ro','MarkerSize',3,'MarkerFaceColor','r');
        plot(OptimizedSplinePoints2(:,1),OptimizedSplinePoints2(:,2),'b-','LineWidth',1);
        
        
        %%% Plot beginning of the stenosis
        x1 = TracePointsOnSmallerSpline(IndexOfStenosisBeginning,1);
        y1 = TracePointsOnSmallerSpline(IndexOfStenosisBeginning,2);
        x2 = ModifiedTracePointsOnBiggerSpline(IndexOfStenosisBeginning,1);
        y2 = ModifiedTracePointsOnBiggerSpline(IndexOfStenosisBeginning,2);
        coord1 = [x1, x2];
        coord2 = [y1, y2];
        plot(coord1, coord2, 'b-','LineWidth',2);
        
        
        %%% plot end point of stenosis
        x1 = TracePointsOnSmallerSpline(IndexOfStenosisEnding,1);
        y1 = TracePointsOnSmallerSpline(IndexOfStenosisEnding,2);
        x2 = ModifiedTracePointsOnBiggerSpline(IndexOfStenosisEnding,1);
        y2 = ModifiedTracePointsOnBiggerSpline(IndexOfStenosisEnding,2);
        coord1 = [x1, x2];
        coord2 = [y1, y2];
        plot(coord1, coord2, 'b-','LineWidth',2);
        
        %%%%%%%%%%%%  calculate centerline  %%%%%%%%%%
        Length = length(OptimizedSplinePoints1);
        
        for i=1:1:Length
            Centerline(i,:) = (OptimizedSplinePoints1(i,:) + OptimizedSplinePoints2(i,:))/2;
        end
        
        % centerline ýn tamamýný çizer
        %plot(Centerline(:,1),Centerline(:,2),'r-','LineWidth',2);
        
        %%% Yötem-1
%         [~, Index1] = min(abs(Centerline - MiddlePointOnFirstTrace(1,1)));
%         [~, Index2] = min(abs(Centerline - MiddlePointOnSecondTrace(1,1)));
%         
%         LesionLengthArray = Centerline((Index1: Index2) , [1 2]);
%         plot(LesionLengthArray(:,1),LesionLengthArray(:,2),'r-','LineWidth',2);
%         LengthOfTheStenosis = CalculateLengthOfTheSpline(LesionLengthArray);


        %%% Yöntem-2
        [a,b] = size(Centerline);
        
        minDistance =  FindDistanceBetweenTwoPoints(MiddlePointOnFirstTrace, Centerline(1,:));
        for i=1:1:a
            distance = FindDistanceBetweenTwoPoints(MiddlePointOnFirstTrace, Centerline(i,:));
            if(distance < minDistance)
                minDistance = distance;
                LesionStartPoint = Centerline(i,:);
                LesionStartPointIndex = i;
            end
            
        end
        
        
        minDistance =  FindDistanceBetweenTwoPoints(MiddlePointOnSecondTrace, Centerline(1,:));
        for i=1:1:a
            distance = FindDistanceBetweenTwoPoints(MiddlePointOnSecondTrace, Centerline(i,:));
            if(distance < minDistance)
                minDistance = distance;
                LesionEndPoint = Centerline(i,:);
                LesionEndPointIndex = i;
            end
            
        end
        
        
        LesionLengthArray = Centerline((LesionStartPointIndex: LesionEndPointIndex) , [1 2]);
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        
        %PlotLineBetweenTwoPoints(MiddlePointOnFirstTrace, MiddlePointOnSecondTrace);
        
        plot(LesionLengthArray(:,1),LesionLengthArray(:,2),'r-','LineWidth',2);
        LengthOfTheStenosis = CalculateLengthOfTheSpline(LesionLengthArray);
        set (handles.StaticTextStenosisLength, 'string', LengthOfTheStenosis);
        
        
        
        
    end
else
    uiwait(msgbox('No STENOSIS is detected', 'WARNING', 'warn'));
    
    set (handles.StaticTextStenosisLength, 'string', '');
end




% --- Executes on button press in ButtonPlotTraceProfile.
function ButtonPlotTraceProfile_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonPlotTraceProfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


global LengthOfTraces;



LengthOfTheArray = length(LengthOfTraces);

yAxis = 1:1:LengthOfTheArray;

hold off;
axes(handles.AxesOutputImagePlot2);

plot(yAxis, LengthOfTraces);
axis([0 50 0 30]);
xlabel('x');
ylabel('D(x) [pixel]');
title('Diameter Length of the Vessel as a function of position(x) ');




%%%%%%%%%%%%%%%%%%  Plot the first derivateive of trace profile    %%%%%
FirtsDerivative = diff(LengthOfTraces);
LengthOfTheArray = length(FirtsDerivative);
yAxis = 1:1:LengthOfTheArray;

hold off;
axes(handles.AxesOutputImagePlot2);

plot(yAxis, FirtsDerivative);
%axis([0 50 0 30]);
xlabel('x');
ylabel('d(D(x))/dx [pixel/x]');
title('First Derivative Of D(x)');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes when ButtonGroupDynamicProgramming is resized.
function ButtonGroupDynamicProgramming_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to ButtonGroupDynamicProgramming (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ButtonSetAsFirstFrame.
function ButtonSetAsFirstFrame_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonSetAsFirstFrame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Counter;
global DicomImage;
global FirstFrameIndex;



FirstFrameIndex = Counter;
set(handles.StaticTextFirstFrameNo , 'string', FirstFrameIndex);

% axes(handles.AxesOutputImagePlot2);
% imshow(DicomImage(:,:,FirstFrameIndex));

% --- Executes on button press in ButtonSetAsLastFrame.
function ButtonSetAsLastFrame_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonSetAsLastFrame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Counter;
global DicomImage;
global LastFrameIndex;


LastFrameIndex = Counter;
set(handles.StaticTextLastFrameNo , 'string', LastFrameIndex);

% axes(handles.AxesOutputImagePlot2);
% imshow(DicomImage(:,:,LastFrameIndex));


% --- Executes on button press in ButtonSetROI.
function ButtonSetROI_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonSetROI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global FirstCoordinate;
global SecondCoordinate;
global ThirdCoordinate;
global FourthCoordinate;
global RoiExistsFlag;




uiwait(msgbox('Select the first coordinate', 'WARNING', 'warn'));
FirstCoordinate = ceil(ginput(1));

uiwait(msgbox('Select the second coordinate', 'WARNING', 'warn'));
FourthCoordinate = ceil(ginput(1));

SecondCoordinate = [FourthCoordinate(1,1) FirstCoordinate(1,2)];
ThirdCoordinate = [ FirstCoordinate(1,1) FourthCoordinate(1,2)];

RoiExistsFlag = 1;

hold on;
PlotROI( FirstCoordinate, SecondCoordinate, ThirdCoordinate, FourthCoordinate );
% 
% % plot from first coord to second
% x1 = FirstCoordinate(1,1);
% y1 = FirstCoordinate(1,2);
% x2 = SecondCoordinate(1,1);
% y2 = SecondCoordinate(1,2);
% 
% coord1 = [x1, x2];
% coord2 = [y1, y2];
% plot(coord1, coord2, 'b-','LineWidth',2);
% 
% 
% % plot from second coord to fourth
% x1 = SecondCoordinate(1,1);
% y1 = SecondCoordinate(1,2);
% x2 = FourthCoordinate(1,1);
% y2 = FourthCoordinate(1,2);
% 
% coord1 = [x1, x2];
% coord2 = [y1, y2];
% plot(coord1, coord2, 'b-','LineWidth',2);
% 
% 
% % plot from fourth coord to third
% x1 = FourthCoordinate(1,1);
% y1 = FourthCoordinate(1,2);
% x2 = ThirdCoordinate(1,1);
% y2 = ThirdCoordinate(1,2);
% 
% coord1 = [x1, x2];
% coord2 = [y1, y2];
% plot(coord1, coord2, 'b-','LineWidth',2);
% 
% 
% % plot from third coord to first
% x1 = ThirdCoordinate(1,1);
% y1 = ThirdCoordinate(1,2);
% x2 = FirstCoordinate(1,1);
% y2 = FirstCoordinate(1,2);
% 
% coord1 = [x1, x2];
% coord2 = [y1, y2];
% plot(coord1, coord2, 'b-','LineWidth',2);


% --- Executes on button press in ButtonResetROI.
function ButtonResetROI_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonResetROI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global DicomImage;
global Counter;
global FirstCoordinate;
global SecondCoordinate;
global ThirdCoordinate;
global FourthCoordinate;
global RoiExistsFlag;

FirstCoordinate = zeros(1,2);
SecondCoordinate = zeros(1,2);
ThirdCoordinate = zeros(1,2);
FourthCoordinate = zeros(1,2);

RoiExistsFlag = 0;

hold off;
imshow(DicomImage(:,:,Counter));


% --- Executes on button press in ButtonStart.
function ButtonStart_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global DicomImage;
% global LastFrameIndex;
% global FirstFrameIndex;
% global FirstCoordinate;
% global SecondCoordinate;
% global ThirdCoordinate;
% global FourthCoordinate;

global SplineArray;
global CroppedImages;
global TotalNumberOfIteration;
global TraceInfoCell;
global Masks;
global MaskedImages;

%%% ZEROIZE every data which stores critical info






  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%










%%%%%%%%%%%%%%%%%%%%%%%%    MAIN LOOP   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

AnisotropicDiffusedImages = cell(TotalNumberOfIteration,1);
CompositeEnergies = cell(TotalNumberOfIteration,1);
Masks = cell(TotalNumberOfIteration,1);
MaskedImages = cell(TotalNumberOfIteration,1);

%%%  anisotropic diff. parameters..
IterationNumber = 20;
r=0.25;

%%% gabor filter parameters    %%%
sigmaX = 1;
sigmaY = 1;
orientation = 3;



[c,d] = size(CroppedImages{1,1});


for k=1:1:TotalNumberOfIteration
    
    
    AnisotropicDiffusedImages{k,1}  = AnisotropicDiffusion( CroppedImages{k,1}, IterationNumber, r );
    

    
    
    gaborArray1 = GaborFilterBankmhrrm(orientation, sigmaX, sigmaY, 9, 9);
    
    
    %%%%%    ZERO MEAN GABOR FILTER     %%%%%%%%%
    gaborArray1 = zeroMean(gaborArray1);
    
    
    
    
    d1 = 2;
    d2 = 2;
    GaborFilteredImages = GaborFeatures( AnisotropicDiffusedImages{k,1},gaborArray1,d1,d2 );
    
    [m ,n] = size(GaborFilteredImages);
    
    AbsOfGaborFilteredImages = cell(m,n);
    for i = 1:m
        for j = 1:n
            
            AbsOfGaborFilteredImages{i,j} = abs(GaborFilteredImages{i,j});
        end
    end
    
    CompositeEnergies{k,1} = CalculateCompositeEnergy(AbsOfGaborFilteredImages);
    
    
    
    
    
    SplineNumber = 1;
    [ SplineArray(k).OptimizedControlPoints1, SplineArray(k).OptimizedSplinePoints1, IterationNumber1 ] = OptimizeGivenSplineHighComplexity(SplineArray(k).ControlPoints1, CompositeEnergies{k,1}, SplineNumber );
    
    SplineNumber = 2;
    [ SplineArray(k).OptimizedControlPoints2, SplineArray(k).OptimizedSplinePoints2, IterationNumber2 ] = OptimizeGivenSplineHighComplexity(SplineArray(k).ControlPoints2, CompositeEnergies{k,1}, SplineNumber );
    
    
    
    
    
    
    [ TraceInfoCell(k).TracePointsOnSmallerSpline, TraceInfoCell(k).TracePointsOnBiggerSpline, SmallerSpline, BiggerSpline] = Match2Splinesv2( SplineArray(k).OptimizedSplinePoints1, SplineArray(k).OptimizedSplinePoints2 );
    TraceInfoCell(k).ModifiedTracePointsOnBiggerSpline = SearchForShortestDiameterWithCorrection(SmallerSpline, BiggerSpline, TraceInfoCell(k).TracePointsOnSmallerSpline,TraceInfoCell(k).TracePointsOnBiggerSpline );
    
    %%%%% now find the lengths of each trace to detect stenotic region.
    LengthOfTraces = zeros(length(TraceInfoCell(k).TracePointsOnSmallerSpline),1);
    for i=1:1:length(TraceInfoCell(k).TracePointsOnSmallerSpline)
        LengthOfTraces(i) = sqrt((TraceInfoCell(k).TracePointsOnSmallerSpline(i,1) - TraceInfoCell(k).ModifiedTracePointsOnBiggerSpline(i,1))^2 +...
            (TraceInfoCell(k).TracePointsOnSmallerSpline(i,2) - TraceInfoCell(k).ModifiedTracePointsOnBiggerSpline(i,2))^2);
        
    end
    
    TraceInfoCell(k).LengthOfTraces = LengthOfTraces;
    
    
    
    Masks{k,1} = ConstructMaskOfROI(SplineArray(k).OptimizedSplinePoints1, SplineArray(k).OptimizedSplinePoints2, c,d);
    Masks{k,1} = cast(Masks{k,1}, class(CroppedImages{k,1}));
    
    MaskedImages{k,1} = Masks{k,1} .* CroppedImages{k,1};
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[x,y] = size(MaskedImages{k,1});


% --- Executes on button press in ButtonInitializeSplines.
function ButtonInitializeSplines_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonInitializeSplines (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DicomImage;
global LastFrameIndex;
global FirstFrameIndex;
global FirstCoordinate;
global SecondCoordinate;
global ThirdCoordinate;
global FourthCoordinate;

global SplineArray;
global CroppedImages;
global TotalNumberOfIteration;



%%%%%%%%  All splines are initialized here....  %%%%%%%%%%%%%%

NoOfControlPts = 6;

TotalNumberOfIteration = LastFrameIndex - FirstFrameIndex + 1;
%%% width and height of the ROI, they will be used for CROPPING
Width = SecondCoordinate(1,1)- FirstCoordinate(1,1);
Height = ThirdCoordinate(1,2)- FirstCoordinate(1,2);

CroppedImages = cell(TotalNumberOfIteration,1);


DicomImageIndex = FirstFrameIndex;

uiwait(msgbox(sprintf('Now, Initialize %2d pair of Spline',TotalNumberOfIteration ), 'WARNING', 'warn'));
for i=1:1:TotalNumberOfIteration
    
    % CROP the image according to ROI
    
    CroppedImages{i,1} = imcrop(DicomImage(:,:,DicomImageIndex), [FirstCoordinate(1,1), FirstCoordinate(1,2),Width, Height]);

    hold off;
    imshow(CroppedImages{i,1});
    
    uiwait(msgbox('Initialize the first SPLINE', 'WARNING', 'warn'));
    [SplineArray(i).ControlPoints1, SplineArray(i).SplinePoints1] = spline(NoOfControlPts,3);
    
    uiwait(msgbox('Initialize the second SPLINE', 'WARNING', 'warn'));
    [SplineArray(i).ControlPoints2, SplineArray(i).SplinePoints2] = spline(NoOfControlPts,3);
    
    
    DicomImageIndex = DicomImageIndex + 1;
    

    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes on button press in ButtonPlot.
function ButtonPlot_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global SplineArray;
global CroppedImages;
global TotalNumberOfIteration;
global TraceInfoCell;


%axes(handles.AxesOutputImagePlot2);
% 
% for i=1:1:TotalNumberOfIteration
%     
%     % Spline ýn ilk hali
%     hold off;
%     imshow(CroppedImages{i,1});
%     hold on;
%     plot(SplineArray(i).ControlPoints1(:,1),SplineArray(i).ControlPoints1(:,2),'ro','MarkerSize',3,'MarkerFaceColor','r');
%     plot(SplineArray(i).SplinePoints1(:,1),SplineArray(i).SplinePoints1(:,2),'b-','LineWidth',1);
%     
%     plot(SplineArray(i).ControlPoints2(:,1),SplineArray(i).ControlPoints2(:,2),'ro','MarkerSize',3,'MarkerFaceColor','r');
%     plot(SplineArray(i).SplinePoints2(:,1),SplineArray(i).SplinePoints2(:,2),'b-','LineWidth',1);
%     
%     
%     
%     % spline ýn opitimized hali
%     hold off;
%     imshow(CroppedImages{i,1});
%     hold on;
%     plot(SplineArray(i).OptimizedControlPoints1(:,1),SplineArray(i).OptimizedControlPoints1(:,2),'ro','MarkerSize',3,'MarkerFaceColor','r');
%     plot(SplineArray(i).OptimizedSplinePoints1(:,1),SplineArray(i).OptimizedSplinePoints1(:,2),'b-','LineWidth',1);
%     
%     plot(SplineArray(i).OptimizedControlPoints2(:,1),SplineArray(i).OptimizedControlPoints2(:,2),'ro','MarkerSize',3,'MarkerFaceColor','r');
%     plot(SplineArray(i).OptimizedSplinePoints2(:,1),SplineArray(i).OptimizedSplinePoints2(:,2),'b-','LineWidth',1);
%     
%     % plot traces
%     [a,b] = size(TraceInfoCell(i).TracePointsOnSmallerSpline);
%     
%     for j=1:1:a
%         
%         x1 = TraceInfoCell(i).TracePointsOnSmallerSpline(j,1);
%         y1 = TraceInfoCell(i).TracePointsOnSmallerSpline(j,2);
%         x2 = TraceInfoCell(i).ModifiedTracePointsOnBiggerSpline(j,1);
%         y2 = TraceInfoCell(i).ModifiedTracePointsOnBiggerSpline(j,2);
%         
%         
%         coord1 = [x1, x2];
%         coord2 = [y1, y2];
%         plot(coord1, coord2, 'b-','LineWidth',2);
%     end
%     
% end



% XpointsOfROI = [SplineArray(3).OptimizedControlPoints1(1,1) ...
%     SplineArray(3).OptimizedControlPoints1(a,1)...
%     SplineArray(3).OptimizedControlPoints2(a,1)...
%     SplineArray(3).OptimizedControlPoints2(1,1)...
%     SplineArray(3).OptimizedControlPoints1(1,1)];

% 
% YpointsOfROI = [SplineArray(3).OptimizedControlPoints1(1,2) ...
%     SplineArray(3).OptimizedControlPoints1(a,2)...
%     SplineArray(3).OptimizedControlPoints2(a,2)...
%     SplineArray(3).OptimizedControlPoints2(1,2)...
%     SplineArray(3).OptimizedControlPoints1(1,2)];

Masks = cell(TotalNumberOfIteration,1);
MaskedImages = cell(TotalNumberOfIteration,1);
for k=1:1:TotalNumberOfIteration
    
    %%%%%%%%%%%%%%%%%%%%%  POLYGON CONSTRUCTION USING CONTROL POINTS   %%%%%%%%%%
    %%% construction of the polygon...
    % [a,b] = size(SplineArray(3).OptimizedControlPoints1);
    % [c,d] = size(CroppedImages{1,1});
    %
    % XpointsOfROI = zeros(2*a + 1, 1);
    %
    % % take the x coordinates of the first spline
    % for i=1:1:a
    %     XpointsOfROI(i,1) = SplineArray(3).OptimizedControlPoints1(i,1);
    % end
    %
    % % flip the order of the second spline
    % FlippedCP = flipud(SplineArray(3).OptimizedControlPoints2(:,1));
    %
    % % take the x coordinates of the second spline to construct a polygon
    % for i=1:1:a
    %     XpointsOfROI(i+a,1) = FlippedCP(i,1);
    % end
    %
    % % equate the first element to last element to construct a closed polygon
    % XpointsOfROI((2*a + 1), 1) = XpointsOfROI(1,1);
    %
    %
    %
    %
    % YpointsOfROI = zeros(2*a + 1, 1);
    % % take the y coordinates of the first spline
    % for i=1:1:a
    %     YpointsOfROI(i,1) = SplineArray(3).OptimizedControlPoints1(i,2);
    % end
    %
    % % flip the order of the second spline
    % temp = SplineArray(3).OptimizedControlPoints2(:,2);
    % FlippedCP = flipud(temp);
    % % take the y coordinates of the second spline to construct a polygon
    % for i=1:1:a
    %     YpointsOfROI(i+a,1) = FlippedCP(i,1);
    % end
    %
    % % equate the first element to last element to construct a closed polygon
    % YpointsOfROI((2*a + 1), 1) = YpointsOfROI(1,1);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    
    
    
    %%%%%%%%%%%%%%%%%%%%%  POLYGON CONSTRUCTION USING SPLINE POINTS   %%%%%%%%%%
    %%% construction of the polygon...
    
    [a,b] = size(SplineArray(3).OptimizedSplinePoints1);
    [c,d] = size(CroppedImages{1,1});
    
    Polygon(k).XpointsOfROI = zeros(2*a + 1, 1);
    
    % take the x coordinates of the first spline
    for i=1:1:a
        Polygon(k).XpointsOfROI(i,1) = SplineArray(k).OptimizedSplinePoints1(i,1);
    end
    
    % flip the order of the second spline
    FlippedCP_X = flipud(SplineArray(k).OptimizedSplinePoints2(:,1));
    
    % take the x coordinates of the second spline to construct a polygon
    for i=1:1:a
        Polygon(k).XpointsOfROI(i+a,1) = FlippedCP_X(i,1);
    end
    
    % equate the first element to last element to construct a closed polygon
    Polygon(k).XpointsOfROI((2*a + 1), 1) = Polygon(k).XpointsOfROI(1,1);
    
    
    
    
    Polygon(k).YpointsOfROI = zeros(2*a + 1, 1);
    % take the y coordinates of the first spline
    for i=1:1:a
        Polygon(k).YpointsOfROI(i,1) = SplineArray(k).OptimizedSplinePoints1(i,2);
    end
    
    % flip the order of the second spline
    FlippedCP_Y = flipud(SplineArray(k).OptimizedSplinePoints2(:,2));
    % take the y coordinates of the second spline to construct a polygon
    for i=1:1:a
        Polygon(k).YpointsOfROI(i+a,1) = FlippedCP_Y(i,1);
    end
    
    % equate the first element to last element to construct a closed polygon
    Polygon(k).YpointsOfROI((2*a + 1), 1) = Polygon(k).YpointsOfROI(1,1);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    
    
    Masks{k,1} = poly2mask(Polygon(k).XpointsOfROI, Polygon(k).YpointsOfROI,c, d);
    
    %TempMask = ConstructMaskOfROI(SplineArray(k).OptimizedSplinePoints1, SplineArray(k).OptimizedSplinePoints2, c,d);
    Masks{k,1} = cast(Masks{k,1}, class(CroppedImages{k,1}));
    %Mask = uint8(Mask);
    hold off;
    imagesc(Masks{k,1});
    
    MaskedImages{k,1} = Masks{k,1} .* CroppedImages{k,1};
    imshow(MaskedImages{k,1});
end


% --- Executes on button press in ButtonRegistration.
function ButtonRegistration_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonRegistration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global DicomImage;


% ropen and rclose are the radius of structuring element used in
% morphological operation. Registered 2 frame farkýný bulurken
% kullanýlýyor.
ropen = 3;
rclose = 3;

firstRansacIterNumber = 20;
ransacIterNumber = 10;

% im1 = DicomImage(:,:,33);
% im2 = DicomImage(:,:,34);

%im1 = imread('an. diff. 20 iter..jpg');
%im1 = imread('araba.jpg');
% im1 = imread('KEZBAN ESIM-IMG29-41_cropped-1.jpg');
% im2 = imread('KEZBAN ESIM-IMG29-42_cropped-2.jpg');
im1 = imread('SERIFE ARSLAN-IMG44-31.jpg');
im2 = imread('SERIFE ARSLAN-IMG44-32.jpg');
% im1 = imread('KEZBAN ESIM-IMG29-30.jpg');
% im2 = imread('KEZBAN ESIM-IMG29-31.jpg');
% % im1 = imread('a_utku-1.2.bmp');
% im2 = imread('a_utku-2.2.bmp');


% im1 = rgb2gray(im1);
% im2 = rgb2gray(im2);




% 
% % [-4, 4] sýnýrýna takýlmamak için ve kenardan korner bilgisi gelmemesi
% % için CROPPED image da korner aranacak ve köþeden korner gelmeyeceði
% % garanti edileck
% 
% [NumberOfRows, NumberOfColumns] = size(im1);
% Width = NumberOfColumns -9;
% Height = NumberOfRows - 9;
% CroppedIm1 = imcrop(im1, [5, 5,Width, Height]);
% CroppedIm2 = imcrop(im2, [5, 5,Width, Height]);
% 
% 
% C1 = corner(CroppedIm1, 'SensitivityFactor', 0.005);
% C2 = corner(CroppedIm2, 'SensitivityFactor', 0.005);
% %%% display corners  %%%%%%
% hold off;
% imshow(im1);
% hold on;
% C1(:,1) = C1(:,1) + 4;      %% cropped image dan gerçek image daki koordinatlara dönüþtürülür.
% C1(:,2) = C1(:,2) + 4;
% plot((C1(:,1)),(C1(:,2)),'ro','MarkerSize',2,'MarkerFaceColor','r');
% 
% hold off;
% imshow(im2);
% hold on;
% C2(:,1) = C2(:,1) + 4;      %% cropped image dan gerçek image daki koordinatlara dönüþtürülür.
% C2(:,2) = C2(:,2) + 4;
% plot((C2(:,1)),(C2(:,2)),'ro','MarkerSize',2,'MarkerFaceColor','r')
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% C1 = POIyeMeanVeSigmaEkle(C1, im1);
% C2 = POIyeMeanVeSigmaEkle(C2, im2);
% 
% [MatchedPOIlerDzs] = BulMatchedPOIlerMhrrm(im1, im2, C1, C2);
% 
% 
% %%% display matched corners  %%%%%%
% hold off;
% imshow(im1);
% hold on;
% plot(MatchedPOIlerDzs(:,1),MatchedPOIlerDzs(:,2),'ro','MarkerSize',2,'MarkerFaceColor','r');
% 
% 
% hold off;
% imshow(im2);
% hold on;
% plot(MatchedPOIlerDzs(:,3),MatchedPOIlerDzs(:,4),'ro','MarkerSize',2,'MarkerFaceColor','r');
% %%%%%%%%%%%%%%%%%%%%%










%%%%%%%%%%%%%%%%%%%%%%%%%    UTKU nun kodu     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


warpingBasariliMi = 0;

% mhrrm: Videodan frame alýnmýþ, bizim buna ihtiyacýmýz yok.
% % deinterlace
%  im1(:,:,:) = imaj1(1:2:end,:,:);
%  im2(:,:,:) = imaj2(1:2:end,:,:);
 

 
imTestRgb1= im1;
imTestRgb2= im2; 

% burada adi gaussian ve median filtreleme olmalý
imgauss1=YapGaussianFiltreleme(im1);
imgauss2=YapGaussianFiltreleme(im2);

axes(handles.AxesOutputImagePlot2);
% imshow(im1);
% imshow(imgauss1);

[poi1] = BulUniformHarrisCorners(imgauss1, imTestRgb1);
[poi2] = BulUniformHarrisCorners(imgauss2, imTestRgb2);



%%%%%%%%%%%%%%  modification region   %%%%%%%%%%%%%%%%%
% CroppedImage1 = CropImage(im1);
% CroppedImage2 = CropImage(im2);
% 
% poi1 = corner(CroppedImage1,300,  'SensitivityFactor', 0.002);
% poi2 = corner(CroppedImage2,300,  'SensitivityFactor', 0.002);
% 
% poi1(:,1) = poi1(:,1) + 4;      %% cropped image dan gerçek image daki koordinatlara dönüþtürülür.
% poi1(:,2) = poi1(:,2) + 4;
% poi2(:,1) = poi2(:,1) + 4;      %% cropped image dan gerçek image daki koordinatlara dönüþtürülür.
% poi2(:,2) = poi2(:,2) + 4;
% 
% poi1 = POIyeMeanVeSigmaEkle(poi1, im1);
% poi2 = POIyeMeanVeSigmaEkle(poi2, im2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%% display corners  %%%%%%
hold off;
imshow(im1);
hold on;
plot(poi1(:,2),poi1(:,1),'ro','MarkerSize',2,'MarkerFaceColor','r');


hold off;
imshow(im2);
hold on;
plot(poi2(:,2),poi2(:,1),'ro','MarkerSize',2,'MarkerFaceColor','r');
%%%%%%%%%%%%%%%%%%%%%


[MatchedPOIlerDzs] = BulMatchedPOIler(imgauss1, imgauss2, poi1, poi2);
%[MatchedPOIlerDzs] = BulMatchedPOIlerMhrrm(imgauss1, imgauss2, poi1, poi2);


%%% display matched corners  %%%%%%
hold off;
imshow(im1);
hold on;
plot(MatchedPOIlerDzs(:,2),MatchedPOIlerDzs(:,1),'ro','MarkerSize',2,'MarkerFaceColor','r');


hold off;
imshow(im2);
hold on;
plot(MatchedPOIlerDzs(:,4),MatchedPOIlerDzs(:,3),'ro','MarkerSize',2,'MarkerFaceColor','r');
%%%%%%%%%%%%%%%%%%%%%






% bu fonksiyon RANSAC uygulayarak filtreleme yapar.
FiltrelenmisMatchedPOIlerDzs = BulRansaclaFiltrelenmisMatchedPOIler(MatchedPOIlerDzs,firstRansacIterNumber);


%[HareketsizMatchedPOIlerDzs, warpingBasariliMi] = YapRansacPoiElemesi(FiltrelenmisMatchedPOIlerDzs, ransacIterNumber);


% bu fonksiyon 8 tane den H hesaplar.
[HareketsizMatchedPOIlerDzs, warpingBasariliMi] = YapRansacPoiElemesi(MatchedPOIlerDzs, ransacIterNumber);

%%% display not moving corners  %%%%%%
hold off;
imshow(im1);
hold on;
plot(HareketsizMatchedPOIlerDzs(:,2),HareketsizMatchedPOIlerDzs(:,1),'ro','MarkerSize',2,'MarkerFaceColor','r');

hold off;
imshow(im2);
hold on;
plot(HareketsizMatchedPOIlerDzs(:,4),HareketsizMatchedPOIlerDzs(:,3),'ro','MarkerSize',2,'MarkerFaceColor','r');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%  burada adi ransacli iki framide goster olmalý
%  GosterRansacUygulanmisIkinciFramedekiPOIler(HareketsizMatchedPOIlerDzs,imgauss1, imgauss2, imTestRgb1);

[positiveImage, negativeImage, H, RegisteredImage] = BulRegisteredIkiFrameFarki(HareketsizMatchedPOIlerDzs, imgauss1, imgauss2, ropen, rclose, warpingBasariliMi); 

hold off;
imshow(RegisteredImage);
hold off;
imshow(im1);
% hold off;
% Subtraction = double(im1) - RegisteredImage;
% imshow(Subtraction);

hold off;
% imshow(positiveImage);
imagesc(positiveImage);
hold off;
% imshow(negativeImage);
imagesc(negativeImage);


%IsleMotionChannel(motionChannel);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes on button press in ButtonMetrics.
function ButtonMetrics_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonMetrics (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global SplinePoints1;
global SplinePoints2;

global Image;
global ControlPointsOfGroundTruth1;
global ControlPointsOfGroundTruth2;
global SplinePointsOfGroundTruth1;
global SplinePointsOfGroundTruth2;

global OptimizedControlPoints1;
global OptimizedSplinePoints1;
global OptimizedControlPoints2;
global OptimizedSplinePoints2;

% SplinePoints1InPixels = ConvertSpline2Pixels(SplinePoints1);
% SplinePoints2InPixels = ConvertSpline2Pixels(SplinePoints2);
SplinePointsOfGroundTruth1InPixels = ConvertSpline2Pixels(SplinePointsOfGroundTruth1);
SplinePointsOfGroundTruth2InPixels = ConvertSpline2Pixels(SplinePointsOfGroundTruth2);
OptimizedSplinePoints1InPixels = ConvertSpline2Pixels(OptimizedSplinePoints1);
OptimizedSplinePoints2InPixels = ConvertSpline2Pixels(OptimizedSplinePoints2);



[N_I, N_GT, TP, FP, FN,P_co, P_nd,  P_fa, IMP, L2DistanceIn4DmetricSpace ]  = EvaluatePerformance(OptimizedSplinePoints1InPixels,SplinePointsOfGroundTruth1InPixels );
[N_I, N_GT, TP, FP, FN,P_co, P_nd,  P_fa, IMP, L2DistanceIn4DmetricSpace ]  = EvaluatePerformance(OptimizedSplinePoints2InPixels,SplinePointsOfGroundTruth2InPixels );






axes(handles.AxesOutputImagePlot2);

hold off;
imshow(Image);
hold on;
plot(OptimizedSplinePoints1(:,1),OptimizedSplinePoints1(:,2),'b-','LineWidth',1);
plot(OptimizedSplinePoints2(:,1),OptimizedSplinePoints2(:,2),'b-','LineWidth',1);

hold off;
imshow(Image);
hold on;
plot(OptimizedSplinePoints1InPixels(:,1),OptimizedSplinePoints1InPixels(:,2),'b-','LineWidth',2);
plot(OptimizedSplinePoints2InPixels(:,1),OptimizedSplinePoints2InPixels(:,2),'b-','LineWidth',2);

hold off;
imshow(Image);
hold on;
plot(SplinePointsOfGroundTruth1(:,1),SplinePointsOfGroundTruth1(:,2),'b-','LineWidth',2);
plot(SplinePointsOfGroundTruth2(:,1),SplinePointsOfGroundTruth2(:,2),'b-','LineWidth',2);


hold off;
imshow(Image);
hold on;
plot(SplinePointsOfGroundTruth1InPixels(:,1),SplinePointsOfGroundTruth1InPixels(:,2),'b-','LineWidth',2);
plot(SplinePointsOfGroundTruth2InPixels(:,1),SplinePointsOfGroundTruth2InPixels(:,2),'b-','LineWidth',2);




% --- Executes on button press in ButtonGroundTruth.
function ButtonGroundTruth_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonGroundTruth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global ControlPointsOfGroundTruth1;
global ControlPointsOfGroundTruth2;
global SplinePointsOfGroundTruth1;
global SplinePointsOfGroundTruth2;

global ControlPoints1;
global ControlPoints2;
global SplinePoints1;
global SplinePoints2;

global Image;

NoOfControlPts = str2double(get(handles.EditNoOfControlPts, 'String'));


%%%  GROUND TRUTH IMAGE    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hold off;
% CLAHEimage = adapthisteq(Image);
% imshow(CLAHEimage);
% 
% uiwait(msgbox('Initialize the GROUND TRUTH first SPLINE', 'WARNING', 'warn'));
% [ControlPointsOfGroundTruth1, SplinePointsOfGroundTruth1] = spline(NoOfControlPts,3);
% 
% uiwait(msgbox('Initialize the GROUND TRUTH second SPLINE', 'WARNING', 'warn'));
% [ControlPointsOfGroundTruth2, SplinePointsOfGroundTruth2] = spline(NoOfControlPts,3);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%    GROUND TRUTH yükleme ve kaydetme alaný     %%%%%%%%%%%%%%%%%%%%%%%
%%% deneylerde kullanýlan ground truth data kaydedildi, yükleyip
%%% kullanabilirsin...global data lara eþitleyerek kullan..

% GroundTruthSpline1 = load('synthetic_image_6_spline1.mat');
% GroundTruthSpline2 = load('synthetic image-6_spline2.mat');
% 
% SplinePointsOfGroundTruth1 = GroundTruthSpline1.SplinePointsOfGroundTruth1;
% SplinePointsOfGroundTruth2 = GroundTruthSpline2.SplinePointsOfGroundTruth2;
% 
save('Muhsin_Ipek_proximal_CD2_IMG44_Frame20_spline1.mat','SplinePointsOfGroundTruth1' );
save('Muhsin_Ipek_proximal_CD2_IMG44_Frame20_spline2.mat','SplinePointsOfGroundTruth2');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%% SHOW Initial Spline   %%%%
% CLAHEimage = adapthisteq(Image);
% axes(handles.AxesOutputImagePlot2);
% hold off;
% imshow(CLAHEimage);
% 
% hold on;
% % plot(ControlPoints1(:,1),ControlPoints1(:,2),'ro','MarkerSize',3,'MarkerFaceColor','r');
% plot(SplinePoints1(:,1),SplinePoints1(:,2),'b-','LineWidth',1);
% 
% % plot(ControlPoints2(:,1),ControlPoints2(:,2),'ro','MarkerSize',3,'MarkerFaceColor','r');
% plot(SplinePoints2(:,1),SplinePoints2(:,2),'b-','LineWidth',1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%  SHOW GROUND TRUTH SPLINE
hold off;
imshow(Image);

hold on;

plot(SplinePointsOfGroundTruth1(:,1),SplinePointsOfGroundTruth1(:,2),'b-','LineWidth',1);

plot(SplinePointsOfGroundTruth2(:,1),SplinePointsOfGroundTruth2(:,2),'b-','LineWidth',1);

%%%%%%%%%%%%%%%%%%%%%%%





%AnisotropicDiffusedCLAHE = AnisotropicDiffusion(CLAHEimage, 30, 0.2);







% --- Executes on button press in ButtonTraceDensity.
function ButtonTraceDensity_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonTraceDensity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Image;
global OptimizedSplinePoints1;
global OptimizedControlPoints1;
global OptimizedSplinePoints2;
global OptimizedControlPoints2;

global TracePointsOnSmallerSpline;
global TracePointsOnBiggerSpline;
global ModifiedTracePointsOnBiggerSpline;

global Centerline;
global CenterlineInPixels;

CenterlineInPixels_Rounded = round(CenterlineInPixels); % round edildiðinde, tekrar eden pixeller çýkarýlmalý.

ImageInDouble = im2double(Image);
LengthOfTraceArray = length(TracePointsOnSmallerSpline);
TraceDensityCell = cell(LengthOfTraceArray,1);
SumOfTraceDensities = zeros(LengthOfTraceArray,1);

for i=1:1:LengthOfTraceArray
    TraceDensityCell{i,1} = FindPixelLocationsBetweenTwoPoints(TracePointsOnSmallerSpline(i,:), ModifiedTracePointsOnBiggerSpline(i,:));
end

for i=1:1:LengthOfTraceArray
    Sum = 0;
    CurrentTrace = cell2mat(TraceDensityCell(i,1));
    LengthOfTheTrace = length(CurrentTrace);
    for j=1:1:LengthOfTheTrace
        Sum = Sum + ImageInDouble(CurrentTrace(j,1), CurrentTrace(j,2));
        
    end
    
    %SumOfTraceDensities(i)=Sum;
    %%% þimdi trace'in baþlangýçtan itibaren uzaklýðý hesaplanacak
    
    [intersectionPixel, IndexInTheTrace, IndexInTheCenterline]=intersect(CurrentTrace, CenterlineInPixels_Rounded, 'rows');
    
    if(isempty(intersectionPixel)) %eðer "intersect" komutu kesiþim bulamadýysa sen bul!!
        
       [intersectionPixel, IndexInTheCenterline] = FindIntersectionPixel(CurrentTrace, CenterlineInPixels_Rounded);
    end
        
        
    
    TraceDistanceFromTheStart = 0;
    for k=1:1:(IndexInTheCenterline-1)
        TempDistance = FindDistanceBetweenTwoPoints( CenterlineInPixels_Rounded(k,:), CenterlineInPixels_Rounded(k+1, :) );
        TraceDistanceFromTheStart = TraceDistanceFromTheStart + TempDistance;
    end
    
    
    TraceInfo(i).SumOfTraceDensity = Sum;
    TraceInfo(i).TraceDistance = TraceDistanceFromTheStart; % distance is in pixel length, it must be converted to mm
    
end

x = Sum;



function EditImageA_Callback(hObject, eventdata, handles)
% hObject    handle to EditImageA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditImageA as text
%        str2double(get(hObject,'String')) returns contents of EditImageA as a double


% --- Executes during object creation, after setting all properties.
function EditImageA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditImageA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ButtonDSA.
function ButtonDSA_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonDSA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Counter;
global DicomImage;
global FirstFrameIndex;

IndexOfImageA= str2double(get(handles.EditImageA, 'String'));
IndexOfImageB= str2double(get(handles.EditImageB, 'String'));

ImageA = DicomImage(:,:,IndexOfImageA);
ImageB = DicomImage(:,:,IndexOfImageB);

% hold off;
% imagesc(ImageA);
% imshow(ImageA);
% imshow(ImageB);

%SubtractedImage = ImageA - ImageB;
% SubtractedImage = imsubtract(ImageA, ImageB);
AbsSubtraction = imabsdiff(ImageA, ImageB);

ClassOfImage = class(AbsSubtraction);
if(strcmp(ClassOfImage, 'uint8'))
    imshow(AbsSubtraction);
else
    
    imagesc(AbsSubtraction);
end

LogOfA = log10(double(ImageA));
LogOfB = log10(double(ImageB));

SubtractionOfLogImages = LogOfA - LogOfB;
AbsDiffOfLogImages = imabsdiff(LogOfA, LogOfB);

imagesc(AbsDiffOfLogImages);

imagesc(LogOfA);
imagesc(SubtractionOfLogImages);

%ThresholdLevel = graythresh(AbsSubtraction);
% BinaryImage = im2bw(AbsSubtraction, 0.001);
% 
% imshow(BinaryImage);



%%% display the complement of the DSA image.
% ComplementImage = imcomplement(AbsSubtraction);
% ClassOfImage = class(ComplementImage);
% if(strcmp(ClassOfImage, 'uint8'))
%     imshow(ComplementImage);
% else
%     
%     imagesc(ComplementImage);
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function EditImageB_Callback(hObject, eventdata, handles)
% hObject    handle to EditImageB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditImageB as text
%        str2double(get(hObject,'String')) returns contents of EditImageB as a double


% --- Executes during object creation, after setting all properties.
function EditImageB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditImageB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ButtonSetROIdicom.
function ButtonSetROIdicom_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonSetROIdicom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global FirstCoordinate;
global SecondCoordinate;
global ThirdCoordinate;
global FourthCoordinate;
global RoiExistsFlag;
global Counter;
global DicomImage;


hold off;
ClassOfImage = class(DicomImage(:,:,Counter));
if(strcmp(ClassOfImage, 'uint8'))
    imshow(DicomImage(:,:,Counter));
else
    
    imagesc(DicomImage(:,:,Counter));
end




%uiwait(msgbox('Select the first coordinate', 'WARNING', 'warn'));
FirstCoordinate = ceil(ginput(1));
hold on;
plot(FirstCoordinate(:,1),FirstCoordinate(:,2),'ro','MarkerSize',3,'MarkerFaceColor','r');

%uiwait(msgbox('Select the second coordinate', 'WARNING', 'warn'));
FourthCoordinate = ceil(ginput(1));
hold on;
plot(FourthCoordinate(:,1),FourthCoordinate(:,2),'ro','MarkerSize',3,'MarkerFaceColor','r');

SecondCoordinate = [FourthCoordinate(1,1) FirstCoordinate(1,2)];
ThirdCoordinate = [ FirstCoordinate(1,1) FourthCoordinate(1,2)];

RoiExistsFlag = 1;

hold on;
PlotROI( FirstCoordinate, SecondCoordinate, ThirdCoordinate, FourthCoordinate );


% --- Executes on button press in ButtonCropAndGlobalize.
function ButtonCropAndGlobalize_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonCropAndGlobalize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global FirstCoordinate;
global SecondCoordinate;
global ThirdCoordinate;
global FourthCoordinate;
global RoiExistsFlag;

global DicomImage;
global Image;
global Counter;

%%% width and height of the ROI, they will be used for CROPPING
Width = SecondCoordinate(1,1)- FirstCoordinate(1,1);
Height = ThirdCoordinate(1,2)- FirstCoordinate(1,2);

% CROP the image according to ROI

CroppedImage = imcrop(DicomImage(:,:,Counter), [FirstCoordinate(1,1), FirstCoordinate(1,2),Width, Height]);

hold off;
ClassOfImage = class(CroppedImage);
if(strcmp(ClassOfImage, 'uint8'))
    imshow(CroppedImage);
else
    
    imagesc(CroppedImage);
end



%%%% globalize the cropped image
Image = CroppedImage;


% --- Executes on button press in ButtonAutoSplineInit.
function ButtonAutoSplineInit_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonAutoSplineInit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


global Image;
global CLAHEimage;
global ControlPoints1;
global SplinePoints1;
global ControlPoints2;
global SplinePoints2;

global OptimizedSplinePoints1;
global OptimizedControlPoints1;
global OptimizedSplinePoints2;
global OptimizedControlPoints2;

global SplinePointsOfGroundTruth1;
global SplinePointsOfGroundTruth2;

global CompositeEnergy;

NoOfPts = str2double(get(handles.EditNoOfControlPts, 'String'));


hold off;
imshow(Image);
uiwait(msgbox('Select the points', 'WARNING', 'warn'));

%%% GROUND TRUTH IMAGE referans olarak görsellenir...
% hold on;
% plot(SplinePointsOfGroundTruth1(:,1),SplinePointsOfGroundTruth1(:,2),'b-','LineWidth',2);
% plot(SplinePointsOfGroundTruth2(:,1),SplinePointsOfGroundTruth2(:,2),'b-','LineWidth',2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:1:NoOfPts
    
    ReferencePoints(i,:) = ceil(ginput(1));
    hold on;
    plot(ReferencePoints(i,1),ReferencePoints(i,2),'ro','MarkerSize',3,'MarkerFaceColor','r');
end


% uiwait(msgbox('Select the first point', 'WARNING', 'warn'));
% FirstPoint = ceil(ginput(1));
% 
% uiwait(msgbox('Select the second point', 'WARNING', 'warn'));
% SecondPoint = ceil(ginput(1));




StepSize = 6;  %%% merkez noktasýndan saða ve sola ne kadar(pixel) gidileciðini gösterir.
StepResolution = 0.1;   % damarýn ortasýndaki noktadan saða ve sola kaç pixellik adimlarla gidileceðini gösterir
NumberOfControlPoints = 4; % spline ýn kaç kontrol noktasýndan oluþacaðýný gösterir


%%%%%%%%%%%%%%%%%%%%%%%%%    ESKÝ YÖNTEM        %%%%%%%%%%%%%%%%%%%
% for i=1:1:(NoOfPts-1)
%     [ RightSplineControlPoints, LeftSplineControlPoints, XYnoktaCiftleri, XmesafesiBuyuk, YmesafesiBuyuk  ] = AutoSplineInitGiven2Points( ReferencePoints(i,:), ReferencePoints(i+1,:), CompositeEnergy, StepSize, StepResolution, NumberOfControlPoints );
%     % ÖNCEKÝ SFERDE X büyük, sonrakinde Y büyükse; ya da tam tersi -> Gelen
%     % sað sol spline verileri yer deðiþtirilmeli.
%     MesafeBuyuklukDizisi(i) = XmesafesiBuyuk;
%     
%     % COncatanate control points found...
%     if (i==1) % ilk seferde initialize et, sonraki seferlerde ise concatanate
%         FinalRightSplineControlPoints =  RightSplineControlPoints;
%         FinalLeftSplineControlPoints = LeftSplineControlPoints;
%         FinalXYnoktaCiftleri = XYnoktaCiftleri;
%     else
%         
%         if (MesafeBuyuklukDizisi(i) == MesafeBuyuklukDizisi(i-1))
%             FinalRightSplineControlPoints = [FinalRightSplineControlPoints ; RightSplineControlPoints];
%             FinalLeftSplineControlPoints = [FinalLeftSplineControlPoints ; LeftSplineControlPoints];
%             FinalXYnoktaCiftleri = [FinalXYnoktaCiftleri ; XYnoktaCiftleri];
%         else % swap right and left spline
%             FinalRightSplineControlPoints = [FinalRightSplineControlPoints ; LeftSplineControlPoints];
%             FinalLeftSplineControlPoints = [FinalLeftSplineControlPoints ; RightSplineControlPoints];
%             FinalXYnoktaCiftleri = [FinalXYnoktaCiftleri ; XYnoktaCiftleri];
%         end
%         
%     end
%     
% end


%[ RightSplineControlPoints, LeftSplineControlPoints, XYnoktaCiftleri ] = AutoSplineInitGiven2Points( FirstPoint, SecondPoint, CompositeEnergy, StepSize, NumberOfControlPoints );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%   YENÝ YÖNTEM    %%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:1:(NoOfPts-1)
    [ RightSplineControlPoints, LeftSplineControlPoints, XYnoktaCiftleri ] = AutoSplineInitGiven2Points_v2( ReferencePoints(i,:), ReferencePoints(i+1,:), CompositeEnergy, StepSize, StepResolution, NumberOfControlPoints );
    
    
    % COncatanate control points found...
    if (i==1) % ilk seferde initialize et, sonraki seferlerde ise concatanate
        FinalRightSplineControlPoints =  RightSplineControlPoints;
        FinalLeftSplineControlPoints = LeftSplineControlPoints;
        FinalXYnoktaCiftleri = XYnoktaCiftleri;
    else
        
        FinalRightSplineControlPoints = [FinalRightSplineControlPoints ; RightSplineControlPoints];
        FinalLeftSplineControlPoints = [FinalLeftSplineControlPoints ; LeftSplineControlPoints];
        FinalXYnoktaCiftleri = [FinalXYnoktaCiftleri ; XYnoktaCiftleri];
        
    end
    
end





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






hold on;
plot(FinalXYnoktaCiftleri(:,1),FinalXYnoktaCiftleri(:,2),'ro','MarkerSize',2,'MarkerFaceColor','r');
plot(FinalRightSplineControlPoints(:,1),FinalRightSplineControlPoints(:,2),'ro','MarkerSize',2,'MarkerFaceColor','r');
plot(FinalLeftSplineControlPoints(:,1),FinalLeftSplineControlPoints(:,2),'ro','MarkerSize',2,'MarkerFaceColor','r');

%%% form a SPLINE 
orderOfSpline = 3;
NumberOfControlPoints = length(FinalRightSplineControlPoints);
T = linspace(0,1,NumberOfControlPoints-orderOfSpline + 2);    %% 9 kontrol noktasý için
y = linspace(0,1,500);  %% spline points will be composed of 500 pts.


RightSplinePoints = DEBOOR(T, FinalRightSplineControlPoints, y, orderOfSpline);
LeftSplinePoints = DEBOOR(T, FinalLeftSplineControlPoints, y, orderOfSpline);

%%% plot the splines
plot(RightSplinePoints(:,1),RightSplinePoints(:,2),'b-','LineWidth',2);
plot(LeftSplinePoints(:,1),LeftSplinePoints(:,2),'b-','LineWidth',2);

ControlPoints1 = FinalRightSplineControlPoints;
SplinePoints1 = RightSplinePoints;
ControlPoints2 = FinalLeftSplineControlPoints;
SplinePoints2 = LeftSplinePoints;

OptimizedSplinePoints1 = SplinePoints1;
OptimizedSplinePoints2 = SplinePoints2;
OptimizedControlPoints1 = ControlPoints1;
OptimizedControlPoints2 = ControlPoints2;

% --- Executes on button press in ButtonResetROI2.
function ButtonResetROI2_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonResetROI2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global DicomImage;
global Counter;
global FirstCoordinate;
global SecondCoordinate;
global ThirdCoordinate;
global FourthCoordinate;
global RoiExistsFlag;

FirstCoordinate = zeros(1,2);
SecondCoordinate = zeros(1,2);
ThirdCoordinate = zeros(1,2);
FourthCoordinate = zeros(1,2);

RoiExistsFlag = 0;

hold off;
imshow(DicomImage(:,:,Counter));



% --- Executes on key press with focus on figure1 or any of its controls.
function figure1_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

switch eventdata.Key
  case 'rightarrow'
    %<callback function corresponding to "a">
    ButtonNext_Callback(hObject, eventdata, handles);
    %MyButton = uicontrol('Style', 'pushbutton','Callback',@ButtonNext_Callback);
    
  case 'leftarrow'
    %<callback function corresponding to "b"> 
    ButtonPrevious_Callback(hObject, eventdata, handles);
    %MyButton = uicontrol('Style', 'pushbutton','Callback',@task);
    %task(MyButton, []);
  
  
end


% --- Executes on key press with focus on ButtonNext and none of its controls.
function ButtonNext_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ButtonNext (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on ButtonPrevious and none of its controls.
function ButtonPrevious_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ButtonPrevious (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
