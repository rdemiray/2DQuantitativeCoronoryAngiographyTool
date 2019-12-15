function [ CroppedIm ] = CropImage( Image )
%UNTÝTLED Summary of this function goes here
%   Detailed explanation goes here

% matlab HARRIS corner detection algoritmasý kenarlardan köþe bulmasýn diye
% yapýlýyor
[NumberOfRows, NumberOfColumns] = size(Image);
Width = NumberOfColumns -9;
Height = NumberOfRows - 9;
CroppedIm = imcrop(Image, [5, 5,Width, Height]);



end

