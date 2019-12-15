function [  ] = PlotLineBetweenTwoPoints( Point1, Point2 )
%UNTÝTLED Summary of this function goes here
%   Detailed explanation goes here

x1 = Point1(1,1);
y1 = Point1(1,2);
x2 = Point2(1,1);
y2 = Point2(1,2);


coord1 = [x1, x2];
coord2 = [y1, y2];
plot(coord1, coord2, 'b-','LineWidth',2);


end

