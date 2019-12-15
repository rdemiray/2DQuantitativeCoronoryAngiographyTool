function [ OptimizedControlPoints, OptimizedSplinePoints, IterationNumber ] = OptimizeGivenSplineHighComplexityPlotV( Image, ControlPoints, CompositeEnergy , SplineNumber)
%UNTÝTLED Summary of this function goes here
%   Detailed explanation goes here





[NoOfControlPoints, b] = size(ControlPoints);
%ModifiedControlPoints = zeros(NoOfControlPoints, b);
ModifiedControlPoints = ControlPoints;

NoOfIteration = NoOfControlPoints - 4 - 1;

ControlPointsStorage = cell(2,1);   % size of the cell will be enlarged then...
SplinePointsStorage = cell(2,1);    % size of the cell will be enlarged then...

k = 1; % k is the iteration number
while(true)
    
    index = 1;
    
    % TAKE  the first 4 control points of the spline
    CP1 = ModifiedControlPoints(index, :);
    CP2 = ModifiedControlPoints(index+1, :);
    CP3 = ModifiedControlPoints(index+2, :);
    CP4 = ModifiedControlPoints(index+3, :);
    
    SetOfControlPoints = [CP1; CP2; CP3; CP4];
    
    
    if(k>2)
        % optimize the three points of the span
        [ ControlPointsAfterOptimization, EnergyOfTheSplineAfterOptimization  ] = OptimizeEnergyOfTheSpan3PTS(SetOfControlPoints, CompositeEnergy, k, SplineNumber, DeltaEnergy(k-2));
    else
        [ ControlPointsAfterOptimization, EnergyOfTheSplineAfterOptimization  ] = OptimizeEnergyOfTheSpan3PTS(SetOfControlPoints, CompositeEnergy, k, SplineNumber, 555555);
    end
        
    
    % store the optimized control points
    ModifiedControlPoints(index, :) = ControlPointsAfterOptimization(1, :);
    ModifiedControlPoints(index+1, :) = ControlPointsAfterOptimization(2, :);
    ModifiedControlPoints(index+2, :) = ControlPointsAfterOptimization(3, :);
    ModifiedControlPoints(index+3, :) = ControlPointsAfterOptimization(4, :);
    
    
    
    
    for i=1:1:NoOfIteration
        
        index = index + 1;
        CP1 = ModifiedControlPoints(index, :);
        CP2 = ModifiedControlPoints(index+1, :);
        CP3 = ModifiedControlPoints(index+2, :);
        CP4 = ModifiedControlPoints(index+3, :);
        
        SetOfControlPoints = [CP1; CP2; CP3; CP4];
        if(k>2)
            [ ControlPointsAfterOptimization, EnergyOfTheSplineAfterOptimization  ] = OptimizeEnergyOfTheSpan4PTS(SetOfControlPoints, CompositeEnergy, k, SplineNumber, index, DeltaEnergy(k-2));
        else
            [ ControlPointsAfterOptimization, EnergyOfTheSplineAfterOptimization  ] = OptimizeEnergyOfTheSpan4PTS(SetOfControlPoints, CompositeEnergy, k, SplineNumber, index, 555555);
        end
        % All points of  the span is modified
        ModifiedControlPoints(index, :) = ControlPointsAfterOptimization(1, :);
        ModifiedControlPoints(index+1, :) = ControlPointsAfterOptimization(2, :);
        ModifiedControlPoints(index+2, :) = ControlPointsAfterOptimization(3, :);
        ModifiedControlPoints(index+3, :) = ControlPointsAfterOptimization(4, :);
        
        
        
    end
    
    
    
    [NormalizedEnergyOfTheSpline, ModifiedSplinePoints] = CalculateNormalizedEnergyOfTheWholeSpline(ModifiedControlPoints, CompositeEnergy);
    
    % store both energy and the control points for the current configuration of
    % the spline
    EnergyVector(k) = NormalizedEnergyOfTheSpline;
    ControlPointsStorage{k,1} = ModifiedControlPoints;
    SplinePointsStorage{k,1} = ModifiedSplinePoints;
    
    if (k>1)
        DeltaEnergy(k-1) = EnergyVector(k) - EnergyVector(k-1);
        
        %if((abs(DeltaEnergy(k-1)) < 0.002) || (k >10))
        %if(DeltaEnergy(k-1) < 0)
        if((abs(DeltaEnergy(k-1)) < 0.006))
                
            
            % maximum energy config is reached, take the current control
            % and spline points and break the infinite loop
            OptimizedControlPoints = cell2mat(ControlPointsStorage(k,1));  % bir önceki kontrol noktalarý ve spline da alýnabilir...
            OptimizedSplinePoints = cell2mat(SplinePointsStorage(k, 1));
            IterationNumber = k;
            break;
        end
    end
    

    
    k = k + 1;
    PlotSplineWithGivenImage(Image, ModifiedControlPoints,ModifiedSplinePoints  );
    
end





end

