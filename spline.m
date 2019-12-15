function [ControlPoints, SplinePoints ] = spline(n,order)

% function spline(n,order)
%
% Plots the B-slpine-curve of n control-points.
% The control points can be chosen by clicking
% with the mouse on the figure.
%
% COMMAND:  spline(n,order)
% INPUT:    n     Number of Control-Points
%           order Order ob B-Splines
%                 Argnument is arbitrary
%                 default: order = 4
%
% Date:     2007-11-28
% Author:   Stefan Hüeber

% close all;
% if (nargin ~= 2)
% 	order = 4;
% end
% 
% 
% if (n < order)
% 	display([' !!! Error: Choose n >= order=',num2str(order),' !!!']);
% 	return;
% end

% figure(1);
% hold on; box on;
% set(gca,'Fontsize',16);

nplot = 100;
t = linspace(0,1,nplot);

for i = 1:n	
	title(['Choose ',num2str(i),' th. control point']);
	ControlPoints(i,:) = ginput(1);
	hold on;
	%plot(ControlPoints(:,1),ControlPoints(:,2),'k-','LineWidth',2); % plots a line between control points
	%axis([0 1 0 1]);
	%hold on; box on;
	if (i  >= order) 
		T = linspace(0,1,i-order+2);
		y = linspace(0,1,1000);  % y determines the number of spline points for that b-spline
		SplinePoints = DEBOOR(T,ControlPoints,y,order);
		
	end
	plot(ControlPoints(:,1),ControlPoints(:,2),'ro','MarkerSize',2,'MarkerFaceColor','r');
end

plot(SplinePoints(:,1),SplinePoints(:,2),'b-','LineWidth',1);

title(['B-Spline-curve with ',num2str(n),' control points of order ',num2str(order)]);