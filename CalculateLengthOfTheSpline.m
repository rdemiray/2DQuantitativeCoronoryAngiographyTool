function [ LengthOfTheSpline ] = CalculateLengthOfTheSpline(SplinePoints)
%UNTÝTLED2 Summary of this function goes here
%   Detailed explanation goes here

MatrixLength = (length(SplinePoints) - 1);
Distance = zeros(MatrixLength,1);
LengthOfTheSpline = 0;

for n=1:1: MatrixLength;
    Distance(n) = sqrt((SplinePoints(n+1,1) - SplinePoints(n,1))^2 + (SplinePoints(n+1,2) - SplinePoints(n, 2))^2 );
end

LengthOfTheSpline = sum(Distance);


end

