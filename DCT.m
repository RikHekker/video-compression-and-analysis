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
if change == "bright"
    changed=new+h; %brightness
elseif change == "contrast"
    changed=new*c; %more contrast
elseif change == "rotate"
    for j=1:8:512
        for k=1:8
            changed(j+k-1,:)=new(j+8-k,:);
        end
%         for k=1:8:512
%             block=new(j:j+7,k:k+7);
%             rotateblock=block.';
%             changed(k:k+7,j:j+7)=rotateblock;
%         end
    end
end


%IDCT
B2 = blockproc(changed,[8 8],@(block_struct) block_struct.data);
invdct = @(block_struct) T' * block_struct.data * T;
changed = blockproc(B2,[8 8],invdct);

%SNR
SNR=snr(original,new-original);
