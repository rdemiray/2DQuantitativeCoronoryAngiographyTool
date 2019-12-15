function [ Mask ] = ConstructMaskOfROI( OptimizedSplinePoints1, OptimizedSplinePoints2, MaskRowSize, MaskColumnSize )
%UNTÝTLED Summary of this function goes here
%   Detailed explanation goes here


Mask = zeros(MaskRowSize, MaskColumnSize);


    
    %%%%%%%%%%%%%%%%%%%%%  POLYGON CONSTRUCTION USING CONTROL POINTS   %%%%%%%%%%
    %%% construction of the polygon...
    % [a,b] = size(SplineArray(3).OptimizedControlPoints1);
    % [c,d] = size(CroppedImages{1,1});
    %
    % XpointsOfROI = zeros(2*a + 1, 1);
    %
    % % take the x coordinates of the first spline
    % for i=1:1:a
    %     XpointsOfROI(i,1) = SplineArray(3).OptimizedControlPoints1(i,1);
    % end
    %
    % % flip the order of the second spline
    % FlippedCP = flipud(SplineArray(3).OptimizedControlPoints2(:,1));
    %
    % % take the x coordinates of the second spline to construct a polygon
    % for i=1:1:a
    %     XpointsOfROI(i+a,1) = FlippedCP(i,1);
    % end
    %
    % % equate the first element to last element to construct a closed polygon
    % XpointsOfROI((2*a + 1), 1) = XpointsOfROI(1,1);
    %
    %
    %
    %
    % YpointsOfROI = zeros(2*a + 1, 1);
    % % take the y coordinates of the first spline
    % for i=1:1:a
    %     YpointsOfROI(i,1) = SplineArray(3).OptimizedControlPoints1(i,2);
    % end
    %
    % % flip the order of the second spline
    % temp = SplineArray(3).OptimizedControlPoints2(:,2);
    % FlippedCP = flipud(temp);
    % % take the y coordinates of the second spline to construct a polygon
    % for i=1:1:a
    %     YpointsOfROI(i+a,1) = FlippedCP(i,1);
    % end
    %
    % % equate the first element to last element to construct a closed polygon
    % YpointsOfROI((2*a + 1), 1) = YpointsOfROI(1,1);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    
    
    
    %%%%%%%%%%%%%%%%%%%%%  POLYGON CONSTRUCTION USING SPLINE POINTS   %%%%%%%%%%
    %%% construction of the polygon...
    
    [a,b] = size(OptimizedSplinePoints1);

    
    Polygon.XpointsOfROI = zeros(2*a + 1, 1);
    
    % take the x coordinates of the first spline
    for i=1:1:a
        Polygon.XpointsOfROI(i,1) = OptimizedSplinePoints1(i,1);
    end
    
    % flip the order of the second spline
    FlippedCP_X = flipud(OptimizedSplinePoints2(:,1));
    
    % take the x coordinates of the second spline to construct a polygon
    for i=1:1:a
        Polygon.XpointsOfROI(i+a,1) = FlippedCP_X(i,1);
    end
    
    % equate the first element to last element to construct a closed polygon
    Polygon.XpointsOfROI((2*a + 1), 1) = Polygon.XpointsOfROI(1,1);
    
    
    
    
    Polygon.YpointsOfROI = zeros(2*a + 1, 1);
    % take the y coordinates of the first spline
    for i=1:1:a
        Polygon.YpointsOfROI(i,1) = OptimizedSplinePoints1(i,2);
    end
    
    % flip the order of the second spline
    FlippedCP_Y = flipud(OptimizedSplinePoints2(:,2));
    % take the y coordinates of the second spline to construct a polygon
    for i=1:1:a
        Polygon.YpointsOfROI(i+a,1) = FlippedCP_Y(i,1);
    end
    
    % equate the first element to last element to construct a closed polygon
    Polygon.YpointsOfROI((2*a + 1), 1) = Polygon.YpointsOfROI(1,1);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    
    
    Mask = poly2mask(Polygon.XpointsOfROI, Polygon.YpointsOfROI,MaskRowSize, MaskColumnSize);
%     Masks{k,1} = cast(Masks{k,1}, class(CroppedImages{k,1}));
%     %Mask = uint8(Mask);
%     hold off;
%     imagesc(Masks{k,1});
%     
%     MaskedImages{k,1} = Masks{k,1} .* CroppedImages{k,1};
%     imshow(MaskedImages{k,1});




end

