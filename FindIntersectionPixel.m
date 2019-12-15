function [intersectionPixel, IndexInTheCenterline] = FindIntersectionPixel(CurrentTrace, CenterlineInPixels_Rounded)
%UNTÝTLED Summary of this function goes here
%   Detailed explanation goes here
LengthOfCurrentTrace = length(CurrentTrace);
LengthOfCenterline = length(CenterlineInPixels_Rounded);

MinDistance = 200; % set TempDistance as big as possible

for i=1:1:LengthOfCenterline
    
    for j=1:1:LengthOfCurrentTrace
        
        TempDistance = FindDistanceBetweenTwoPoints(CenterlineInPixels_Rounded(i,:) , CurrentTrace(j,:));
        if(TempDistance < MinDistance)
            
            MinDistance = TempDistance;
            IndexInTheCenterline = i;
            intersectionPixel = CenterlineInPixels_Rounded(i,:);
            
        end
        
    end
    
    
    
end

end

