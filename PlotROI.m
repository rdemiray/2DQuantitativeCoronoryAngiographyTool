function [  ] = PlotROI( FirstCoordinate, SecondCoordinate, ThirdCoordinate, FourthCoordinate )
%UNTÝTLED Summary of this function goes here
%   Detailed explanation goes here


% plot from first coord to second
x1 = FirstCoordinate(1,1);
y1 = FirstCoordinate(1,2);
x2 = SecondCoordinate(1,1);
y2 = SecondCoordinate(1,2);

coord1 = [x1, x2];
coord2 = [y1, y2];
plot(coord1, coord2, 'b-','LineWidth',2);


% plot from second coord to fourth
x1 = SecondCoordinate(1,1);
y1 = SecondCoordinate(1,2);
x2 = FourthCoordinate(1,1);
y2 = FourthCoordinate(1,2);

coord1 = [x1, x2];
coord2 = [y1, y2];
plot(coord1, coord2, 'b-','LineWidth',2);


% plot from fourth coord to third
x1 = FourthCoordinate(1,1);
y1 = FourthCoordinate(1,2);
x2 = ThirdCoordinate(1,1);
y2 = ThirdCoordinate(1,2);

coord1 = [x1, x2];
coord2 = [y1, y2];
plot(coord1, coord2, 'b-','LineWidth',2);


% plot from third coord to first
x1 = ThirdCoordinate(1,1);
y1 = ThirdCoordinate(1,2);
x2 = FirstCoordinate(1,1);
y2 = FirstCoordinate(1,2);

coord1 = [x1, x2];
coord2 = [y1, y2];
plot(coord1, coord2, 'b-','LineWidth',2);


end

