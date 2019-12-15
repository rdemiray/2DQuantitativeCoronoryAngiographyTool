function [  ] = Plot2SplineSWithGivenImage( Image, ControlPoints1, SplinePoints1, ControlPoints2, SplinePoints2  )
%UNTÝTLED Summary of this function goes here
%   Detailed explanation goes here

%axes(handles.AxesOutputImagePlot2);

hold off;
imshow(Image);
hold on;
plot(ControlPoints1(:,1),ControlPoints1(:,2),'ro','MarkerSize',3,'MarkerFaceColor','r');
plot(SplinePoints1(:,1),SplinePoints1(:,2),'b-','LineWidth',1);

plot(ControlPoints2(:,1),ControlPoints2(:,2),'ro','MarkerSize',3,'MarkerFaceColor','r');
plot(SplinePoints2(:,1),SplinePoints2(:,2),'b-','LineWidth',1);

end

