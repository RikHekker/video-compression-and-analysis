clear all; close all;
lena=double(imread('cameraman.pgm'));

%run de DCT script for differnt bit rates (n) make an snr plot an collect
%al the pictures
SNRplot=[]; %initialize empty arrays for ease of plotting later
Klist=[];
total=[];
for n=1:1:8
    run("haartransform") 
    SNRplot=[SNRplot SNR];
    Klist=[Klist 2^n];
    total=[total, new];
end

%plot the snr curve
figure
plot(SNRplot,Klist)
xlabel("SNR [dB]")
ylabel("# quantizer levels")

%plot the pdfs
figure
histogram(pdfhigh)
title("haartransfor high frequency pdf")
figure
histogram(pdflow)
title("haartransfor low frequency pdf")

%show the all the pictures in sussesion in one plot
figure
total=mat2gray(total);
imshow(total);
