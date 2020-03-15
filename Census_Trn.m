function C=Census_Trn(a,p)
if length(size(a))==3
    a=rgb2gray(a);
end
z=(p*p)-1;
p=floor(p/2);
a=a+0.001;
[m,n]=size(a);
C=zeros(m,n);
for x=-p:1:p
    for y=-p:1:p
        if ~(x==0 && y==0)
        z=z-1;
        b = circshift(a,[x y]);
        b=logical(floor(a./b));
        b=b.*2^z;
        C=C+b;
        end
    end
end
