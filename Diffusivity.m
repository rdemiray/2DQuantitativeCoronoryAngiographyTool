function [ Result ] = Diffusivity(  Index1, Index2, DiffusivityFunction )
%UNTÝTLED2 Summary of this function goes here
%   Detailed explanation goes here


if(rem(Index1,1) ~= 0)
    Index11 = Index1+0.5;
    Index12 = Index1-0.5;
    
    Result = (DiffusivityFunction(Index11,Index2) + DiffusivityFunction(Index12, Index2))/2;
elseif(rem(Index2,1) ~= 0)
    
    Index21 = Index2 + 0.5;
    Index22 = Index2 - 0.5;
    Result = (DiffusivityFunction(Index1, Index21) + DiffusivityFunction(Index1,Index22))/2;
else
    Result = DiffusivityFunction(Index1, Index2);
end





end

        



