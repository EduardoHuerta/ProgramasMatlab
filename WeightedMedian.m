function k=WeightedMedian(H,I) %H matriz datos
h(:,1)=I(:);
h(:,2)=H(:);
sumT_w = sum(h(:,2))/2;
[~,d2] = sort(h(:,1));
x=h(d2,:);
sum_w=0;
k=1;
while sum_w <= sumT_w
   sum_w=sum_w+x(k,2);
   k=k+1;
end
k=h(k-1,1);