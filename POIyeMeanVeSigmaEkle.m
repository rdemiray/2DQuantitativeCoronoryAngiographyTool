function [ POIDzs ] = POIyeMeanVeSigmaEkle( POIDzs, image )
%UNTÝTLED Summary of this function goes here
%   Detailed explanation goes here
 
[toplamPoiSayisi, a] = size(POIDzs);
[NumberOfRows, NumberOfColumns] = size(image);
image = im2double(image);

for poiSirasi=1:toplamPoiSayisi
    
    columnNo=POIDzs(poiSirasi,1);
    rowNo=POIDzs(poiSirasi,2);
    
%     if(columnNo < 5)
%         columnNo = 5;
%     elseif(columnNo > (NumberOfColumns-4)) 
%         columnNo = NumberOfColumns-4;
%     end
%     
%     if(rowNo <  5)
%         rowNo = 5;
%     elseif (rowNo > (NumberOfRows-4))
%         rowNo = NumberOfRows-4;
%     end
    
    
    gorsel(rowNo,columnNo,1)=1;
    imrgb(rowNo,columnNo,1) = 255;
    imrgb(rowNo,columnNo,2) = 0;
    imrgb(rowNo,columnNo,3) = 0;
    
    totalIntensity = 0;
    totalIntensitySquare = 0;
    pixelCount = 0;

    for k=-4:4
        for l=-4:4
            %if ( ((rowNo+k) > 0) && ((columnNo+l) > 0 ) )
            totalIntensity = image(rowNo+k,columnNo+l) + totalIntensity;
            totalIntensitySquare = totalIntensitySquare + image(rowNo+k,columnNo+l)^2;
            pixelCount = pixelCount +1;
            %end
        end
    end

    mean=totalIntensity/pixelCount;
    sigma = double((totalIntensitySquare/pixelCount - mean^2))^0.5;
    POIDzs(poiSirasi,3) = mean;
    POIDzs(poiSirasi,4) = sigma;
end


end

