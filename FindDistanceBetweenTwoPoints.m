function [ Distance ] = FindDistanceBetweenTwoPoints( point1, point2 )
%UNTÝTLED Summary of this function goes here
%   Detailed explanation goes here

Distance = sqrt((point1(1,1) - point2(1,1))^2 + (point1(1,2) - point2(1, 2))^2 );

end

