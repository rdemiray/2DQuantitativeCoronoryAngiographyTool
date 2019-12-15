function [ f , x] = Gabor1D( N, sigma, type )
%UNTÝTLED3 Summary of this function goes here
%   Detailed explanation goes here

% N is grid size, sigma speaks for itself
 x=round(-N/2):0.1:round(N/2);
 freq = 0.4;
 
 if(strcmp(type, 'ODD'))
     f=exp(-x.^2/(2*sigma^2)).*sin(x.*2*pi*freq);
 else if(strcmp(type, 'EVEN'))
         f=exp(-x.^2/(2*sigma^2)).*cos(x.*2*pi*freq);
     end
 end
 
 %f=f./sum(f(:));    %% normalization ??....may be deleted...


end

