function [ RightSplineControlPoints, LeftSplineControlPoints, XYnoktaCiftleri ] = AutoSplineInitGiven2Points_v2( FirstPoint, SecondPoint, CompositeEnergy, StepSize, ResolutionOfSearchStep, NumberOfControlPoints )
%UNTÝTLED Summary of this function goes here
%   Detailed explanation goes here


[y,x] = size(CompositeEnergy);


XaxisOfCompositeEnergy = 1:1:x;
YaxisOfCompositeEnergy = 1:1:y;

%ResolutionOfSearchStep = 0.1;   % damarýn ortasýndaki noktadan saða ve sola kaç pixellik adimlarla gidileceðini gösterir


%%%% Automatic Spline Initialization  %%%%%


%%% iki noktasý bilinen doðru denklemi bulunur
slope = (SecondPoint(1,2) - FirstPoint(1,2))/ (SecondPoint(1,1) - FirstPoint(1,1));
n = FirstPoint(1,2) - (slope*FirstPoint(1,1));
% now we have the line eqn. as          "y = slope*x + n"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



    

    
    
  %%% Her zaman Y-eksenindeki mesafede eþit aralýklý noktalar belirlenir (y de linspace yapýlýr)   
    Ynoktalari = linspace(FirstPoint(1,2), SecondPoint(1,2), NumberOfControlPoints);    % 10(NumberOfControlPoints) tane nokta seçilir
    
    % Y noktalarýna karþýlýk gelen X noktalarý bulunur
    for i=1:1:length(Ynoktalari)
        XYnoktaCiftleri(i,2) = Ynoktalari(i);       % Y noktasý
        XYnoktaCiftleri(i,1) = (Ynoktalari(i) - n)/slope;     % X noktasý
        
    end
    
    
    
    for i=2:1:length(Ynoktalari)
        [ slope2 , n2] = PerpendicularLineEquation2Pts(FirstPoint, XYnoktaCiftleri(i,:) );
        % eqn of the perpendicular line is    "y = slope2*x + n"
        
        %%% X noktalarý üzerinde linspace yapýlýr, sað tarafa gidilerek right spline bulunur (Right Spline)
        PerpendicularLineXpoints = XYnoktaCiftleri(i,1) : ResolutionOfSearchStep : XYnoktaCiftleri(i,1) + StepSize;
        PerpendicularLineYpoints =  slope2*PerpendicularLineXpoints + n2;
        %%% þimdi DÝK doðru üzerinde bulunan bu nokta çiftlerinin enerji
        %%% deðerlerine bakýlýr
        
        
        % sað tarafa giderken bulunan max enerji, sað kontrol noktasý
        % olarak iþaretlenir.
        max = interp2(XaxisOfCompositeEnergy, YaxisOfCompositeEnergy, CompositeEnergy, PerpendicularLineXpoints(1), PerpendicularLineYpoints(1)); % 2D interpolation yapýlarak verilen noktanýn enerjisi bulunur.
        for j=1:1: length(PerpendicularLineYpoints)
            if( interp2(XaxisOfCompositeEnergy, YaxisOfCompositeEnergy, CompositeEnergy, PerpendicularLineXpoints(j), PerpendicularLineYpoints(j)) > max)
                %max = CompositeEnergy(PerpendicularLineXpoints(j), PerpendicularLineYpoints(j));
                max = interp2(XaxisOfCompositeEnergy, YaxisOfCompositeEnergy, CompositeEnergy, PerpendicularLineXpoints(j), PerpendicularLineYpoints(j));
                RightSplineControlPoints(i-1,:) = [PerpendicularLineXpoints(j), PerpendicularLineYpoints(j)];
                
            end
            
        end
        
        
        %%% X noktalarý üzerinde linspace yapýlýr, sola doðru gidilerek left spline bulunur (Left Spline)
        PerpendicularLineXpoints = XYnoktaCiftleri(i,1) : -ResolutionOfSearchStep : XYnoktaCiftleri(i,1) - StepSize;
        %PerpendicularLineXpoints = XYnoktaCiftleri(i,1) - StepSize : ResolutionOfSearchStep : XYnoktaCiftleri(i,1) ;  % deneme
        PerpendicularLineYpoints = slope2*PerpendicularLineXpoints + n2;
        
        
        max = interp2(XaxisOfCompositeEnergy, YaxisOfCompositeEnergy, CompositeEnergy, PerpendicularLineXpoints(1), PerpendicularLineYpoints(1)); % 2D interpolation yapýlarak verilen noktanýn enerjisi bulunur.
        for j=1:1: length(PerpendicularLineYpoints)
            if( interp2(XaxisOfCompositeEnergy, YaxisOfCompositeEnergy, CompositeEnergy, PerpendicularLineXpoints(j), PerpendicularLineYpoints(j)) > max)
                %max = CompositeEnergy(PerpendicularLineXpoints(j), PerpendicularLineYpoints(j));
                max = interp2(XaxisOfCompositeEnergy, YaxisOfCompositeEnergy, CompositeEnergy, PerpendicularLineXpoints(j), PerpendicularLineYpoints(j));
                LeftSplineControlPoints(i-1,:) = [PerpendicularLineXpoints(j), PerpendicularLineYpoints(j)];
                
            end
            
        end
        
       
    end
    
    
    
    
    



end

