function [  f,x ] = Gabor1Dwhole( N, sigma )
%UNTÝTLED2 Summary of this function goes here
%   Detailed explanation goes here

x=round(-N/2):0.1:round(N/2);
 
 freq = 0.4;
 %k = 0.5;
 %lambda = 0.2;    %% lambda must be calculated??????
 
 %psi = k*exp(-lambda*(x/sigma).^2); 
 
 f=exp(-x.^2/(2*sigma^2))*exp(1i*2*pi*freq.*x);sin(x.*2*pi*freq.*psi);
 
        
     




end

