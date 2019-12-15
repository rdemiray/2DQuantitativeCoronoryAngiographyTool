function [ ] = SaveImage( DicomImage, DicomInfo)
%UNTÝTLED Summary of this function goes here
%   Detailed explanation goes here

NumberOfFrames = DicomInfo.NumberOfFrames;
FileName = DicomInfo.Filename;

FileName = GetFileName(FileName);



for i=1: 1: NumberOfFrames
    ImageToBeSaved = DicomImage(:, :, i);
    
    %Class = class(ImageToBeSaved);
    
    ImageName = strcat(FileName, '-',num2str(i), '.jpg' );
    %imwrite(ImageToBeSaved, ImageName,  'Bitdepth', 16, 'Mode', 'lossless');
    imwrite(ImageToBeSaved, ImageName);
    
end




end

