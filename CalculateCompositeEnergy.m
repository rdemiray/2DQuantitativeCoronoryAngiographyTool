function [ CompositeEnergy ] = CalculateCompositeEnergy( ImageCellArray )
%UNTÝTLED3 Summary of this function goes here
%   Detailed explanation goes here


[NoOfScales,NoOfOrientation] = size(ImageCellArray);
[NoOfRows, NoOfColumns] = size(cell2mat(ImageCellArray(1,1)));

CompositeEnergy = zeros(NoOfRows, NoOfColumns);

for i=1:1:NoOfRows
    for j=1:1:NoOfColumns
        CompositeEnergy(i, j) = 0;
        for k=1:1:NoOfOrientation
            
            TempMatrix = cell2mat(ImageCellArray(1, k));
            a = TempMatrix(i,j);
            b = CompositeEnergy(i, j);
            if(a > b )
                CompositeEnergy(i, j) = TempMatrix(i,j);
            end
            
        end
    end
end

% figure('NumberTitle','Off','Name','deneme');
% for j = 1:NoOfOrientation        
%         subplot(1,NoOfOrientation,j);        
%         imshow(ImageCellArray{1,j},[]);
%        % imagesc(real(gaborArray{i,j}));
% end




end

