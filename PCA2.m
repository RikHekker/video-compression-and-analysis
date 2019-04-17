clear all; close all;
lena = imread('lena','pgm');
peppers= imread('peppers','pgm');

%fourier transform the images
flena = fft2(double(lena));
fpeppers = fft2(double(peppers));

%plot the magnitude and phase of both pictures
figure
imshow(abs(log(flena)),[])
figure
imshow(angle(log(flena)),[])
figure
imshow(abs(log(fpeppers)),[])
figure
imshow(angle(log(fpeppers)),[])

%make new images whit the magintude of one and pase of the other
f1 = abs(flena).*exp(1i*angle(fpeppers));
f2 = abs(fpeppers).*exp(1i*angle(flena));

%get the new images back in image space
im1 = ifft2(f1);
im2 = ifft2(f2);

%plot the new images
figure
imshow(abs(im1), [])
figure
imshow(abs(im2), [])
