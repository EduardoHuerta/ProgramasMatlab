imc=imread('coca1.jpeg');
img=double(rgb2gray(imc));
template = img(640:640+130,370:370+200);
imshow(template,[])
c = normxcorr2(template,img);
figure, surf(c), shading flat

[ypeak, xpeak] = find(c==max(c(:)));
yoffSet = ypeak-size(template,1);
xoffSet = xpeak-size(template,2);
figure
imshow(imc);
imrect(gca, [xoffSet+1, yoffSet+1, size(template,2), size(template,1)]);
