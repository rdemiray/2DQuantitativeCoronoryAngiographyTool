function [ AverageSlopeOf3Traces ] = FindAverageSlopeOf3Traces(slope1, slope2, slope3)
%UNTÝTLED Summary of this function goes here
%   Detailed explanation goes here

AbsMean = (abs(slope1) + abs(slope2) + abs(slope3))/3;

if( slope1 > 0 && slope2 > 0 && slope3 >0 )% hepsi pozitifse ortalama al
    AverageSlopeOf3Traces = (slope1 + slope2 + slope3)/3;
elseif(slope1 < 0 && slope2 < 0 && slope3 < 0 )% hepsi  negatifse ortalama al
    AverageSlopeOf3Traces = (slope1 + slope2 + slope3)/3;
elseif(AbsMean > 20)% eðer sonsuz eðimin olduðu (dik doðrunun eðimi) noktanýn etrafýnda eksi ve artý eðimler varsa: Örn, -900, 900, -800
    AverageSlopeOf3Traces = AbsMean;
else% son koþul: içinde - ve + iþaretli eðimler var fakat bunlarýn deðeri küçük. Mesela -2, 0, +2
    AverageSlopeOf3Traces = (slope1 + slope2 + slope3)/3;
end


end

