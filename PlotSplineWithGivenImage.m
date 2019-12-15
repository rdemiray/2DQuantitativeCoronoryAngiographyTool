function [  ] = PlotSplineWithGivenImage( Image, ControlPoints, SplinePoints  )
%UNTÝTLED Summary of this function goes here
%   Detailed explanation goes here

%axes(handles.AxesOutputImagePlot2);

hold off;
imshow(Image);
hold on;
plot(ControlPoints(:,1),ControlPoints(:,2),'ro','MarkerSize',3,'MarkerFaceColor','r');
plot(SplinePoints(:,1),SplinePoints(:,2),'b-','LineWidth',1);

end

