function [ ControlPointsAfterOptimization, EnergyOfTheSplineAfterOptimization  ] = OptimizeEnergyOfTheSpan3PTS(ControlPoints, CompositeEnergy,IterationNumber, SplineNumber, DeltaEnergy)
%UNTÝTLED3 Summary of this function goes here
%   Detailed explanation goes here

% ControlPoints1 has only 4 control points. 4x2 matrix.
% A span consists of 4 points
% this function optimizes energy of a span using the last 3 control points

[a,b] = size(ControlPoints);
EnergyOfTheSplineAfterOptimization = 0;

ControlPointsAfterOptimization = zeros(a,b);
NewSetOfControlPoints = zeros(a,b);


%%% SPLINE PARAMETERS
T = linspace(0,1,3);
y = linspace(0,1,10);  %% spline points will be composed of 50 pts.
orderOfSpline = 3;

% INITIALIZE the control points to the first cell of 3x3 window.
CP1Index_Y = ControlPoints(1,1);
CP1Index_X = ControlPoints(1,2);
% CP1Index_Y = CP1Index_Y - 1;
% CP1Index_X = CP1Index_X - 1;
% first controlpoint is static

CP2Index_Y = ControlPoints(2,1);
CP2Index_X = ControlPoints(2,2);
CP2Index_Y = CP2Index_Y - 1;
CP2Index_X = CP2Index_X - 1;

CP3Index_Y = ControlPoints(3,1);
CP3Index_X = ControlPoints(3,2);
CP3Index_Y = CP3Index_Y - 1;
CP3Index_X = CP3Index_X - 1;

CP4Index_Y = ControlPoints(4,1);
CP4Index_X = ControlPoints(4,2);
CP4Index_Y = CP4Index_Y - 1;
CP4Index_X = CP4Index_X - 1;


Waitbar = waitbar(0, '1', 'Name', 'Snake optimization is in progress now...');

for j=0:1:8     %for P2
    
    CP2DiffForX = rem(j,3);
    CP2DiffForY = floor(j/3);
    
    CP2Index_YY = CP2Index_Y + CP2DiffForY;
    CP2Index_XX = CP2Index_X + CP2DiffForX;
    
    for k=0:1:8     % for P3
        
        CP3DiffForX = rem(k,3);
        CP3DiffForY = floor(k/3);
        
        CP3Index_YY = CP3Index_Y + CP3DiffForY;
        CP3Index_XX = CP3Index_X + CP3DiffForX;
        for m=0:1:8     % for P4
            
            CP4DiffForX = rem(m,3);
            CP4DiffForY = floor(m/3);
            
            CP4Index_YY = CP4Index_Y + CP4DiffForY;
            CP4Index_XX = CP4Index_X + CP4DiffForX;
            
            NewSetOfControlPoints = [CP1Index_Y CP1Index_X;
                CP2Index_YY CP2Index_XX;
                CP3Index_YY, CP3Index_XX;
                CP4Index_YY CP4Index_XX];
            %%% form a SPLINE using current control points
            NewlyComposedSplinePoints = DEBOOR(T, NewSetOfControlPoints, y, orderOfSpline);
            
            %%% calculate the energy of the current spline
            EnergyOfTheSpline = CalculateSplineEnergy(NewlyComposedSplinePoints, CompositeEnergy);
            
            LengthOfTheSpline = CalculateLengthOfTheSpline(NewlyComposedSplinePoints);
            
            NormalizedEnergyOfTheSpline = EnergyOfTheSpline/LengthOfTheSpline;
            
            if(NormalizedEnergyOfTheSpline > EnergyOfTheSplineAfterOptimization)
                EnergyOfTheSplineAfterOptimization = NormalizedEnergyOfTheSpline;
                ControlPointsAfterOptimization = NewSetOfControlPoints;
            end
            
            waitbar((j*81 + k*9 + (m+1))/729, Waitbar, sprintf( 'Spline: %3d    Iteration: %3d    DeltaEnergy: %3d', SplineNumber, IterationNumber, DeltaEnergy));
            
            
        end
    end
end


close(Waitbar);




end

