function [ OutputImageName ] = GetFileName( FileName )
%UNTÝTLED2 Summary of this function goes here
%   Detailed explanation goes here

Length = length(FileName);

for i=Length:-1:1
    if(FileName(i) == '.')
        IndexOfDot = i;
        break;
    end
    
 
end


for i=IndexOfDot-1:-1:1

    if(FileName(i) == '\')
        IndexOfFirstSlash = i;
        break;
    end

end


for i=IndexOfFirstSlash-1:-1:1

    if(FileName(i) == '\')
        IndexOfSecondSlash = i;
        break;
    end

end

NameOfPatient = FileName(IndexOfSecondSlash+1:IndexOfFirstSlash-1 );
ImageName = FileName(IndexOfFirstSlash+1: IndexOfDot-1);

OutputImageName = strcat(NameOfPatient,'-',ImageName );




end

