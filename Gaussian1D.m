function [ f ] = Gaussian1D( N, sigma )
%UNTÝTLED2 Summary of this function goes here
%   Detailed explanation goes here

% N is grid size, sigma speaks for itself
 x=round(-N/2):0.1:round(N/2);
 f=exp(-x.^2/(2*sigma^2));
 f=f./sum(f(:));


end

