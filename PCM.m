clear all; close all;
%hyper parameters
K=11;
stepsize=255/K;

%load the test picture
lena=double(imread('lena.pgm')); 
peppers=double(imread('peppers.pgm')); 
original=lena;

vector=original(:);
sigma_x=var(vector);
sigma_q=0;
pd=fitdist(vector,'normal');

%even uniform quantizer
for i=1:numel(original) %loop over all the elements in the lena matrix
    qindex=idivide(original(i),int8(stepsize)); %rounded to the nearest interger
    
    new(i)=(qindex+0.5)*stepsize;
end
new=reshape(new,[512,512])

%SNR
for x=0:255
    q=double((idivide(original(i),int8(stepsize))+0.5)*stepsize);
    sigma_q= sigma_q+(x-q).^2*pdf(pd,x);
end
SNR=10*log10(sigma_x^2/sigma_q^2);

%show the new picture
new=mat2gray(new);
figure
imshow(new);

