function [ slope2 , n2] = PerpendicularLineEquation2Pts(point1, point2 )
%UNTÝTLED Summary of this function goes here
%   Detailed explanation goes here
% given two points, calculate the perpendicular line equation i.e. m and n
% for y = mx +n
% given points are 1x2 vectors consisting of (x,y) coordinates

% find the slope between two points
% point1 = (x1,y1)
% point2 = (x2,y2)
x1 = point1(1,1);
y1 = point1(1,2);
x2 = point2(1,1);
y2 = point2(1,2);


slope = (y2-y1)/(x2-x1);

%%%% line equaiton: y = mx + n
% n = y - mx
% m is known(slope), find "n"

n = y1 - (slope*x1);

% now we have the line equation parameters: m,n

% our porpose is to find a line perpendicular to this line

% if slope = 0, then slope2 will be infinity

slope2 = -1/slope;  % slope of the perpendicular line

% use the  second point and the new slope to find the eqn of the perpendicular
% line

n2 = y2 - (slope2*x2);





end

