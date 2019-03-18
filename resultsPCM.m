clear all; close all;
pic="peppers";
Klist=[2, 4, 8, 16, 32, 64, 128, 256];
SNRplot=0;
total=[];
for j=1:size(Klist,2)
    K=Klist(j);
    run("PCM.m")
    SNRplot=[SNRplot SNR];
    total=[total, new];
end

figure
plot(SNRplot(2:end),Klist)
xlabel("SNR [dB]")
ylabel("# quantizer levels")

%show the new picture
total=mat2gray(total);
figure
imshow(total);