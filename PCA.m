clear all; close all;
%lena
lena=double(imread('lena.pgm'));
fourierl=fft2(lena);
phasel=angle(fourierl);
amplitudel=abs(fourierl);
figure
imshow(fftshift(phasel),[])
figure
imshow(fftshift(amplitudel),[])

%lena
peppers=double(imread('peppers.pgm'));
fourierp=fft2(peppers);
phasep=angle(fourierp);
amplitudep=abs(fourierp);
figure
imshow(fftshift(phasep),[])
figure
imshow(fftshift(amplitudep),[])

%new pictures
pepna=ifft2(amplitudep.*exp(1i*phasel));
lepers=ifft2(amplitudel.*exp(1i*phasep));
figure
imshow(pepna)
figure
imshow(lepers)