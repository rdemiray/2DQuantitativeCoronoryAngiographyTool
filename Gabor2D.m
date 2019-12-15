function [ gaborFilter ] = Gabor2D( N, sigmaX, sigmaY,type )
%UNTÝTLED Summary of this function goes here
%   Detailed explanation goes here

% N is grid size, sigma speaks for itself
%[x y]=meshgrid(fix(-N/2):fix(N/2), fix(-N/2):fix(N/2));
%  x=fix(-N/2):1:fix(N/2);
%  y=fix(-N/2):1:fix(N/2);
 freq = 0.4;
gaborFilter = zeros(length(N), length(N));
 
 if(strcmp(type, 'ODD'))
     for x=1:1:N
         for y=1:1:N
            a = exp(-x.^2/(2*sigmaX^2))*exp(-y.^2/(2*sigmaY^2)).*sin(x.*2*pi*freq);
            gaborFilter(x,y) = a;
         end
    end
 else if(strcmp(type, 'EVEN'))
         for i=1:1:length(x)
             for j=1:1:length(y)
                 gaborFilter(i,j) = exp(-x(i).^2/(2*sigmaX^2))*exp(-y(i).^2/(2*sigmaY^2)).*cos(x(i).*2*pi*freq);
             end
         end
     end
 end

end

