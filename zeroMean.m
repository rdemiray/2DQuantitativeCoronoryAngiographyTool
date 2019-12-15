function [ OutputImageCellArray ] = zeroMean( ImageCellArray )
%UNTÝTLED Summary of this function goes here
%   Detailed explanation goes here


[NoOfScales,NoOfOrientation] = size(ImageCellArray);
[NoOfRows, NoOfColumns] = size(cell2mat(ImageCellArray(1,1)));

OutputImageCellArray = cell(NoOfScales, NoOfOrientation);


for i=1:1:NoOfScales
    for j=1:1:NoOfOrientation
        TempMatrix = cell2mat(ImageCellArray(i,j));
        realPart = real(TempMatrix);
        imaginaryPart = imag(TempMatrix);
        
        meanOfreal = mean2(realPart);
        meanOfImaginary = mean2(imaginaryPart);
        
        TempMatrix = realPart - meanOfreal;
        resultedMean = mean2(TempMatrix);
        
        a = complex(TempMatrix, imaginaryPart);
        OutputImageCellArray{i,j}= a;
        
    end
end

end

