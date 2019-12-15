function [ slope ] = FindSlopeOfTwoPoints(pointOnSmallerSpline, pointOnBiggerSpline)
%UNTÝTLED Summary of this function goes here
%   Detailed explanation goes here
% y2-y1/x2-x1

slope = (pointOnBiggerSpline(1,2)- pointOnSmallerSpline(1,2))/(pointOnBiggerSpline(1,1) - pointOnSmallerSpline(1,1));

end

