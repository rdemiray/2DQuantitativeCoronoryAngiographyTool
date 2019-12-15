 function [positiveImage, negativeImage, H, warpingBasariliMi] = BulPositiveNegativeDifImage(im1, im2, ropen, rclose,firstRansacIterNumber, ransacIterNumber)

warpingBasariliMi = 0;

% mhrrm: Videodan frame alýnmýþ, bizim buna ihtiyacýmýz yok.
% % deinterlace
%  im1(:,:,:) = imaj1(1:2:end,:,:);
%  im2(:,:,:) = imaj2(1:2:end,:,:);
 

 
imTestRgb1= im1;
imTestRgb2= im2; 

% burada adi gaussian ve median filtreleme olmalý
imgauss1=YapGaussianFiltreleme(im1);
imgauss2=YapGaussianFiltreleme(im2);



[poi1] = BulUniformHarrisCorners(imgauss1, imTestRgb1);
[poi2] = BulUniformHarrisCorners(imgauss2, imTestRgb2);



[MatchedPOIlerDzs] = BulMatchedPOIler(imgauss1, imgauss2, poi1, poi2);


% bu fonksiyon RANSAC uygulayarak filtreleme yapar.
FiltrelenmisMatchedPOIlerDzs = BulRansaclaFiltrelenmisMatchedPOIler(MatchedPOIlerDzs,firstRansacIterNumber);


%[HareketsizMatchedPOIlerDzs, warpingBasariliMi] = YapRansacPoiElemesi(FiltrelenmisMatchedPOIlerDzs, ransacIterNumber);


% bu fonksiyon 8 tane den H hesaplar.
[HareketsizMatchedPOIlerDzs, warpingBasariliMi] = YapRansacPoiElemesi(MatchedPOIlerDzs, ransacIterNumber);


%  burada adi ransacli iki framide goster olmalý
%  GosterRansacUygulanmisIkinciFramedekiPOIler(HareketsizMatchedPOIlerDzs,imgauss1, imgauss2, imTestRgb1);

[positiveImage, negativeImage, H] = BulRegisteredIkiFrameFarki(HareketsizMatchedPOIlerDzs, imgauss1, imgauss2, ropen, rclose, warpingBasariliMi); 


%IsleMotionChannel(motionChannel);







