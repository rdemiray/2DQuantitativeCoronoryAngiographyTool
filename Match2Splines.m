function [ point1, intersectingPoint] = Match2Splines( SplinePoints1, SplinePoints2 )
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

point1 = SplinePoints1(749,:);
point2 = SplinePoints1(751,:);
midpoint = SplinePoints1(750,:);


[ slope2 , n2] = PerpendicularLineEquation( midpoint,point1, point2 );

% line equation is y = slope2.x + n2


% find nearest points intersecting this line eqn

%minDiff = 100000;   % set as big as possible
intersectingPoint = zeros(1,2);

for i=1:1:a
    
    x = SplinePoints2(i,1);
    y = SplinePoints2(i,2);
    yy = slope2*x + n2;
    DeltaY(i) = y- yy;
    
    if(i==1)    % take the first element of DeltaY as the minDiff
        minDiff = abs(DeltaY(i));
    elseif(abs(DeltaY(i)) < minDiff)
        minDiff = abs(DeltaY(i));
        intersectingPoint = SplinePoints2(i,:);
    end
    
    
    
    
end







end
