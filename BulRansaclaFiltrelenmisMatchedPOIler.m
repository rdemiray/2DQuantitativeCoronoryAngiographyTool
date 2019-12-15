function [filtrelenmisMatchedPOIler] = BulRansaclaFiltrelenmisMatchedPOIler(MatchedPOIDzs, maxtries)

filtrelemeBasarisiz = 0;
mesafeThresh = 5;

[matchSayisi,dummy] = size(MatchedPOIDzs);
denemeSayisi = 0;

sonInliersSayisi = 0;
sonRandomSelIndex = 0;

while (denemeSayisi <= maxtries)

    randomIndex = ceil(rand*matchSayisi);

    yfarkRandom = MatchedPOIDzs(randomIndex,3) - MatchedPOIDzs(randomIndex,1);
    xfarkRandom = MatchedPOIDzs(randomIndex,4) - MatchedPOIDzs(randomIndex,2);



    inliers = 0;

    for i=1:matchSayisi

        yfark = MatchedPOIDzs(i,3) - MatchedPOIDzs(i,1);
        xfark = MatchedPOIDzs(i,4) - MatchedPOIDzs(i,2);

        if ( abs(xfark - xfarkRandom) < mesafeThresh)

            if  ( abs(yfark - yfarkRandom) < mesafeThresh)
                inliers = inliers + 1;
            end
        end
    end

    if (inliers > sonInliersSayisi)

        sonInliersSayisi = inliers;
        sonRandomSelIndex = randomIndex;
    end

    denemeSayisi = denemeSayisi + 1;
end



if (sonInliersSayisi > 100)



    yfarkRandom = MatchedPOIDzs(sonRandomSelIndex,3) - MatchedPOIDzs(sonRandomSelIndex,1);
    xfarkRandom = MatchedPOIDzs(sonRandomSelIndex,4) - MatchedPOIDzs(sonRandomSelIndex,2);

    inliers = 0;

    for i=1:matchSayisi

        yfark = MatchedPOIDzs(i,3) - MatchedPOIDzs(i,1);
        xfark = MatchedPOIDzs(i,4) - MatchedPOIDzs(i,2);

        if ( abs(xfark - xfarkRandom) < mesafeThresh)

            if  ( abs(yfark - yfarkRandom) < mesafeThresh)
                inliers = inliers + 1;
                filtrelenmisMatchedPOIler(inliers,:) = MatchedPOIDzs(i,:);
                
             
            end
           
        end
    end
    
    inliersfirstRansac = inliers
    matchSayisiFirstRansac = matchSayisi
else

    filtrelenmisMatchedPOIler = MatchedPOIDzs(i,:);

    filtrelemeBasarisiz
end

    
    
   