clear all; close all;
lena=imread('lena.pgm');
original=im2double(lena);

h=0; %brightness
c=0; %contrast

SNRplot=[];
Klist=[];
total=[];
for n=1:1:8
    run("DCT") 
    SNRplot=[SNRplot SNR];
    Klist=[Klist 2^n];
    total=[total, new];
end

figure
plot(SNRplot,Klist)
xlabel("SNR [dB]")
ylabel("# quantizer levels")

%show the new picture
figure
imshow(total);
