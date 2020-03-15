%% Espacio RGB
R=1:256;
R=repmat(R,256,1);
G=(1:256)';
G=repmat(G,1,256);
subplot(1,3,1);
R=uint8(R);
imshow(R)
title('R')
subplot(1,3,2);
G=uint8(G);
imshow(G);
title('G')
B=zeros(256,256)+128;
B=uint8(B);
subplot(1,3,3);
imshow(B);
title('B')
figure,
RGB=zeros(256,256,3);
RGB(:,:,1) = R;
RGB(:,:,2) = G;
RGB(:,:,3) = B;
RGB=uint8(RGB);
imshow(RGB)
title('Plano RG en un punto R')

%% Conversión a HSI, visualizar información y rangos

HSI=colorspace('RGB->HSI',RGB);
H=HSI(:,:,1); %Rango 0 a 360
S=HSI(:,:,2); %Rango 0 a 1
I=HSI(:,:,3); %Rango 0 a 1
figure,
subplot(1,3,1)
imshow(H,[0 360])
title('H')
subplot(1,3,2)
imshow(S,[0 1])
title('S')
subplot(1,3,3)
imshow(I,[0 1])
title('I')


%% Conversion a CIELab

LAB=colorspace('RGB->Lab',RGB);
L=LAB(:,:,1); %Rango 0 a 200 
A=LAB(:,:,2); %Rango verde a rojo
B=LAB(:,:,3); %Rango azul-amarillo
figure,
subplot(1,3,1)
imshow(L,[0 100])
title('L')
subplot(1,3,2)
imshow(A,[])
title('A')
subplot(1,3,3)
imshow(B,[])
title('B')

%% Ejemplo imagen a color
close all
clear all

A=imread('peppers.png');
R=A(:,:,1);
G=A(:,:,2);
B=A(:,:,3);

A_hsi=colorspace('RGB->HSI',A);
H=A_hsi(:,:,1);
S=A_hsi(:,:,2);
I=A_hsi(:,:,3);

A_lab=colorspace('RGB->Lab',A);
L=A_lab(:,:,1);
a=A_lab(:,:,2);
b=A_lab(:,:,3);

imshow(A)
title('Original')

figure,
subplot(3,3,1)
imshow(R)
title('Red')
subplot(3,3,2)
imshow(G)
title('Green')
subplot(3,3,3)
imshow(B)
title('Blue')

subplot(3,3,4)
imshow(H,[0 360])
title('Hue')
subplot(3,3,5)
imshow(S,[0 1])
title('Saturation')
subplot(3,3,6)
imshow(I)
title('Intensity')

subplot(3,3,7)
imshow(L,[0 100])
title('Luminance')
subplot(3,3,8)
imshow(a,[])
title('a-axis')
subplot(3,3,9)
imshow(b,[])
title('b-axis')

%% Ejemplo imagen a color (conversiones con funciones de MATLAB)
close all
clear all

A=imread('peppers.png');
R=A(:,:,1);
G=A(:,:,2);
B=A(:,:,3);

A_hsi = rgb2hsv(A);
H=A_hsi(:,:,1);
S=A_hsi(:,:,2);
I=A_hsi(:,:,3);

A_lab=rgb2lab(A);
L=A_lab(:,:,1);
a=A_lab(:,:,2);
b=A_lab(:,:,3);

imshow(A)
title('Original')

figure,
subplot(3,3,1)
imshow(R)
title('Red')
subplot(3,3,2)
imshow(G)
title('Green')
subplot(3,3,3)
imshow(B)
title('Blue')

subplot(3,3,4)
imshow(H,[0 1])
title('Hue')
subplot(3,3,5)
imshow(S,[0 1])
title('Saturation')
subplot(3,3,6)
imshow(I,[0 1])
title('Intensity')

subplot(3,3,7)
imshow(L,[0 100])
title('Luminance')
subplot(3,3,8)
imshow(a,[])
title('a-axis')
subplot(3,3,9)
imshow(b,[])
title('b-axis')