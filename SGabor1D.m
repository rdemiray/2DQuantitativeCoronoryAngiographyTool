function [ f, x ] = SGabor1D( N, sigma,lambda, type )
%UNTÝTLED Summary of this function goes here
%   Detailed explanation goes here

% N is grid size, sigma speaks for itself
 x=round(-N/2):0.1:round(N/2);
 
 freq = 0.4;
 k = 0.5;
 %lambda = 0.2;    %% lambda must be calculated??????
 
 psi = k*exp(-lambda*((x./sigma).^2)); 
 
 if(strcmp(type, 'ODD'))
     f=exp(-x.^2/(2*sigma^2)).*sin(x.*2*pi*freq.*psi);
 else if(strcmp(type, 'EVEN'))
         f=exp(-x.^2/(2*sigma^2)).*cos(x.*2*pi*freq.*psi);
     end
 end


end

