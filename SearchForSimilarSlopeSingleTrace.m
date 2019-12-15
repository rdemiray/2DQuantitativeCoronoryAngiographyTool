function [ ModifiedTracePointOnBiggerSpline ] = SearchForSimilarSlopeSingleTrace( SmallerSpline, BiggerSpline, TracePointOnSmallerSpline,TracePointOnBiggerSpline, AverageSlopeOfLast3Traces )
%UNTÝTLED2 Summary of this function goes here
%   Detailed explanation goes here



% size of SmallerSpline and BiggerSpline are same
% size of TracePointsOnSmallerSpline and TracePointsOnBiggerSpline are same

[a,b] = size(SmallerSpline);
%[c,d] = size(TracePointsOnSmallerSpline);


pointOnSmallerSpline = TracePointOnSmallerSpline;
pointOnBiggerSpline = TracePointOnBiggerSpline;



% find the index of the point in the spline matrix
for j=1:1:a
    
    if(pointOnBiggerSpline == BiggerSpline(j,:))
        pointIndex = j;
        break;
    end
    
end


% Arama penceresinin baþlangýç ve bitiþ indeksleri set edilir.
% yani arama penceresi geniþliði set edilir...
StartIndex = pointIndex - 140;
StopIndex = pointIndex + 140;
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
    
    %%% Slope lar arasýndaki fark formulü 4 case olarak ele alýnmalý (+, +)
    %%% (+ ,-) (-, +) (-, -)
    %DeltaSlope(SearchWindowIndex) = abs(abs(AverageSlopeOfLast3Traces) - abs(slope(SearchWindowIndex)));
    DeltaSlope(SearchWindowIndex) = abs(AverageSlopeOfLast3Traces - slope(SearchWindowIndex));
    
    
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

ModifiedTracePointOnBiggerSpline = OptimumPointOnBiggerSpline;



end

