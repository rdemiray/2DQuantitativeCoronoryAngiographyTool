function [hareketsizMatchedPOIDzs, warpingBasariliMi] = YapRansacPoiElemesi(MatchedPOIDzs, maxtries)

gerekliMinInlierSayisi = 30;
warpingBasariliMi = 0;

[matchSayisi,dummy] = size(MatchedPOIDzs);

rowIndex = zeros(1,4);
inliersBelirlendi = 0;
denemeSayisi = 1;
secilmisCiftler = zeros(4,4);

ortalamaUzaklikDzs = zeros(maxtries,1);
HDzs = zeros(3,3,maxtries);
inliersSayisiDzs = zeros(maxtries,1);
    
while (denemeSayisi <= maxtries)

    randomIndex(1) = ceil(rand*matchSayisi);
    randomIndex(2) = ceil(rand*matchSayisi);
    randomIndex(3) = ceil(rand*matchSayisi);
    randomIndex(4) = ceil(rand*matchSayisi);
    
%     randomIndex(5) = ceil(rand*matchSayisi);
%     randomIndex(6) = ceil(rand*matchSayisi);
%     randomIndex(7) = ceil(rand*matchSayisi);
%     randomIndex(8) = ceil(rand*matchSayisi);
%         
    
    
    selectionCount=0;
    while ( ( (randomIndex(1) == randomIndex(2)) || (randomIndex(1) == randomIndex(3)) || (randomIndex(1) == randomIndex(4)) || (randomIndex(2) == randomIndex(3)) || (randomIndex(2) == randomIndex(4)) || (randomIndex(3) == randomIndex(4)) ) && (selectionCount<50) )
        randomIndex(1) = ceil(rand*matchSayisi);
        randomIndex(2) = ceil(rand*matchSayisi);
        randomIndex(3) = ceil(rand*matchSayisi);
        randomIndex(4) = ceil(rand*matchSayisi);
        selectionCount = selectionCount + 1;
    end


    % 8 tane row vektorunden olusur.
    secilmisCiftler = SecVerilenRowVektorlerini(MatchedPOIDzs, randomIndex);
    [xs1, xs2] = CevirParcala(secilmisCiftler);

    H = vgg_H_from_x_lin(xs1,xs2);

    %count inliers
    inliers = 0;
    toplamUzaklik = 0;

    for i=1:matchSayisi
        y=MatchedPOIDzs(i,1);
        x=MatchedPOIDzs(i,2);

        estimate = H*[x;y;1];

        estimate = estimate /estimate(3);


        uzaklikKaresi= (estimate(1)-MatchedPOIDzs(i,4) )^2 + (estimate(2)-MatchedPOIDzs(i,3) )^2;
        if (uzaklikKaresi < 10)

            toplamUzaklik = toplamUzaklik + uzaklikKaresi^0.5;

            inliers = inliers + 1;
            yedekhareketsizMatchedPOIDzs(inliers,1) = y;
            yedekhareketsizMatchedPOIDzs(inliers,2) = x;
            yedekhareketsizMatchedPOIDzs(inliers,3) = MatchedPOIDzs(i,3);
            yedekhareketsizMatchedPOIDzs(inliers,4) = MatchedPOIDzs(i,4);

        end
    end

    ortalamaUzaklikDzs(denemeSayisi) = toplamUzaklik/inliers;
    inliersSayisiDzs(denemeSayisi) = inliers;
    HDzs(:,:,denemeSayisi) = H;
    denemeSayisi = denemeSayisi + 1;

end

[degerler,sirasi] = sort(ortalamaUzaklikDzs);

hBulundu = 0;
for i=1:maxtries
   % burada h bulunamazsa inlier sayýsý therholdunu azalt.
    if ( (inliersSayisiDzs(sirasi(i)) > gerekliMinInlierSayisi) && (hBulundu == 0) )

        hBulundu = 1;
        H = HDzs(:,:,sirasi(i));
        inliersSayisiDzs(sirasi(i));
        warpingBasariliMi = 1;
    end
end

inliers = 0;

if (warpingBasariliMi == 1)
    for i=1:matchSayisi
        y=MatchedPOIDzs(i,1);
        x=MatchedPOIDzs(i,2);

        estimate = H*[x;y;1];

        estimate = estimate /estimate(3);


        uzaklikKaresi= (estimate(1)-MatchedPOIDzs(i,4) )^2 + (estimate(2)-MatchedPOIDzs(i,3) )^2;

        %kod kötü burda ama mesafe karesi yukarýyla ayný olmalý.
        if (uzaklikKaresi < 10)
            inliers = inliers + 1;
            yedekhareketsizMatchedPOIDzs(inliers,1) = y;
            yedekhareketsizMatchedPOIDzs(inliers,2) = x;
            yedekhareketsizMatchedPOIDzs(inliers,3) = MatchedPOIDzs(i,3);
            yedekhareketsizMatchedPOIDzs(inliers,4) = MatchedPOIDzs(i,4);

        end
    end
end

hareketsizMatchedPOIDzs = yedekhareketsizMatchedPOIDzs(1:inliers,:);


% H matrixi 8 tane poiden elde edilen matrixtir ve buyuk ihtimalle tek
% seferde elde edilir.

%%% aþaðýdaki parametreler ; konulmadýðý için workspace de çýktý olarak
%%% gözüküyor...

H
inliers
matchSayisi
