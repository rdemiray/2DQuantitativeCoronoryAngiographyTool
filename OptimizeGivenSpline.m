function [ OptimizedControlPoints, OptimizedSplinePoints, IterationNumber ] = OptimizeGivenSpline( ControlPoints, CompositeEnergy , SplineNumber)
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
        [ ControlPointsAfterOptimization, EnergyOfTheSplineAfterOptimization  ] = OptimizeEnergyOfTheSpan3PTS(SetOfControlPoints, CompositeEnergy, k, SplineNumber, 100);
    end
        
    
    % store the optimized control points
    ModifiedControlPoints(index, :) = ControlPointsAfterOptimization(index, :);
    ModifiedControlPoints(index+1, :) = ControlPointsAfterOptimization(index+1, :);
    ModifiedControlPoints(index+2, :) = ControlPointsAfterOptimization(index+2, :);
    ModifiedControlPoints(index+3, :) = ControlPointsAfterOptimization(index+3, :);
    
    
    
    
    for i=1:1:NoOfIteration
        
        index = index + 1;
        CP1 = ModifiedControlPoints(index, :);
        CP2 = ModifiedControlPoints(index+1, :);
        CP3 = ModifiedControlPoints(index+2, :);
        CP4 = ModifiedControlPoints(index+3, :);
        
        SetOfControlPoints = [CP1; CP2; CP3; CP4];
        [ ControlPointsAfterOptimization, EnergyOfTheSplineAfterOptimization  ] = OptimizeEnergyOfTheSpan1PT(SetOfControlPoints, CompositeEnergy);
        
        % only last point of the span is modified
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
        if(DeltaEnergy(k-1) < 0) % local maxima noktasýna ulaþýldý...
                
            
            % maximum energy config is reached, take the previous control
            % and spline points and break the infinite loop
%             OptimizedControlPoints = cell2mat(ControlPointsStorage(k,1));
%             OptimizedSplinePoints = cell2mat(SplinePointsStorage(k, 1));
            OptimizedControlPoints = cell2mat(ControlPointsStorage(k-1,1));
            OptimizedSplinePoints = cell2mat(SplinePointsStorage(k-1, 1));
            IterationNumber = k;
            break;
        end
    end
    

    
    k = k + 1;
    
end





end

