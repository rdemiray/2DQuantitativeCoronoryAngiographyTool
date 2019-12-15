function [ SplinePointsInPixels ] = ConvertSpline2Pixels( SplinePoints )
%UNTÝTLED Summary of this function goes here
%   Detailed explanation goes here

 [a,b] = size(SplinePoints);
 index = 1;
 SplinePointsInPixels = [0 0];
 
 %UniqueVar =unique(round(SplinePoints));
 
%  RoundedSplinePoints = round(SplinePoints);
 
%  [x,sortinds] = sort(RoundedSplinePoints(:));
%  dx = diff(x);
% thecount = diff(find([1; dx; 1]));
% uniqueinds = [find(dx); numel(x)];
% countwhat = x(uniqueinds);
% 
% lonelyValues = countwhat(thecount==1);
%  
 for i=1:1:a
     
     PixelCoordinate = round(SplinePoints(i,:));
     
     temp = ~ismember(PixelCoordinate,SplinePointsInPixels, 'rows' );
     if (temp)
         SplinePointsInPixels(index,:) = PixelCoordinate;
         index = index + 1;
         
     end
     
 end
 
 
end

