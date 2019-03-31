clear all; close all;
%load lena as doubles
lena=imread('lena.pgm');
original=im2double(lena);

change="rotate"; %chose from bright, contrast or rotate
h=2; %brightness
c=1.5; %contrast

%run de DCT script for differnt bit rates (n) make an snr plot an collect
%al the pictures
SNRplot=[]; %initialize empty arrays for ease of plotting later
Klist=[];
total=[];
for n=1:1:8
    run("DCT") 
    SNRplot=[SNRplot SNR];
    Klist=[Klist 2^n];
    total=[total, changed];
end

%plot the snr curve
figure
plot(SNRplot,Klist)
xlabel("SNR [dB]")
ylabel("# quantizer levels")

%show the all the pictures in sussesion in one plot
figure
imshow(total);
