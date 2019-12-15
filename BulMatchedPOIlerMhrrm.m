function [MatchedPOIlerDzs] = BulMatchedPOIlerMhrrm(imgauss1, imgauss2, POIDzs1, POIDzs2)

[alt, yan] = size(imgauss1);

kosegen = (alt^2 + yan^2)^0.5;

searchDistance = (kosegen/10)^2/2;


%output 4*N lik bir arraydir. N toplam matched POI sayýsý.
%MatchedPOIlerDzs(i,1) as y ve MatchedPOIlerDzs(i,2) as x ilk imagedaki pixel
%kordinatý, 3 ve 4 ise ikinci imgdaki poinin kordinatini belirtir.
% input olarak geklen POIDzs ise x, y, mean ve sigma degerlerini her bir
% rowda icerir.
% uygulanan yontem correlation.
% burada sadece yakýn bir alanda arama yapan algoritma yazýlabilir.
poiSayisiMatrix1 = size(POIDzs1);
poiSayisi1 = poiSayisiMatrix1(1);

poiSayisiMatrix2 = size(POIDzs2);
poiSayisi2 = poiSayisiMatrix2(1);

SimilarityMatrix = zeros(poiSayisi1,poiSayisi2);


for i=1:poiSayisi1
    for j=1:poiSayisi2
       

        %karsilastirilan poi1 =(a,b) poi2 = (c,d), imgauss uzerinde
        a = POIDzs1(i,2);
        b = POIDzs1(i,1);
        c = POIDzs2(j,2);
        d = POIDzs2(j,1);

        totalIntensityProduct = 0;
        %burada imgauss1(0,0) okumaya calisiyor diye hata veriyordu.
         
         % makalede 9*9 luk kullanilmis. Correlation alaný byuk olmalý.
         % burada Artýrýlmalý. Mean ve sigma degerlerini de poi tespiti sýrasýnda
         % otomatik olarak buluyoruz. O da 9*9 luk alan icinde
         % hesaplanmalý.
%-----------------------------------------------         
% % bu makalede anlatilan similarity olcumuydu yanlis sonuclar veriyor.
%         for k=-4:4
%             for l=-4:4
%                 if ( (a+k > 0) && (b+l) >0 )
%                     totalIntensityProduct = totalIntensityProduct + imgauss1(a+k,b+l)* imgauss2(c+k,d+l);
%                 end
%             end
%         end
% 
%         SimilarityMatrix(i,j) = (totalIntensityProduct-49*POIDzs1(i,3)*POIDzs2(j,3) ) / (POIDzs1(i,4)*POIDzs2(j,4) + eps);
%----------------------------------------------
        for k=-4:4
            for l=-4:4
                if ( (a+k > 0) && (b+l) >0 )
                    totalIntensityProduct = totalIntensityProduct + (imgauss1(a+k,b+l)-POIDzs1(i,3) ) * (imgauss2(c+k,d+l)-POIDzs2(j,3) );
                end
            end
        end

       SimilarityMatrix(i,j) = (totalIntensityProduct) / (POIDzs1(i,4)*POIDzs2(j,4) + eps);
    end
end



% burada searchDistance cozunurluge bagimli. SimilarityMatriz uzerinde uzak
% noktalar arasi benzerlik bastirilir.
for i=1:poiSayisi1
    for j=1:poiSayisi2
        
        if ( ( (POIDzs1(i,1) - POIDzs2(j,1) )^2 + (POIDzs1(i,2) - POIDzs2(j,2) )^2 ) > searchDistance)         
            
            SimilarityMatrix(i,j) = -500;
        end
    end
end



%prefered mate
% sagdaki i ninci  POI, sol resimden tempprefer üncü POI'yi tercih ediyor.
preferMateMatrix = zeros(poiSayisi1,poiSayisi2);

% right image :im2, POI2

[deger, rightprefers] = max(SimilarityMatrix);

[deger, leftprefers] = max(SimilarityMatrix');


MatchedPOICiftiSayisi=0;
for i=1:poiSayisi2
    tempprefer = rightprefers(i);
    if (leftprefers(tempprefer) == i)
        MatchedPOICiftiSayisi = MatchedPOICiftiSayisi + 1;
        
        MatchedPOIlerDzs(MatchedPOICiftiSayisi,1) = POIDzs1(tempprefer,1);
        MatchedPOIlerDzs(MatchedPOICiftiSayisi,2) = POIDzs1(tempprefer,2);
        MatchedPOIlerDzs(MatchedPOICiftiSayisi,3) = POIDzs2(i,1);
        MatchedPOIlerDzs(MatchedPOICiftiSayisi,4) = POIDzs2(i,2);
    end
end


%Ýkinci resimde olup, ilkle eslesen POIler
matchedGorsel2(:,:,3)=imgauss2;
matchedGorsel2(:,:,2)=0*imgauss2;
matchedGorsel2(:,:,1)=0*imgauss2;

%Ýkinci resimde olup, ilkle eslesen POIler
matchedGorsel1(:,:,3)=imgauss1;
matchedGorsel1(:,:,2)=0*imgauss1;
matchedGorsel1(:,:,1)=0*imgauss1;


for i=1:MatchedPOICiftiSayisi
    rowNo=MatchedPOIlerDzs(i,3);
    columnNo=MatchedPOIlerDzs(i,4);
    
    matchedGorsel2(rowNo,columnNo,1)=1;
    
    rowNo=MatchedPOIlerDzs(i,1);
    columnNo=MatchedPOIlerDzs(i,2);
    
    matchedGorsel1(rowNo,columnNo,1)=1;    
end

%imview(matchedGorsel2);
%imview(matchedGorsel1);