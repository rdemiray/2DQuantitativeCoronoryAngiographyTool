function [birinciVektorDzs, ikinciVektorDzs] = CevirParcala(tersRowVektorDzs)

% y1 x1 y1' x1'        
% y2 x2 y2' x2'      
% y3 x3 y3' x3'          den       x1 x2 x3 x4 x5  ve   x1' x2' x3' x4' x5'  elde edilir.   
% y4 x4 y4' x4'                    y1 y2 y3 y4 y5       y1' y2' y3' y4' y5'
% 
% y5 x5 y5' x5'

[m,n] = size(tersRowVektorDzs);
% n 4 olmalý.




tempVektorDzs = zeros(m,2);
tersRowVektorDzs1 = zeros(m,2);
tersRowVektorDzs2 = zeros(m,2);
birinciVektorDzs = zeros(2,m);
ikinciVektorDzs = zeros(2,m);


tersRowVektorDzs1 = tersRowVektorDzs(:,1:1:2);
tersRowVektorDzs2 = tersRowVektorDzs(:,3:1:4);


tempVektorDzs(:,:) = tersRowVektorDzs1(:,end:-1:1);
birinciVektorDzs = tempVektorDzs';


tempVektorDzs(:,:) = tersRowVektorDzs2(:,end:-1:1);
ikinciVektorDzs = tempVektorDzs';
