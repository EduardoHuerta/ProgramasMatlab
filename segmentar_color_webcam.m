
cam = webcam;
cam.Resolution = '640x360';
A = snapshot(cam);
frameSize = size(A);
videoPlayer = vision.VideoPlayer('Position', [100 100 [frameSize(2), frameSize(1)]+30]);
runLoop = true;
numPts = 0;
frameCount = 0;

while runLoop

    % Get the next frame.
    A = snapshot(cam);
    frameCount = frameCount + 1;

    A_lab=rgb2lab(A); %conversión con espacio Lab
    labb=A_lab(:,:,3); %tomamos canal b (positivos amarillo, negativos azules)
    laba=A_lab(:,:,2); %Tomamos canal a (verdes y rojos)
    z=zeros(size(labb));
    z(laba>0 & laba>abs(labb))=1; %máscara de tonos principalmente amarillos
    new_a=laba;
    new_a(z==1)=labb(z==1); %ponemos valores marcados de b en a
    new_a(z==1)=new_a(z==1)*(-1); %Invertimos valores marcados de a
    A_lab(:,:,3)=labb; %Canal b modificado lo guardamos en imagen Lab
    A_lab(:,:,2)=new_a;
    A=lab2rgb(A_lab); %Conversión a RGB
    
    % Display the annotated video frame using the video player object.
    step(videoPlayer, A);
    % Check whether the video player window has been closed.
    runLoop = isOpen(videoPlayer);
end

% Clean up.
clear cam;
release(videoPlayer);
