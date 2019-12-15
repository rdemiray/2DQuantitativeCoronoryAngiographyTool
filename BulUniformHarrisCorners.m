function [POIDzs] = BulUniformHarrisCorners(imgauss, imrgb)
%7*7 lik alanla harris measure yapilir.

hucreSayisi = 16;
hucredekiPoiSayisi = 15;
toplamPoiSayisi = hucredekiPoiSayisi*hucreSayisi;
 
%input olarak gaussian filtered image beklenir.
 [Ix,Iy]=gradient(imgauss);
 ortalama_mask=ones(7,7)/49;
 
 
 A(:,:,1)=conv2(Ix.^2,ortalama_mask,'same');
 A(:,:,4)=conv2(Iy.^2,ortalama_mask,'same');
 A(:,:,2)=conv2(Ix.*Iy,ortalama_mask,'same');
 A(:,:,3)=conv2(Ix.*Iy,ortalama_mask,'same');
 k=0.04;
 Mc=A(:,:,1)*0;
 Mc(:,:)=A(:,:,1).*A(:,:,4) - A(:,:,2).*A(:,:,3)-  k* (( A(:,:,1)+A(:,:,4) ).^2);
 
 Mc_im=imgauss*0;

 [alt,yan] = size(Mc);
 Mc_im = Mc*10^6;

 %burada alt ve yan degerleri orjinal imajin boyutlari.
 %Mc_im de orjinal imagela ayný boyutlarda


 Yedek_Mc_im = Mc_im;
 Poiler = zeros(alt,yan);
 

% % 7*7 lik alanda max. supression
% for i=4:1:alt-3
%     for j=4:1:yan-3
%         if ( (Mc_im(i,j) >= Mc_im(i-3,j-3)) && (Mc_im(i,j) >= Mc_im(i-3,j-2)) && (Mc_im(i,j) >= Mc_im(i-3,j-1)) && (Mc_im(i,j) >= Mc_im(i-3,j)) && (Mc_im(i,j) >= Mc_im(i-3,j+3)) && (Mc_im(i,j) >= Mc_im(i-3,j+2)) && (Mc_im(i,j) >= Mc_im(i-3,j+1)) && (Mc_im(i,j) >= Mc_im(i-2,j-3)) && (Mc_im(i,j) >= Mc_im(i-2,j-2)) && (Mc_im(i,j) >= Mc_im(i-2,j-1)) && (Mc_im(i,j) >= Mc_im(i-2,j)) && (Mc_im(i,j) >= Mc_im(i-2,j+3)) && (Mc_im(i,j) >= Mc_im(i-2,j+2)) && (Mc_im(i,j) >= Mc_im(i-2,j+1)) && (Mc_im(i,j) >= Mc_im(i-1,j-3)) && (Mc_im(i,j) >= Mc_im(i-1,j-2)) && (Mc_im(i,j) >= Mc_im(i-1,j-1)) && (Mc_im(i,j) >= Mc_im(i-1,j)) && (Mc_im(i,j) >= Mc_im(i-1,j+3)) && (Mc_im(i,j) >= Mc_im(i-1,j+2)) && (Mc_im(i,j) >= Mc_im(i-1,j+1)) && (Mc_im(i,j) >= Mc_im(i,j-3)) && (Mc_im(i,j) >= Mc_im(i,j-2)) && (Mc_im(i,j) >= Mc_im(i,j-1)) && (Mc_im(i,j) >= Mc_im(i,j+3)) && (Mc_im(i,j) >= Mc_im(i,j+2)) && (Mc_im(i,j) >= Mc_im(i,j+1)) && (Mc_im(i,j) >= Mc_im(i+1,j-3)) && (Mc_im(i,j) >= Mc_im(i+1,j-2)) && (Mc_im(i,j) >= Mc_im(i+1,j-1)) && (Mc_im(i,j) >= Mc_im(i+1,j)) && (Mc_im(i,j) >= Mc_im(i+1,j+3)) && (Mc_im(i,j) >= Mc_im(i+1,j+2)) && (Mc_im(i,j) >= Mc_im(i+1,j+1)) && (Mc_im(i,j) >= Mc_im(i+2,j-3)) && (Mc_im(i,j) >= Mc_im(i+2,j-2)) && (Mc_im(i,j) >= Mc_im(i+2,j-1)) && (Mc_im(i,j) >= Mc_im(i+2,j)) && (Mc_im(i,j) >= Mc_im(i+2,j+3)) && (Mc_im(i,j) >= Mc_im(i+2,j+2)) && (Mc_im(i,j) >= Mc_im(i+2,j+1)) && (Mc_im(i,j) >= Mc_im(i+3,j-3)) && (Mc_im(i,j) >= Mc_im(i+3,j-2)) && (Mc_im(i,j) >= Mc_im(i+3,j-1)) && (Mc_im(i,j) >= Mc_im(i+3,j)) && (Mc_im(i,j) >= Mc_im(i+3,j+3)) && (Mc_im(i,j) >= Mc_im(i+3,j+2)) && (Mc_im(i,j) >= Mc_im(i+3,j+1)) ) 
%              Poiler(i,j) = 1;
%         end
%     end
% end
   
% 5*5 lik alanda max. supression
for i=5:1:alt-4
    for j=5:1:yan-4
        if ( (Mc_im(i,j) >= Mc_im(i-2,j-2)) && (Mc_im(i,j) >= Mc_im(i-2,j-1)) && (Mc_im(i,j) >= Mc_im(i-2,j)) && (Mc_im(i,j) >= Mc_im(i-2,j+2)) && (Mc_im(i,j) >= Mc_im(i-2,j+1)) &&   (Mc_im(i,j) >= Mc_im(i-1,j-2)) && (Mc_im(i,j) >= Mc_im(i-1,j-1)) && (Mc_im(i,j) >= Mc_im(i-1,j)) && (Mc_im(i,j) >= Mc_im(i-1,j+2)) && (Mc_im(i,j) >= Mc_im(i-1,j+1)) &&            (Mc_im(i,j) >= Mc_im(i,j-2)) && (Mc_im(i,j) >= Mc_im(i,j-1)) && (Mc_im(i,j) >= Mc_im(i,j+2)) && (Mc_im(i,j) >= Mc_im(i,j+1)) &&            (Mc_im(i,j) >= Mc_im(i+1,j-2)) && (Mc_im(i,j) >= Mc_im(i+1,j-1)) && (Mc_im(i,j) >= Mc_im(i+1,j)) && (Mc_im(i,j) >= Mc_im(i+1,j+2)) && (Mc_im(i,j) >= Mc_im(i+1,j+1)) &&            (Mc_im(i,j) >= Mc_im(i+2,j-2)) && (Mc_im(i,j) >= Mc_im(i+2,j-1)) && (Mc_im(i,j) >= Mc_im(i+2,j)) && (Mc_im(i,j) >= Mc_im(i+2,j+2)) && (Mc_im(i,j) >= Mc_im(i+2,j+1)) )
            % burada sol ust kosedeki semboljiyi degerlendirme dedim.
            if ( (i > alt/8 +5) || (j > yan /6.4) )
                  Poiler(i,j) = 1;
            end
        end
    end
end


for i=1:alt
    for j=1:yan
        if (Poiler(i,j) == 0)
            Mc_im(i,j) = -50;
        end
    end
end


% altstep=ceil(alt/4)-3;
% yanstep=ceil(yan/4)-3;
% 
% baslangic1 =[5 5];
% baslangic2 = baslangic1 + [altstep 0];
% baslangic3 = baslangic2 + [altstep 0];
% baslangic4 = baslangic3 + [altstep 0];
% 
% baslangic5= baslangic1 + [0 yanstep];
% baslangic6= baslangic2 + [0 yanstep];
% baslangic7= baslangic3 + [0 yanstep];
% baslangic8= baslangic4 + [0 yanstep];
% 
% baslangic9= baslangic5+ [0 yanstep];
% baslangic10= baslangic6 + [0 yanstep];
% baslangic11= baslangic7 + [0 yanstep];
% baslangic12= baslangic8 + [0 yanstep];
% 
% baslangic13= baslangic9+ [0 yanstep];
% baslangic14= baslangic10 + [0 yanstep];
% baslangic15= baslangic11 + [0 yanstep];
% baslangic16= baslangic12 + [0 yanstep];
% 
% diag=[altstep yanstep];
% 
% POIDzs1 = BulSubPOIDzs(baslangic1,diag,hucredekiPoiSayisi, Mc_im);
% POIDzs2 = BulSubPOIDzs(baslangic2,diag,hucredekiPoiSayisi, Mc_im);
% POIDzs3 = BulSubPOIDzs(baslangic3,diag,hucredekiPoiSayisi, Mc_im);
% POIDzs4 = BulSubPOIDzs(baslangic4,diag,hucredekiPoiSayisi, Mc_im);
% POIDzs5 = BulSubPOIDzs(baslangic5,diag,hucredekiPoiSayisi, Mc_im);
% POIDzs6 = BulSubPOIDzs(baslangic6,diag,hucredekiPoiSayisi, Mc_im);
% POIDzs7 = BulSubPOIDzs(baslangic7,diag,hucredekiPoiSayisi, Mc_im);
% POIDzs8 = BulSubPOIDzs(baslangic8,diag,hucredekiPoiSayisi, Mc_im);
% POIDzs9 = BulSubPOIDzs(baslangic9,diag,hucredekiPoiSayisi, Mc_im);
% POIDzs10 = BulSubPOIDzs(baslangic10,diag,hucredekiPoiSayisi, Mc_im);
% POIDzs11 = BulSubPOIDzs(baslangic11,diag,hucredekiPoiSayisi, Mc_im);
% POIDzs12 = BulSubPOIDzs(baslangic12,diag,hucredekiPoiSayisi, Mc_im);
% POIDzs13 = BulSubPOIDzs(baslangic13,diag,hucredekiPoiSayisi, Mc_im);
% POIDzs14 = BulSubPOIDzs(baslangic14,diag,hucredekiPoiSayisi, Mc_im);
% POIDzs15 = BulSubPOIDzs(baslangic15,diag,hucredekiPoiSayisi, Mc_im);
% POIDzs16 = BulSubPOIDzs(baslangic16,diag,hucredekiPoiSayisi, Mc_im);

% POIDzs = [POIDzs1; POIDzs2; POIDzs3; POIDzs4; POIDzs5; POIDzs6; POIDzs7; POIDzs8; POIDzs9; POIDzs10; POIDzs11; POIDzs12; POIDzs13; POIDzs14; POIDzs15; POIDzs16];

% -------Hucrelere bolme olayi yok--------------------------------------
tumPOIDzs = SortMatrix(Mc_im);

POIDzs=zeros(toplamPoiSayisi,2);
POIDzs(:,:) = tumPOIDzs(1:toplamPoiSayisi,:);

% -----------------------------------------------------------------------

meanDzs=zeros(toplamPoiSayisi,1);
sigmaDzs=zeros(toplamPoiSayisi,1);
POIDzs=[POIDzs meanDzs sigmaDzs];

gorsel(:,:,3)=imgauss;
gorsel(:,:,2)=zeros(alt, yan); 
gorsel(:,:,1)=zeros(alt, yan); 


for poiSirasi=1:toplamPoiSayisi
    
    columnNo=POIDzs(poiSirasi,2);
    rowNo=POIDzs(poiSirasi,1);
    
    gorsel(rowNo,columnNo,1)=1;
    imrgb(rowNo,columnNo,1) = 255;
    imrgb(rowNo,columnNo,2) = 0;
    imrgb(rowNo,columnNo,3) = 0;
    
    totalIntensity = 0;
    totalIntensitySquare = 0;
    pixelCount = 0;

    for k=-4:4
        for l=-4:4
            %if ( ((rowNo+k) > 0) && ((columnNo+l) > 0 ) )
            totalIntensity = imgauss(rowNo+k,columnNo+l) + totalIntensity;
            totalIntensitySquare = totalIntensitySquare + imgauss(rowNo+k,columnNo+l)^2;
            pixelCount = pixelCount +1;
            %end
        end
    end

    mean=totalIntensity/pixelCount;
    sigma = (totalIntensitySquare/pixelCount - mean^2)^0.5;
    POIDzs(poiSirasi,3) = mean;
    POIDzs(poiSirasi,4) = sigma;
end

% mhrrm: POIDzs nin 3. elemanýna mean, 4. elemanýna sigma koyularak dýþarý
% veriliyor.

% POIDzs
% gorsel= im2double(gorsel);
% imview(gorsel);


%imview(imrgb);

   