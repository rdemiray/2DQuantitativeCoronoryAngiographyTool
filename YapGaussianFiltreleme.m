function [imgauss] = YapGaussianFiltreleme(im)

% rgb resmi grayscale e çeviriyor, bizimki zaten grayscale.. 
 %im = rgb2gray(im);
 im = im2double(im);



 im = medfilt2(im);
 


 
 %im = histeq(im);
 % histeq islemi uygulanmamali. onsuz cok iyi sonuclar veriyo.
 
 hsize = [7 7];
 h = fspecial('gaussian', hsize, 0.5);
 imgauss = imfilter(im,h,'replicate');