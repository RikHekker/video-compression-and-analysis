clear all; close all;
lena=imread('lena.pgm');
original=im2double(lena);

change="rotate";
h=0.1; %brightness
c=0.1; %contrast

SNRplot=[];
Klist=[];
total=[];
for n=1:1:8
    run("DCT") 
    SNRplot=[SNRplot SNR];
    Klist=[Klist 2^n];
    total=[total, changed];
end

figure
plot(SNRplot,Klist)
xlabel("SNR [dB]")
ylabel("# quantizer levels")

%show the new picture
figure
imshow(total);
