a=imread('color.jpg');
figure,
subplot(1,3,1)
imshow(a)
title('Original')
b=im2double(a); %Conversion de rango en imagen de 0 a 1
%Quitamos color  amarillo con espacio CMY
cmy=abs(1-b); % Conversión a espacio CMY
cmy(:,:,3)=0; % Quitamos todo color con componente amarillo
rgb=abs(1-cmy); %Conversión a RGB
subplot(1,3,2)
imshow(rgb)
title('Quitando color amarillo CMY')
%Quitamos color amarillo con espacio Lab
A_lab=rgb2lab(b); %conversión con espacio Lab
labb=A_lab(:,:,3); %tomamos canal b (positivos amarillo, negativos azules)
labb(labb>0)=0; %Valores positivos en b, los convertimos a cero
A_lab(:,:,3)=labb; %Canal b modificado lo guardamos en imagen Lab
A=lab2rgb(A_lab); %Conversión a RGB
subplot(1,3,3)
imshow(A)
title('Quitando color amarillo Lab')
%%
%Ejemplo quitar amarillo tratando no afectar otros tonos, esto es, valores
%en pixeles de canal a (verde o rojo dominante), que sean mayores a b, 
%el valor de b se deberá conservar
clear all
a=imread('color.jpg');
figure,
subplot(1,3,1)
imshow(a)
title('Original')
b=im2double(a);

A_lab=rgb2lab(b); %conversión con espacio Lab
labb=A_lab(:,:,3); %tomamos canal b (positivos amarillo, negativos azules)
laba=A_lab(:,:,2); %Tomamos canal a (verdes y rojos)
z=zeros(size(labb));
z(labb>0 & labb>abs(laba))=1; %máscara de tonos principalmente amarillos
labb(z==1)=0;
laba(z==1)=0;
A_lab(:,:,3)=labb; %Canal b modificado lo guardamos en imagen Lab
A_lab(:,:,2)=laba;
A=lab2rgb(A_lab); %Conversión a RGB

subplot(1,3,2)
imshow(z) %mostramos máscara detección amarillos
title('Pixeles amarillos')
subplot(1,3,3)
imshow(A)
title('Quitando color amarillo Lab')

%% Ahora reemplazaremos rojo por color verde
clear all
a=imread('peppers.png');
figure,
subplot(1,2,1)
imshow(a)
title('Original')
b=im2double(a);

A_lab=rgb2lab(b); %conversión con espacio Lab
labb=A_lab(:,:,3); %tomamos canal b (positivos amarillo, negativos azules)
laba=A_lab(:,:,2); %Tomamos canal a (verdes y rojos)
z=zeros(size(labb));
z(laba>0 & laba>abs(labb))=1; %máscara de tonos principalmente rojos
%A prueba y error definimos un valor para detectar amarillos pero no
%naranjas
%las tonalidades verdes son en canal a los valores negativos
new_a=laba;
% new_b=labb;

new_a(z==1)=labb(z==1); %ponemos valores marcados de b en a
% new_b(z==1)=labb(z==1); %ponemos valores marcados de a en b
new_a(z==1)=new_a(z==1)*(-1); %Invertimos valores marcados de a

A_lab(:,:,3)=labb; %Canal b modificado lo guardamos en imagen Lab
A_lab(:,:,2)=new_a;
A=lab2rgb(A_lab); %Conversión a RGB

subplot(1,2,2)
imshow(A)
title('Reemplazando por verdes')
%% Reemplazando verde por color rojo
clear all
a=imread('peppers.png');
figure,
subplot(1,2,1)
imshow(a)
title('Original')
b=im2double(a);

A_lab=rgb2lab(b); %conversión con espacio Lab
labb=A_lab(:,:,3); %tomamos canal b (positivos amarillo, negativos azules)
laba=A_lab(:,:,2); %Tomamos canal a (verdes negativos y rojos positivo)
z=zeros(size(labb));
z(laba<0 & labb>0)=1; %máscara de tonos principalmente verdes


%A prueba y error definimos un valor para detectar amarillos pero no
%naranjas
%las tonalidades verdes son en canal a los valores negativos
new_a=laba;
new_b=labb;

new_a(z==1)=labb(z==1); %ponemos valores marcados de b en a
new_b(z==1)=labb(z==1).*1.5; %ponemos valores marcados de a en b
new_a(z==1)=new_a(z==1); %Invertimos valores marcados de a

A_lab(:,:,3)=new_b; %Canal b modificado lo guardamos en imagen Lab
A_lab(:,:,2)=new_a;
A=lab2rgb(A_lab); %Conversión a RGB

subplot(1,2,2)
imshow(A)
title('Reemplazando verde por rojo')