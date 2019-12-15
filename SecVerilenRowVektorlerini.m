function [secmeVektorDzs] = SecVerilenRowVektorlerini(rowVektorleriDzs, rowIndexDzs)

[m,n] = size(rowIndexDzs);
[toplamVektorSayisi, rowVektorBoyutu] = size(rowVektorleriDzs);

%burda m 1 olmali. n<toplamVektorSayisi olmali.

secmeVektorDzs = zeros(n,rowVektorBoyutu);

for i=1:n
    secmeVektorDzs(i,:) = rowVektorleriDzs(rowIndexDzs(i),:); 
end

    

