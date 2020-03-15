% Transformaciones de intensidad

Im = imread('lena.jpg');
Im = im2double(rgb2gray(Im));

% Imagen inversa
Im_neg = abs(1 - Im);

%Transformación logarítmica
Im_log = log(1+Im);
%Transformación antilogarítmica
Im_exp = exp(Im-1);
%Corrección gamma
Im_gamma1 = Im.^0.15;
Im_gamma2 = Im.^1.5;
Im_gamma3 = Im.^5;

figure,
subplot(2,2,1)
imshow(Im)
title('Original')
subplot(2,2,2)
imshow(Im_neg)
title('Inversa')
subplot(2,2,3)
imshow(Im_log)
title('Logarítmica')
subplot(2,2,4)
imshow(Im_exp)
title('antilogarítmica')

figure,
subplot(2,2,1)
imshow(Im)
title('Original')
subplot(2,2,2)
imshow(Im_gamma1)
title('gamma = 0.15')
subplot(2,2,3)
imshow(Im_gamma2)
title('gamma = 1.5')
subplot(2,2,4)
imshow(Im_gamma3)
title('gamma = 5')
%% Contrast stretching

Im = imread('low-contrast-ex-02.png');
Im = im2double(Im);
figure,
subplot(2,1,1)
imshow(Im)
title('Original')
%Apliquemos transformación gamma pero solo para los puntos mayores a r1 y
%menores a r2
L=255; %L-1
r1 = 64/L;
r2 = 192/L;

tempIm=zeros(size(Im));
tempIm(r1<Im & r2>Im)=Im(r1<Im & r2>Im);
tempIm = tempIm.^1.5;
Im(r1<Im & r2>Im)=tempIm(r1<Im & r2>Im);
subplot(2,1,2)
imshow(Im)
title('Contrast Stretching')

%% Ecualización de histograma
im1 = imread('university.png');

% im1 = imread('lowcontrastcolor2.jpg');
% im1=rgb2gray(im1);

im1=double(im1);
L=256;
%Obtenemos histograma
hist_a=zeros(L,1);
for i=0:255
    hist_a(i+1)=sum(sum(im1==i));
end
%calculamos FDP
p=hist_a./numel(im1);
%calculamos s=(L-1)*FDC(p)
s=(L-1)*cumsum(p);
%redondeamos a entero mas cercano
s=round(s);
%cambiamos valor en imagen con su nuevo valor
b=uint8(zeros(size(im1)));
for k=1:size(s,1)
    b(im1==k-1)=s(k);
end

%Obtenemos histograma de ecualización
hist_b=zeros(L,1);
for i=0:255
    hist_b(i+1)=sum(sum(b==i));
end

figure,
subplot(2,2,1)
imshow(uint8(im1))
title('Original')
subplot(2,2,2)
imshow(b,[0 255])
title('Eq. hist')
subplot(2,2,3)
bar(hist_a)
title('Histograma')
subplot(2,2,4)
bar(hist_b)
title('Histograma')

%% Ecualización de histograma color
clear all

im1 = imread('lowcontrastcolor.jpg');
R=im1(:,:,1);
G=im1(:,:,2);
B=im1(:,:,3);
R=histeq(R);
G=histeq(G);
B=histeq(B);
im2=zeros(size(im1));
im2(:,:,1)=R;
im2(:,:,2)=G;
im2(:,:,3)=B;

figure,
subplot(1,2,1)
imshow(uint8(im1))
title('Original')
subplot(1,2,2)
imshow(uint8(im2))
title('Ecualizada')