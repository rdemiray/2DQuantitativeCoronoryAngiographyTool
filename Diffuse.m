function [ OutputImage, Average, Std, StdOriginal ] = Diffuse( Image, IterationNumber, r )
%UNTÝTLED Summary of this function goes here
%   Detailed explanation goes here



%%%%% Diffusion eqn



[NumberOfRows , NumberOfColumns] = size(Image);

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


%%%% from now on work with the "ExtendedImage", since boundary cond. of the
%%%% image are satisfied here.


%%% 3x3 laplacian window will move on the image iteratively.

[RowsOfExtendedImage, ColumnsOfExtendedImage] = size(ExtendedImage);
IteratedImage = zeros(RowsOfExtendedImage, ColumnsOfExtendedImage);
AverageArray = zeros(IterationNumber,1);
StdArray = zeros(IterationNumber);
ImageForAvgANDStd = zeros(NumberOfRows, NumberOfColumns);



for k=1:1:IterationNumber
    
    for i =1:1:(RowsOfExtendedImage-2)
        for j=1:1:(ColumnsOfExtendedImage-2)
            IteratedImage(i+1, j+1) = ExtendedImage(i+1,j+1) + (r*(ExtendedImage(i+1,j)+ ExtendedImage(i+1, j+2) + ExtendedImage(i, j+1) + ExtendedImage(i+2,j+1) - (4*ExtendedImage(i+1,j+1))));
            
        end
        
    end
    
   ExtendedImage = IteratedImage;
    
    for i =1:1:NumberOfRows
        for j=1:1:NumberOfColumns
            ImageForAvgANDStd(i,j) = IteratedImage(i+1, j+1);
        end
    end
    
    Sum = sum(sum(ImageForAvgANDStd));
    AverageArray(k,1) = Sum/(NumberOfRows*NumberOfColumns);
    StdArray(k) = std2(ImageForAvgANDStd);
    
   
end


 plot(AverageArray);
 plot(StdArray);

        

%%% Extraction of resultant Image
ResultantImage = zeros(NumberOfRows, NumberOfColumns);

for i =1:1:NumberOfRows
    for j=1:1:NumberOfColumns
        ResultantImage(i,j) = IteratedImage(i+1, j+1);
    end
end


OutputImage = ResultantImage;

        
%%%calculation of AVERAGE
Sum = sum(sum(ResultantImage));
Average = Sum/(NumberOfRows*NumberOfColumns);



%%%CALCULATION OF STD DEV.

Std = std2(ResultantImage);
StdOriginal = std2(Image);








end

