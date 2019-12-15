function [ NormalizedEnergyOfTheSpline, SplinePoints ] = CalculateNormalizedEnergyOfTheWholeSpline(ControlPoints, CompositeEnergy)
%UNTÝTLED Summary of this function goes here
%   Detailed explanation goes here


[a,b] = size(ControlPoints);

%%% SPLINE PARAMETERS
T = linspace(0,1,a-1);  %% in fact the equaiton is:  "a - order + 2"
y = linspace(0,1,500);  %% spline points will be composed of 100 pts.
orderOfSpline = 3;


SplinePoints = DEBOOR(T, ControlPoints, y, orderOfSpline);

EnergyOfTheSpline = CalculateSplineEnergy(SplinePoints, CompositeEnergy);

LengthOfTheSpline = CalculateLengthOfTheSpline(SplinePoints);

NormalizedEnergyOfTheSpline = EnergyOfTheSpline/LengthOfTheSpline;

end

