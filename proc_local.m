a=imread('lena.jpg');
img=double(rgb2gray(a));
img_out=zeros(size(img));
[filas,cols]=size(img);
K=11;
p=floor(K/2);
Vlocal=zeros(K);
tic
for x=1:filas
    for y=1:cols
        Vleft=x-p;
        Vright=x+p;
        Vup=y-p;
        Vdown=y+p;
        if Vleft<1
            Vleft=1;
        end
        if Vright>filas
            Vright=filas;
        end
        if Vup<1
            Vup=1;
        end
        if Vdown>cols
            Vdown=cols;
        end
        Vlocal = img(Vleft:Vright,Vup:Vdown);
        img_out(x,y) = kurtosis(Vlocal(:)); %mean mode, median, std, var, skewness, kurtosis, range
    end                     %eig, det (matrices cuadradas) moment(x,n)
end
toc
figure,
subplot(1,2,1)
imshow(uint8(img))
title('Original')
subplot(1,2,2)
imshow(img_out,[])
title('Procesada')

%% Con función nlfilter
a=imread('lena.jpg');
img=double(rgb2gray(a));
[m,n]=size(img);
tic
fun = @(x) max(x(:));
img_out = nlfilter(img,[15 15],fun);
toc
figure,
subplot(1,2,1)
imshow(uint8(img))
title('Original')
subplot(1,2,2)
imshow(img_out,[])
title('Procesada')

%% Filtro gaussiano
a=imread('lena.jpg');
img=im2double(rgb2gray(a));
[m,n]=size(img);

img_prom = conv2(img,ones(11)./121,'same');

h = fspecial('gaussian',11,2);
% img_gauss = conv2(img,h,'same');
img_gauss = imgaussfilt(img,'FilterSize',11);
% surf(h) para visualizar determinante

img_bil = imbilatfilt(img,'NeighborhoodSize',11);

figure,
subplot(2,2,1)
imshow(im2uint8(img))
title('Original')
subplot(2,2,2)
imshow(im2uint8(img_prom))
title('Promedio')
subplot(2,2,3)
imshow(im2uint8(img_gauss))
title('Gaussiano')
subplot(2,2,4)
imshow(im2uint8(img_bil))
title('Bilateral')

%% Filtros diversas características
a=imread('lena.jpg');
img=im2double((a));
[m,n]=size(img);

% filtro de entropía
img_ent = entropyfilt(rgb2gray(img),true(11));

% Patrones locales binarios
img_lbp=Census_Trn(img,3);

% Filtro laplaciano
img_lapl=locallapfilt(im2uint8(img),0.2,0.25);
entropy
figure,
subplot(2,2,1)
imshow(im2uint8(img))
title('Original')
subplot(2,2,2)
imshow(img_ent,[])
title('Entropia')
subplot(2,2,3)
imshow(img_lbp,[])
title('Patrones locales')
subplot(2,2,4)
imshow(img_lapl,[])
title('filtro laplaciano')
