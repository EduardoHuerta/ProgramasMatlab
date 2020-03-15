function wmed = WeightedMedian2(I,H)
x = I(:);
w = H(:);
[sortx,order] = sort(x);
sortw = w(order);

midpoint = sum(sortw)/2;
csumw = cumsum(sortw); %suma acumulada
j = find(csumw<=midpoint,1,'last'); %encontrar el punto medio o el mas cercano
if isempty(j) %Caso particular si el primero valor es mayor a la mitad del peso
    j=1;
end
if csumw(j) == midpoint
wmed = mean(sortx([j j+1]));
else
wmed = sortx(j+1);
end