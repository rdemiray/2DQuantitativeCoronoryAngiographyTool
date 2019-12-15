function [ ModifiedTracePointsOnBiggerSpline ] = SearchForSimilarSlope( SmallerSpline, BiggerSpline, TracePointsOnSmallerSpline,TracePointsOnBiggerSpline )
%UNTÝTLED2 Summary of this function goes here
%   Detailed explanation goes here



% size of SmallerSpline and BiggerSpline are same
% size of TracePointsOnSmallerSpline and TracePointsOnBiggerSpline are same

[a,b] = size(SmallerSpline);
[c,d] = size(TracePointsOnSmallerSpline);

% repeat for each trace
for i = 1:1:c
    pointOnSmallerSpline = TracePointsOnSmallerSpline(i,:);
    pointOnBiggerSpline = TracePointsOnBiggerSpline(i,:);
    
    
    if(i<4)% ilk 3 trace i aynen al.
        ModifiedTracePointsOnBiggerSpline(i,:) = TracePointsOnBiggerSpline(i,:);
           
    else 
        
        AverageSlopeOfLast3Traces =  (abs(FindSlopeOfTwoPoints(TracePointsOnSmallerSpline(i-3,:),ModifiedTracePointsOnBiggerSpline(i-3,:))) +...
                                      abs(FindSlopeOfTwoPoints(TracePointsOnSmallerSpline(i-2,:),ModifiedTracePointsOnBiggerSpline(i-2,:))) +...
                                      abs(FindSlopeOfTwoPoints(TracePointsOnSmallerSpline(i-1,:),ModifiedTracePointsOnBiggerSpline(i-1,:))))/3;
        
        
        
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
        
        slope = zeros(StopIndex -StartIndex+1,1);
        DeltaSlope = zeros(StopIndex -StartIndex+1,1);
        SearchWindowIndex = 0;
        for k=StartIndex:1:StopIndex
            SearchWindowIndex = SearchWindowIndex + 1;
            
            pointOnBiggerSpline = BiggerSpline(k,:);
            %distance(k) = FindDistanceBetweenTwoPoints(pointOnSmallerSpline, pointOnBiggerSpline);
            slope(SearchWindowIndex) = FindSlopeOfTwoPoints(pointOnSmallerSpline, pointOnBiggerSpline);
            
            
            DeltaSlope(SearchWindowIndex) = abs(abs(AverageSlopeOfLast3Traces) - abs(slope(SearchWindowIndex)));
            %DeltaSlope(SearchWindowIndex) = abs(AverageSlopeOfLast3Traces - slope(SearchWindowIndex));
            
            
            % 4 ve sonrasýndaki trace ler için önceki ilk 3 trace slope ortalamasýna bak
            
            
            if(k == StartIndex) %ilk nokta için bulunan mesafeyi min mesafe olarak tut ve sonrakilerle karþýlaþtýr.
                similarSlope = DeltaSlope(SearchWindowIndex);
                OptimumPointOnBiggerSpline = BiggerSpline(k,:);
            elseif(DeltaSlope(SearchWindowIndex) < similarSlope)
                similarSlope = DeltaSlope(SearchWindowIndex);
                % store the found point
                OptimumPointOnBiggerSpline = BiggerSpline(k,:);
                
            end
            
            
        end
        
        ModifiedTracePointsOnBiggerSpline(i,:) = OptimumPointOnBiggerSpline;
        
        
        
     
        
        
    end
    
    
    
    
    
    
    
end

end

