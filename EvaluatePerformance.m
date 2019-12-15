function [N_I, N_GT, TP, FP, FN,P_co, P_nd,  P_fa, IMP, L2DistanceIn4DmetricSpace ] = EvaluatePerformance( Spline, GroundTruthSpline )
%UNTÝTLED Summary of this function goes here
%   Detailed explanation goes here

[a,b] = size(Spline);
[c,d] = size(GroundTruthSpline);

TotalNumberOfPixelsInSpline = 0;

if (a>c)
    TotalNumberOfPixelsInSpline = a;
else
    TotalNumberOfPixelsInSpline = c;
end


TP = 0;
FN = 0;
FP = 0;

for i=1:1:a
    
    temp = ismember(Spline(i,:),GroundTruthSpline, 'rows' );
    if(temp)
        TP = TP + 1;
    else
        FP = FP + 1;
    end
 
    
end


for i=1:1:c
    temp = ismember(GroundTruthSpline(i,:),Spline, 'rows' );
    if(~temp)
        
        FN = FN + 1;
    end
    
    
end


P_co = TP/TotalNumberOfPixelsInSpline;
P_fa = FP/TotalNumberOfPixelsInSpline;
P_nd = FN/TotalNumberOfPixelsInSpline;



%%%% FÝGURE of merit of Pratt  %%%%%%

for i=1:1:c
    
    MinDistance = 100;  %% as big as possible
    
    for j=1:1:a
        
        CurrentDistance = FindDistanceBetweenTwoPoints( GroundTruthSpline(i,:), Spline(j,:) );
        if(CurrentDistance < MinDistance)
            MinDistance = CurrentDistance;
        end
        
        
    end
    MinDistanceArray(i) = MinDistance;
end

Sum = 0;
for i=1:1:numel(MinDistanceArray)
    Sum = Sum + (1/(1 + ((1/9) * MinDistanceArray(i)^2)));
    
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


IMP = Sum/TotalNumberOfPixelsInSpline;
L2DistanceIn4DmetricSpace = sqrt((IMP -1)^2 + (P_co -1)^2 +  P_fa^2 + P_nd^2);
N_I = a;
N_GT = c;

end

