I=imread('dog2.jpg');
I=imresize(I,0.5);
a=rgb2gray(I);
mask=zeros(size(a));
mask(20:end-20,20:end-20)=1;
bw = activecontour(a,mask,501);
imshow(bw)
bw=repmat(bw,1,1,3);
I2=I;
I2(bw==0)=0;
imshowpair(I,I2,'montage');
B=imread('grass.png');
t=B.*0;
t(size(bw))=bw;
t(t==1)=I2(bw==1);