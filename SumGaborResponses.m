function [ SumOfTheImages ] = SumGaborResponses( ImageCellArray )
%UNTÝTLED Summary of this function goes here
%   Detailed explanation goes here

[NoOfScales,NoOfOrientation] = size(ImageCellArray);
[NoOfRows, NoOfColumns] = size(cell2mat(ImageCellArray(1,1)));

SumOfTheImages = zeros(NoOfRows,NoOfColumns);
for i=1:1:NoOfScales
    for j=1:1:NoOfOrientation
        
        SumOfTheImages = SumOfTheImages + cell2mat(ImageCellArray(i,j));
    end
end



figure('NumberTitle','Off','Name','deneme');
for j = 1:NoOfOrientation        
        subplot(1,NoOfOrientation,j);        
        imshow(ImageCellArray{1,j},[]);
       % imagesc(real(gaborArray{i,j}));
end


end

