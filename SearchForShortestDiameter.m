function [ ModifiedTracePointsOnBiggerSpline ] = SearchForShortestDiameter(SmallerSpline, BiggerSpline, TracePointsOnSmallerSpline,TracePointsOnBiggerSpline )
%UNTÝTLED Summary of this function goes here
%   Detailed explanation goes here


% size of SmallerSpline and BiggerSpline are same
% size of TracePointsOnSmallerSpline and TracePointsOnBiggerSpline are same

[a,b] = size(SmallerSpline);
[c,d] = size(TracePointsOnSmallerSpline);

% repeat for each trace
for i = 1:1:c
    pointOnSmallerSpline = TracePointsOnSmallerSpline(i,:);
    pointOnBiggerSpline = TracePointsOnBiggerSpline(i,:);
    
    % find the index of the point in the spline matrix
    
    for j=1:1:a
        
        if(pointOnBiggerSpline == BiggerSpline(j,:))
            pointIndex = j;
            break;
        end
        
    end
    
    
    % Arama penceresinin baþlangýç ve bitiþ indeksleri set edilir.
    % yani arama penceresi geniþliði set edilir...
    StartIndex = pointIndex - 80;
    StopIndex = pointIndex + 80;
    % bu indexlerin array indexi dýþýna taþmalarý durumu handle
    % edilmeli...yapýldý..
    
    % eðer baþlangýç ve bitiþ indexleri sýnýr dýþýndaysa, sýnýr deðerlere
    % set et
    if(StartIndex < 1)
        StartIndex = 1;
    end
    
    if(StopIndex > a)
        StopIndex = a;
    end
    
    
    for k=StartIndex:1:StopIndex
        
        pointOnBiggerSpline = BiggerSpline(k,:);
        distance = FindDistanceBetweenTwoPoints(pointOnSmallerSpline, pointOnBiggerSpline);
        
        
        
        if(k == StartIndex) %ilk nokta için bulunan mesafeyi min mesafe olarak tut ve sonrakilerle karþýlaþtýr.
            minDistance = distance;
            ShortestDistancePointOnBiggerSpline = BiggerSpline(k,:);
        elseif(distance < minDistance)
            minDistance = distance;
            % store the found point
            ShortestDistancePointOnBiggerSpline = BiggerSpline(k,:);
            
        end
        
        
        
        
    end
    
    ModifiedTracePointsOnBiggerSpline(i,:) = ShortestDistancePointOnBiggerSpline;
    
    
    
    
end



%%%%  after making min diameter search, we have to correct some traces
%%%%  whose slopes are different than the previous 3 slopeof traces.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%       CORRECTION PART      %%%%%%%%%%%%

% NO correction is done HERE !!!!



end

