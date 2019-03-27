K=2^n;
stepsize=400/K;
qindex(1)=0;
new1=0;
for i=1:numel(original) %loop over all the elements in the lena matrix
    diff(i)=original(i)-new1(i);
    qindex(i+1)=round(diff(i)/stepsize); %quantize
    if qindex(i+1)>K/2 % upper bound of the quantizer
        qindex(i+1)=K/2;
    elseif qindex<-K/2 %lower bound of the quantizer
        qindex(i+1)=-K/2;
    end
    new1(i+1)=qindex(i+1)*stepsize+new1(i); %get new values
end
new=reshape(new1(2:end),[512,512]);


%SNR
SNR=snr(original,new-original);

