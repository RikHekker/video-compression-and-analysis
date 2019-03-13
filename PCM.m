clear all; close all;
%hyper parameters
stepsize=10;
lena=imread('lena.pgm'); %load the test picture

%odd uniform quantizer
for i=1:numel(lena) %loop over all the elements in the lena matrix
    qindex=idivide(lena(i),stepsize); %rounded to the nearest interger
    lena(i)=qindex*stepsize;
end

%show the new picture
lena=mat2gray(lena);
figure
imshow(lena)
