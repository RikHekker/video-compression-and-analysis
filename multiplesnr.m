hb=load('haarSNRbutterfly.mat');
db=load('DCTSNRbutterfly.mat');
dc=load('DCTSNRcamera.mat');
hc=load('haarSNRcamera.mat');

figure
hold on
plot(hb.SNRplot,Klist)
hold on
plot(hc.SNRplot,Klist)
hold on
plot(db.SNRplot,Klist)
hold on
plot(dc.SNRplot,Klist)
legend("haartransform butterfly", "haartransform cameraman", "DCT butterfly", "DCT cameraman")
xlabel("SNR [dB]")
ylabel("# quantizer levels")
