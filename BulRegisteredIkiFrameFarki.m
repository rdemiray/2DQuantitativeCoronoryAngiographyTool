function [finalPositiveDifImage, finalNegativeDifImage, H, registeredImage] = BulRegisteredIkiFrameFarki(MatchedPOIDzs, imgauss1, imgauss2, ropen, rclose, warpingBasariliMi)

% sub pixel cozonurlukte eslestirilen poiler duzenlenir.
% cpcorr fonksiyonu [yan1 alt1; yan2 alt2; yan3 alt3] formatýnda data
% almaktadýr. MatchedPOIDzs ise bunu tersidir.

% subpixel duzeltme baslangici
[poiSayisi, dummy] = size(MatchedPOIDzs);
poi1 = zeros(poiSayisi,2);
poi2 = zeros(poiSayisi,2);

poi1(:,1) = MatchedPOIDzs(:,2);
poi1(:,2) = MatchedPOIDzs(:,1);
poi2(:,1) = MatchedPOIDzs(:,4);
poi2(:,2) = MatchedPOIDzs(:,3);

poi1out = cpcorr(poi1, poi2, imgauss1, imgauss2);

MatchedPOIDzs(:,1)=poi1out(:,2);
MatchedPOIDzs(:,2)=poi1out(:,1);
% subpixel duzeltme sonu
hataliRegisterEdilebilecekSinirPixelSayisi = 3;

% warping yaparken edgeler sorun olusturur. bu yuzden smoothing
% yapilmasinda fayda var.

% bu smothingin sonuclari tezde gosterilebilir.
%  hsize = [7 7];
%  h = fspecial('gaussian', hsize, 2.7);
%  imgauss1 = imfilter(imgauss1,h,'replicate');
%  imgauss2 = imfilter(imgauss2,h,'replicate');

[alt,yan] = size(imgauss1);
farkResmindeDegerlendirilecekCerceve = zeros(alt,yan);


% bu cerceve video nun kenarlarindaki sikintilardan kurtulmak icin
% tanimlandi.
    for i=8:alt-8
        for j=20:yan-20
        farkResmindeDegerlendirilecekCerceve(i,j) = 1;
        end
    end
            


finalPositiveDifImage = zeros(alt,yan);
finalNegativeDifImage = zeros(alt,yan);

H = zeros(3,3);

if (warpingBasariliMi == 1)

    estimate = ones(3,1);

    [xs1, xs2] = CevirParcala(MatchedPOIDzs);

    H = vgg_H_from_x_lin(xs1,xs2);


    H_inv = inv(H);

    [m,n] = size(imgauss2);
    registeredImage = zeros(m,n);



    for i=1:m
        for j=1:n

            estimate = H_inv*[j;i;1];

            estimate = estimate / estimate(3);
            x1 = ceil(estimate(1));
            y1 = ceil(estimate(2));
            x1fark = x1 - estimate(1);
            y1fark = y1 - estimate(2);

            if ( (x1>1) && (y1>1)...
                    && (x1<n-1) && (y1<m-1) )
               
                %   && ( (y1 > alt/8 +5) || (x1 > yan /6 + 15) )
                % sembolojinin oldugu yerler bir onceki frameden alinir.
                % Boyle difference imageda 0 fark elde edilir.
               
                value1 = imgauss1(y1-1,x1-1)*x1fark + imgauss1(y1-1,x1)*(1-x1fark);
                value2 = imgauss1(y1,x1-1)*x1fark + imgauss1(y1,x1)*(1-x1fark);

                value = value1*y1fark + value2*(1-y1fark);

                registeredImage(i,j) = value;
            else
                % 2 frame arasi death bolge ve yukaridaki pixel sayisi
                % kadarlik alan sifirlanir.
                % registration kalitesi bu alanda kotu oldugundan dolayi,
                % hareketli obje sinirlarda aranmaz.
                
                registeredImage(i,j) = imgauss2(i,j);
            end
        end
    end
    difImage = imgauss2 - registeredImage;

   difImage = difImage .* farkResmindeDegerlendirilecekCerceve;
    
   % imshow(difImage);

    %---- farkli therehold ayarlamak icin
%     eksiFarkResmi = zeros(alt,yan);
%     artiFarkResmi = zeros(alt,yan);
% 
% 
%     for i=1:alt
%         for j=1:yan
% 
%             if (difImage(i,j) < 0)
% 
%                 eksiFarkResmi(i,j) = abs(difImage(i,j) );
%             else
% 
%                 artiFarkResmi(i,j) = difImage(i,j);
%             end
%         end
%     end
% 
% 
%     binaryThresholdPos = graythresh(artiFarkResmi);
%     binaryThresholdNeg = graythresh(eksiFarkResmi);
    %--------------------------------


%     imshow(imcomplement(abs(difImage)));

   


% bu blok 2 kademe ransac icin cout edildi.
    binaryThreshold = graythresh(abs(difImage));

    binaryThreshold = 0.11;
    
    positiveDifImage = zeros(alt,yan);
    negativeDifImage = zeros(alt,yan);

    for i=1:alt
        for j=1:yan

            % bu if check sembolojiyi siler.
            %if ( (i > alt/8 +5) || (j > yan /6) )
                if (difImage(i,j)>= binaryThreshold)
                    positiveDifImage(i,j) = 1;
                elseif (difImage(i,j) < -binaryThreshold)
                    negativeDifImage(i,j) = 1;
                end
           % end
        end
    end

    se = strel('disk',rclose);

    % zaten 1 ve 0lardan olusmaktaydi. Cok gerek yok.
    positiveDifImage = im2bw(positiveDifImage,0.5);
    negativeDifImage = im2bw(negativeDifImage,0.5);

    %imview(negativeDifImage);

    se2 = strel('disk',ropen);
    % edgeler silinir.
    openedPositiveDifImage = imopen(positiveDifImage,se2);
    openedNegativeDifImage = imopen(negativeDifImage,se2);
    
    
    
    % bosluklar doldurulur.
    closedPositiveDifImage = imclose(openedPositiveDifImage,se);
    closedNegativeDifImage = imclose(openedNegativeDifImage,se);




%     finalPositiveDifImage = imclose(finalPositiveDifImage,se);
%     finalNegativeDifImage = imclose(finalNegativeDifImage,se);

 %   imview(finalNegativeDifImage);

% negatif ve pozitif image da bloblar yakýn olmasi gerektiginden iki resim
% en hizli arac hareketi kadarlik diskle imclose edilir sonra carpilirç
% bu yontemden tezde bahset, farkli oldu bu cunku.
 
 antiBlobKadarGenisPositiveDifImage = closedPositiveDifImage;
 antiBlobKadarGenisNegativeDifImage = closedNegativeDifImage;
 
 se3 = strel('disk',20);
 antiBlobKadarGenisPositiveDifImage = imdilate(closedPositiveDifImage,se3);
 antiBlobKadarGenisNegativeDifImage = imdilate(closedNegativeDifImage,se3);

 finalPositiveDifImage = closedPositiveDifImage .* antiBlobKadarGenisNegativeDifImage;
 finalNegativeDifImage = closedNegativeDifImage .* antiBlobKadarGenisPositiveDifImage;

    difImage = abs(difImage);

    tersdifImage = imcomplement(difImage);
end


