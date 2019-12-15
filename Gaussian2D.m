function [ f ] = Gaussian2D( N, sigma )
%UNTÝTLED Summary of this function goes here
%   Detailed explanation goes here

% N is grid size, sigma speaks for itself
 [x y]=meshgrid(round(-N/2):round(N/2), round(-N/2):round(N/2));
 f=exp(-x.^2/(2*sigma^2)-y.^2/(2*sigma^2));
 f=f./sum(f(:));


end

