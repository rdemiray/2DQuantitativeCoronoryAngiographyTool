function [ TracePointsOnSmallerSpline, TracePointsOnBiggerSpline, SmallerSpline, BiggerSpline] = Match2Splinesv2( SplinePoints1, SplinePoints2 )
%UNTÝTLED2 Summary of this function goes here
%   Detailed explanation goes here



% SplinePoints are nx2 matrix


LengthOfTheSpline1 = CalculateLengthOfTheSpline(SplinePoints1);
LengthOfTheSpline2 = CalculateLengthOfTheSpline(SplinePoints2);

if(LengthOfTheSpline1 < LengthOfTheSpline2)
    SmallerSpline = SplinePoints1;
    BiggerSpline = SplinePoints2;
else
    SmallerSpline = SplinePoints2;
    BiggerSpline = SplinePoints1;
end

    

% start with the shorter spline for searching operation

[a,b] = size(SmallerSpline);

% bir spline ýn kaç noktadan oluþtuðu önemli....!!!!
TraceFrequency = 10;    % Her 10, 15, 20 spline noktasýnda bir TRACE çizilecek
NoOfTraces = floor(a/TraceFrequency);   % her 20 noktada bir, bir trace çizilecek

% TracePointsOnSmallerSpline;
% TracePointsOnBiggerSpline;


% ilk 3 ve son 3 trace i alma
% ilk 1 ve son 1 trace i alma
for j=2:1:(NoOfTraces-1)
    
    pointIndex = j*TraceFrequency;  % j=20, 40, 60,.....980,   her 20 noktada bir trace çizilecek
    
    % choose points from the smaller spline, then matched them with the
    % other spline
    midpoint = SmallerSpline(pointIndex,:);
    point1 = SmallerSpline(pointIndex -2,:);
    point2 = SmallerSpline(pointIndex +2,:);
    
    
    
    [ slope2 , n2] = PerpendicularLineEquation( midpoint,point1, point2 );
    
    % line equation is y = slope2.x + n2
    
    
    % find nearest points intersecting this line eqn
    
    %minDiff = 100000;   % set as big as possible
    intersectingPoint = zeros(1,2);
    
    for i=1:1:a
        
        % search each points of the bigger spline for intersection point
        x = BiggerSpline(i,1);
        y = BiggerSpline(i,2);
        yy = slope2*x + n2;
        DeltaY(i) = y- yy;
        
        if(i==1)    % take the first element of DeltaY as the minDiff
            minDiff = abs(DeltaY(i));
            intersectingPoint = BiggerSpline(i,:);
        elseif(abs(DeltaY(i)) < minDiff)
            minDiff = abs(DeltaY(i));
            intersectingPoint = BiggerSpline(i,:);
        end
        
        
        
        
    end
    
    TracePointsOnSmallerSpline(j-1,:) = midpoint;
    TracePointsOnBiggerSpline(j-1,:) = intersectingPoint;
     
end








end
