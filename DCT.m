%DCT
T=dctmtx(8);
dct=@(block_struct) T * block_struct.data * T';
B=blockproc(original,[8 8],dct);

%odd uniform quantizer
K=2^n;
stepsize=8/K;
for i=1:numel(B) %loop over all the elements in the lena matrix
    qindex(i)=round(B(i)/stepsize); %quantize
    new1(i)=qindex(i)*stepsize; %get new values
end
new=reshape(new1,[512,512]);
new=new+h; %brightness
new=new*c; %more contrast


%IDCT
B2 = blockproc(new,[8 8],@(block_struct) block_struct.data);
invdct = @(block_struct) T' * block_struct.data * T;
new = blockproc(B2,[8 8],invdct);

%SNR
SNR=snr(original,new-original);
