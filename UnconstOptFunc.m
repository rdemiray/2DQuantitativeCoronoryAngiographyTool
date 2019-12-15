function [ NormalizedEnergyOfTheSpline ] = UnconstOptFunc( c )
%UNTÝTLED Summary of this function goes here
%   Detailed explanation goes here
% given the control points vector 'c', corresponding energy level of the
% spline is calculated...

global CompositeEnergy;

%%% form a SPLINE
orderOfSpline = 3;
NumberOfControlPoints = length(c);

T = linspace(0,1,NumberOfControlPoints-orderOfSpline + 2);    %% 9 kontrol noktasý için
y = linspace(0,1,500);  %% spline points will be composed of 500 pts.
SplinePoints = DEBOOR(T, c, y, orderOfSpline);

%%% calculate the energy of the current spline
EnergyOfTheSpline = CalculateSplineEnergy(SplinePoints, CompositeEnergy);
EnergyOfTheSpline = -EnergyOfTheSpline;

LengthOfTheSpline = CalculateLengthOfTheSpline(SplinePoints);

NormalizedEnergyOfTheSpline = EnergyOfTheSpline/LengthOfTheSpline;







end

