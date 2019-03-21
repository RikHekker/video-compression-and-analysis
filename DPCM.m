% clear all;close all;
% lena=double(imread('lena.pgm'));
% original=lena;
% 
% %odd uniform quantizer
K=2^n;
stepsize=255/K;
qindex(1)=0;
new1=0;
for i=1:numel(original) %loop over all the elements in the lena matrix
    qindex(i+1)=round(original(i)/stepsize)-qindex(i); %quantize
    new1(i+1)=(qindex(i+1)+qindex(i))*stepsize; %get new values
end
new=reshape(new1(2:end),[512,512]);


%SNR
SNR=snr(original,new-original);

