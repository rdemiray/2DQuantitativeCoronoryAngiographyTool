function [ GradientImage ] = TakeGradient(InputImage )
%UNTÝTLED Summary of this function goes here
%   Detailed explanation goes here


InputImage = double(InputImage);
hy = fspecial('sobel');
hx = hy';
Iy = imfilter(InputImage, hy, 'replicate');
Ix = imfilter(InputImage, hx, 'replicate');
GradientImage = sqrt(Ix.^2 + Iy.^2);
 

end

