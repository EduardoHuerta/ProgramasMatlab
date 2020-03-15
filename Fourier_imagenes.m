% Procesamiento en dominio de la frecuencia

Im = imread('lena.jpg');
Img = im2double(rgb2gray(Im));

% Img = zeros(400,400);
% Img(150:250,100:300)=1;

%Aplicamos transformada de Fourier (FFTW)
PQ = paddedsize(size(Img));
Img_F = fft2(double(Img), PQ(1), PQ(2)); %el resultado son numeros complejos
Img_F = fftshift(Img_F); % Centramos mayor frecuencia al centro
% Img_F = Img_F(2:size(Img,1)+1,2:size(Img,2)+1);
%En caso de separar parte real e imaginaria
freq = real(Img_F);
fase = imag(Img_F);

figure,
subplot(2,2,1)
imshow(Img)
title('Original')
subplot(2,2,2)
imshow(Img_F,[])
title('FFT')
subplot(2,2,3)
imshow(log(1+Img_F),[]) %Con transformación log para visualizar
title('FFT+log')
subplot(2,2,4)
imshow(log(1+fase),[])
title('fase+log')

%% Fase es necesaria para reconstrucción, sin ella información incompleta

Im = imread('lena.jpg');
Img = im2double(rgb2gray(Im));

PQ = paddedsize(size(Img));
Img_F = fft2(double(Img), PQ(1), PQ(2)); %el resultado son numeros complejos
Img_shift = fftshift(Img_F); % Centramos mayor frecuencia al centro, solo para visualizar

freq = real(Img_F);
fase = imag(Img_F);

Img_nofase = ifft2(freq);
Img_nofreq = ifft2(fase);
Img_out = ifft2(Img_F);
Img_nofase = Img_nofase(2:size(Img,1)+1,2:size(Img,2)+1);
Img_nofreq = Img_nofreq(2:size(Img,1)+1,2:size(Img,2)+1);
Img_out = Img_out(2:size(Img,1)+1,2:size(Img,2)+1);

figure,
subplot(2,2,1)
imshow(Img)
title('Original')
subplot(2,2,2)
imshow(Img_out,[0 1])
title('FFT full')
subplot(2,2,3)
imshow(Img_nofase,[0 1])
title('FFT solo magnitud')
subplot(2,2,4)
imshow(Img_nofreq,[])
title('FFT solo fase')

%% Intercambio de components en 2 imágenes

Im1 = imread('lena.jpg');
Img1 = im2double(rgb2gray(Im1));
Im2 = imread('baboon.png');
Img2 = im2double(rgb2gray(Im2));

PQ = paddedsize(size(Img1)); %Padding
Img_F1 = fft2(double(Img1), PQ(1), PQ(2)); % Transformada de Fourier
Img_F2 = fft2(double(Img2), PQ(1), PQ(2));
Img_F1 = fftshift(Img_F1); %centrado de frecuencias
Img_F2 = fftshift(Img_F2);

freq1 = real(Img_F1); %Separación de freq y fase
fase1 = imag(Img_F1);
freq2 = real(Img_F2);
fase2 = imag(Img_F2);

Img_comp1 = complex(freq1,fase2); % Juntando freq y fase para formar complejos
Img_comp2 = complex(freq2,fase1);
Img_comp1 = ifftshift(Img_comp1); % Antes de inversa revertimos centrado de frecuencias
Img_comp2 = ifftshift(Img_comp2);

Img_out1 = ifft2(Img_comp1); %Inversa de FFT
Img_out2 = ifft2(Img_comp2);
Img_out1 = Img_out1(2:size(Im1,1)+1,2:size(Im1,2)+1); %Quitamos padding
Img_out2 = Img_out2(2:size(Im2,1)+1,2:size(Im2,2)+1);

figure,
subplot(2,2,1)
imshow(Img1)
title('Lena')
subplot(2,2,2)
imshow(Img2,[])
title('Baboon')
subplot(2,2,3)
imshow(Img_out1,[])
title('freq Lena fase baboon')
subplot(2,2,4)
imshow(Img_out2,[])
title('freq baboon fase lena')

%% Cambio de fase aplicado en 3 canales para visualizar color

Im1 = imread('lena.jpg');
% Img1 = im2double(rgb2gray(Im1));
Im2 = imread('baboon.png');
% Img2 = im2double(rgb2gray(Im2));
PQ = paddedsize(size(Im1)); %Padding
Img_F1 = fft2(double(Im1), PQ(1), PQ(2)); % Transformada de Fourier
Img_F2 = fft2(double(Im2), PQ(1), PQ(2));
Img_F1 = fftshift(Img_F1); %centrado de frecuencias
Img_F2 = fftshift(Img_F2);
freq1 = real(Img_F1); %Separación de freq y fase
fase1 = imag(Img_F1);
freq2 = real(Img_F2);
fase2 = imag(Img_F2);

Img_comp1 = complex(freq1,fase2); % Juntando freq y fase para formar complejos
Img_comp2 = complex(freq2,fase1);
Img_comp1 = ifftshift(Img_comp1); % Antes de inversa revertimos centrado de frecuencias
Img_comp2 = ifftshift(Img_comp2);
Img_out1 = ifft2(Img_comp1); %FFT Inversa
Img_out2 = ifft2(Img_comp2);
Img_out1 = Img_out1(2:size(Im1,1)+1,2:size(Im1,2)+1,:); %Quitamos padding
Img_out2 = Img_out2(2:size(Im2,1)+1,2:size(Im2,2)+1,:);

figure,
subplot(2,2,1)
imshow(Im1)
title('Lena')
subplot(2,2,2)
imshow(Im2,[])
title('Baboon')
subplot(2,2,3)
imshow(uint8(Img_out1),[])
title('freq Lena fase baboon')
subplot(2,2,4)
imshow(uint8(Img_out2),[])
title('freq baboon fase lena')

%% filtrado con propiedad de convolución,

f = imread('lena.jpg');
f = im2double(rgb2gray(f));
% f = im2double(rgb2gray(f));

h = fspecial('motion',20,45);
% h = fspecial('laplacian',0.3);
% h = fspecial('sobel'); %Sobel, gradiente x
% h = ones(11).*121;
% h = fspecial('log',11,3);
% h = fspecial('disk',9);

PQ = paddedsize(size(f));
F = fft2(double(f), PQ(1), PQ(2));
H = fft2(double(h), PQ(1), PQ(2));
F_fH = H.*F;
ffi = ifft2(F_fH);
ffi = ffi(2:size(f,1)+1,2:size(f,2)+1);

figure,
subplot(2,3,1)
imshow(f)
title('Original espacio')
subplot(2,3,2)
surf(h)
title('Filtro espacio')
subplot(2,3,3)
imshow(ffi,[])
title('Imagen filtrada espacio')
subplot(2,3,4)
imshow(log(1+fftshift(F)),[])
title('Original frecuencia')
subplot(2,3,5)
imshow(log(1+fftshift(H)),[])
title('Filtro frecuencia')
subplot(2,3,6)
imshow(log(1+fftshift(F_fH)),[])
title('Imagen filtrada frecuencia')


%% filtrado en frecuencia 

f = imread('halftone.png');
f = im2double((f));


PQ = paddedsize(size(f));
F = fft2(double(f), PQ(1), PQ(2));
F1 = fftshift(F); %centrado de frecuencias

% H = zeros(size(F1));
% xc = ceil(PQ(1)/2); yc = ceil(PQ(2)/2);
% H(xc-100:xc+100,yc-100:yc+100) = 1;

% H = fspecial('gaussian',[PQ(1) PQ(2)],60);
H = fspecial('log',[PQ(1) PQ(2)],50);
H =(H-min(H(:)))./( max(H(:)) - min(H(:)) );


F_fH = H.*F1;
F_fH = ifftshift(F_fH); % Antes de inversa revertimos centrado de frecuencias
ffi = ifft2(F_fH);
ffi = ffi(2:size(f,1)+1,2:size(f,2)+1);

figure,
subplot(2,2,1)
imshow(f)
title('Original espacio')
subplot(2,2,2)
imshow(ffi,[])
title('Imagen filtrada espacio')
subplot(2,2,3)
F1 =(F1-min(F1(:)))./( max(F1(:)) - min(F1(:)) );
imshow(log(1+F1),[])
title('Original frecuencia')
subplot(2,2,4)
imshow(log(1+fftshift(F_fH)),[])
title('Imagen filtrada frecuencia')

%% %% filtrado en frecuencia 

f = imread('halftone.png');
f = im2double((f));


PQ = paddedsize(size(f));
F = fft2(double(f), PQ(1), PQ(2));
F1 = fftshift(F); %centrado de frecuencias

% H = zeros(size(F1));
% xc = ceil(PQ(1)/2); yc = ceil(PQ(2)/2);
% H(xc-100:xc+100,yc-100:yc+100) = 1;

x=zeros(size(F1));
x(F1>1000 & F1<10000) = 1;

H = fspecial('gaussian',[PQ(1) PQ(2)],80);
H =(H-min(H(:)))./( max(H(:)) - min(H(:)) );
H(H>0.1)=1; %máscara para no tocar componente DC
H = abs(1-H);
x=x.*H; %Máscara de puntos a reducir
SE = strel('disk',7);
% x = imdilate(x,SE);
x = abs(1-x);

F_fH = x.*F1;
F_fH = ifftshift(F_fH); % Antes de inversa revertimos centrado de frecuencias
ffi = ifft2(F_fH);
ffi = ffi(2:size(f,1)+1,2:size(f,2)+1);

figure,
subplot(2,2,1)
imshow(f)
title('Original espacio')
subplot(2,2,2)
imshow(ffi,[])
title('Imagen filtrada espacio')
subplot(2,2,3)
imshow(log(1+F1),[])
title('Original frecuencia')
subplot(2,2,4)
imshow(log(1+fftshift(F_fH)),[])
title('Imagen filtrada frecuencia')
