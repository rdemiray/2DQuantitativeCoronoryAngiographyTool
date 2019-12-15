function [ ModifiedTracePointsOnBiggerSpline ] = SearchForShortestDiameterWithCorrection(SmallerSpline, BiggerSpline, TracePointsOnSmallerSpline,TracePointsOnBiggerSpline )
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



[a,b] = size(ModifiedTracePointsOnBiggerSpline);

% find the slope of each traces to check and correct for any abnormality
for i=1:1:a
    slopeOfTraces(i) = FindSlopeOfTwoPoints(TracePointsOnSmallerSpline(i,:),ModifiedTracePointsOnBiggerSpline(i,:));
end

AbsMeanOfSlopes = mean(abs(slopeOfTraces));

 % BU threshold deðeri fixed olduðu zaman, durumdan duruma threshold deðiþtirmek gerekiyor. Fix threshold yerine, mevcut tracelerin slope durumlarýna göre adaptive set edilebilir.
 %  Adaptive threshold 
if(AbsMeanOfSlopes > 20)
    Threshold = 5;% tanjantýn 90 dereceye yakýn olduðu durumlarda yüksek eðim geliyor.
else
    Threshold = 0.01; % diðer durumlarda bu deðer test edilerek bulundu, her 10 noktada 1 trace çizildiði durum
end


  
for i=2:1:a
    DiffInSlope(i-1) = abs(slopeOfTraces(i)) - abs(slopeOfTraces(i-1));
    DiffInSlopeMdfd(i-1) = abs(slopeOfTraces(i)) - abs(slopeOfTraces(i-1));
    
    if abs(DiffInSlope(i-1)) > Threshold% there is an abnormality here.
        % THEN make a corrcetion on this trace by looking at slope
        % similarity
        
        if(i>3)
            % calculate average slope of three traces
            %AverageSlopeOfLast3Traces = (abs(slopeOfTraces(i-1)) + abs(slopeOfTraces(i-2)) + abs(slopeOfTraces(i-3)))/3;
            %AverageSlopeOfLast3Traces = ((slopeOfTraces(i-1)) + (slopeOfTraces(i-2)) + (slopeOfTraces(i-3)))/3; % DENEME....Bu iki yöntemdan daha iyisi bulunmalý..
            AverageSlopeOfLast3Traces = FindAverageSlopeOf3Traces(slopeOfTraces(i-1), slopeOfTraces(i-2), slopeOfTraces(i-3));
            NewTracePointOnBiggerSpline = SearchForSimilarSlopeSingleTrace( SmallerSpline, BiggerSpline, TracePointsOnSmallerSpline(i,:),ModifiedTracePointsOnBiggerSpline(i,:), AverageSlopeOfLast3Traces );
            % calculate the new slope and store it.
            
            ModifiedTracePointsOnBiggerSpline(i,:) = NewTracePointOnBiggerSpline;
            slopeOfTraces(i) = FindSlopeOfTwoPoints(TracePointsOnSmallerSpline(i,:), NewTracePointOnBiggerSpline);
            DiffInSlopeMdfd(i-1) = abs(slopeOfTraces(i)) - abs(slopeOfTraces(i-1));
        end
        
    end
    
end


AbsMeanOfSlopes = mean(abs(slopeOfTraces));



end

