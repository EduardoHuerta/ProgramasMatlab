A=double(rgb2gray(imread('lena.jpg')));
% A=double(rgb2gray(imread('C:\Users\alx34\Documents\MATLAB\whiteflies.jpg')));
% A=double(rgb2gray(a));
tic
w=10; %Mitad de ventana de procesamiento
[X,Y] = meshgrid(-w:w,-w:w);
% sigma_d = 10; %Valor solo válido para filtro bilateral
sigma_r = 25.5; %Valor para pesos exponenciales (gaussiano)
% G = exp(-(X.^2+Y.^2)/(2*sigma_d^2));
dim = size(A);
% B = zeros(dim);
B = A;
D = zeros(size(B));
for i = 1:dim(1)
   for j = 1:dim(2)
      
         % Extract local region.
         iMin = max(i-w,1);
         iMax = min(i+w,dim(1));
         jMin = max(j-w,1);
         jMax = min(j+w,dim(2));
         I = B(iMin:iMax,jMin:jMax);
      
         % Compute Gaussian intensity weights.
         H = exp(-(I-A(i,j)).^2/(2*sigma_r^2)); 
%          H = ones(size(H));
         % Calculate bilateral filter response.
%          F = H.*G((iMin:iMax)-i+w+1,(jMin:jMax)-j+w+1);
%          B(i,j) = sum(F(:).*I(:))/sum(F(:));
         
         % Obtener la mediana ponderada, si H = ones(dim(H)), es medfilt2
%          if i==10 && j==340
%              disp('pausa');
%          end
         k=WeightedMedian2(I,H);
          D(i,j)=k;
   end
end
toc
figure, imshow(D,[])