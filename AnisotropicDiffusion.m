function [ ResultantImage ] = AnisotropicDiffusion( Image, IterationNumber, r )
%UNTÝTLED Summary of this function goes here
%   Detailed explanation goes here





[NumberOfRows , NumberOfColumns] = size(Image);
Image = im2double(Image);


ExtendedImage = zeros(NumberOfRows+2 , NumberOfColumns+2);

for i=1:1:NumberOfRows
    for j=1:1:NumberOfColumns
        ExtendedImage(i+1, j+1) = Image(i,j);
    end
end



%%%%mirroring
%%%upper edge
for i=1:1:NumberOfColumns
    ExtendedImage(1, i+1) = Image(2,i);
end

%%%lower edge

for i=1:1:NumberOfColumns
    ExtendedImage(NumberOfRows + 2, i+1) = Image(NumberOfRows - 1, i);
end

%%left edge
for i=1:1:NumberOfRows
    ExtendedImage(i+1, 1) = Image(i,2);
end

%%%right edge

for i=1:1:NumberOfRows
    ExtendedImage(i+1, NumberOfColumns + 2) = Image(i, NumberOfColumns - 1);
end


%%% 3x3 laplacian window will move on the image iteratively.

[RowsOfExtendedImage, ColumnsOfExtendedImage] = size(ExtendedImage);
IteratedImage = zeros(RowsOfExtendedImage, ColumnsOfExtendedImage);



%%% diffusion related parameters

GradientImage = TakeGradient(ExtendedImage);
GradientSquare = GradientImage.^2;
%lambda=0.05;
lambda=0.1;


DiffusivityFunction = exp(-GradientSquare/(lambda*lambda));     %% PERONA MALIK
%DiffusivityFunction = 1.0 ./(sqrt( 1 + ((GradientSquare)/(lambda*lambda)) ));     %%CHARBONNIER

% Flux = DiffusivityFunction * GradientImage;
% plot(Flux(99,:));
% plot(Flux);



Waitbar = waitbar(0, 'Anistropic Diffusion is in process now...');

for k=1:1:IterationNumber
    
    
    
    for i =2:1:(RowsOfExtendedImage-1)
        for j=2:1:(ColumnsOfExtendedImage-1)
            IteratedImage(i, j) = ExtendedImage(i,j) + ...
                (r*( ExtendedImage(i+1,j)*Diffusivity( i+0.5,j, DiffusivityFunction) +...
                ExtendedImage(i-1,j)*Diffusivity( i-0.5,j, DiffusivityFunction) + ...
                ExtendedImage(i,j+1)*Diffusivity( i,j+0.5, DiffusivityFunction) + ...
                ExtendedImage(i,j-1)*Diffusivity( i,j-0.5, DiffusivityFunction) - ...
                (Diffusivity( i+0.5,j, DiffusivityFunction) + ...
                Diffusivity( i-0.5,j, DiffusivityFunction) + ...
                Diffusivity( i,j+0.5, DiffusivityFunction) +...
                Diffusivity( i,j-0.5, DiffusivityFunction))*ExtendedImage(i,j)  ));
            
        end
        
    end
    
    ExtendedImage = IteratedImage;
    
    GradientImage = TakeGradient(IteratedImage);
    GradientSquare = GradientImage.^2; 
    DiffusivityFunction = exp(-GradientSquare/(lambda*lambda));
    
    waitbar(k/IterationNumber);
    
    
end


%%% Extraction of resultant Image
ResultantImage = zeros(NumberOfRows, NumberOfColumns);

for i =1:1:NumberOfRows
    for j=1:1:NumberOfColumns
        ResultantImage(i,j) = IteratedImage(i+1, j+1);
    end
end

close(Waitbar);




end

