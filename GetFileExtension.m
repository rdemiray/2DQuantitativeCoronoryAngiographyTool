function [ FileExtension ] = GetFileExtension( FileName )
%UNTÝTLED Summary of this function goes here
%   Detailed explanation goes here

FileExtension = '';
Length = length(FileName);

if(Length > 3)
    for i=Length:-1:1
        if (FileName(i)== '.')
            FileExtension = FileName(i+1 : Length);
            break;
        end
    end
    
end


end

