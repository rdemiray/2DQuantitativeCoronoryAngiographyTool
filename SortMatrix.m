function [indexMatrix] = SortMatrix(A)

% input olarak  girilen A matrix siralanir. matrixteki her elementin yeri
% outputta belirtilir.Buyukten kucuge dogru siralanir.
[m, n] = size(A);

[deger,ind] = sort(A(:));

dimension = m*n;
indexMatrix=zeros(dimension,2);

for i=1:dimension   
    remaining = mod(ind(i),m);
    if (remaining == 0)
    indexMatrix(i,1) = m;
    else
    indexMatrix(i,1) = remaining;
    end
    indexMatrix(i,2) = ceil(ind(i)/m) ;
end

%ters cevirirken dikkat etmek lazým.
indexMatrix=indexMatrix(end:-1:1,:);