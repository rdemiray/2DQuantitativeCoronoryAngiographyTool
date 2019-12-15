function [ gaborArray ] = GaborFilterBankmhrrm( v,sigmaX, sigmaY, m, n )
%UNTÝTLED Summary of this function goes here
%   Detailed explanation goes here


gaborArray = cell(1,v);


    f = 0.39/sigmaX;  % from the main paper, f changes for each scale
    for j = 1:v  %%% for each orientation
        tetav = ((j-1)/v)*pi;
        gFilter = zeros(m,n);
        
        for x = 1:m
            for y = 1:n
                xprime = (x-((m+1)/2))*cos(tetav)+(y-((n+1)/2))*sin(tetav);
                yprime = -(x-((m+1)/2))*sin(tetav)+(y-((n+1)/2))*cos(tetav);
                gFilter(x,y) = (1/(2*pi*(sigmaX*sigmaY)))*exp(-(xprime^2)/(2*(sigmaX^2)) - (yprime^2)/(2*(sigmaY^2)))* exp(1i*2*pi*f*xprime);
            end
        end
        gaborArray{1,j} = gFilter;
    end


%% Show Gabor filters

% % Show magnitudes of Gabor filters:
% figure('NumberTitle','Off','Name','Magnitudes of Gabor filters');
% 
%     for j = 1:v        
%         subplot(1,v,j);        
%         imshow(abs(gaborArray{1,j}),[]);
%         %imagesc(abs(gaborArray{i,j}));
%     end
% 
% 
% % %Show real parts of Gabor filters:
% figure('NumberTitle','Off','Name','Real parts of Gabor filters');
% 
%     for j = 1:v        
%         subplot(1,v,j);        
%         imshow(real(gaborArray{1,j}),[]);
%        % imagesc(real(gaborArray{i,j}));
%     end

% for j=1:v
% subplot(1,v,j);        
% imshow(real(gaborArray{u,j}),[]);
% end


end

