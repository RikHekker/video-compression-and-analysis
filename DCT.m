%DCT
%get the whole image in block structures and then use dct
T=dctmtx(8);
dct=@(block_struct) T * block_struct.data * T';
B=blockproc(original,[8 8],dct);

pdfhigh=[];
pdflow=[];
K=2^n;
for j=1:8:size(lena) % for all block hights
    for k=1:8:size(lena) %for all block withs
        block=B(j:j+7,k:k+7); %get a block
        if change == "bright"
            block(1)=block(1)+h; %brightness
        end
        pdfhigh=[pdfhigh block(7,8)];
        pdflow=[pdflow block(3,2)];
        %quantizer
        maximum=max(block(:));
        minimum=min(block(:));
        stepsize=(maximum+abs(minimum))/K;
        for i=1:numel(block) %loop over all the elements in the block
            qindex(i)=round(block(i)/stepsize); %quantize
            quantized(i)=qindex(i)*stepsize; %get new values
        end
        quantized=double(reshape(quantized,[8,8]));%shape it back into the original block form
        new(j:j+7,k:k+7)=quantized; %put the blocks back in their appropriate place
    end
end

% changes from chapter 3
if change == "contrast"
    changed=new*c; %more contrast
elseif change == "rotate"
    for j=1:8:512
          for k=1:8:512
             block=new(j:j+7,k:k+7);
             rotateblock=block.';
             changed(k:k+7,j:j+7)=rotateblock;
         end
    end
else
    changed=new;
end


%IDCT
B2 = blockproc(changed,[8 8],@(block_struct) block_struct.data);
invdct = @(block_struct) T' * block_struct.data * T;
changed = blockproc(B2,[8 8],invdct);

%SNR
SNR=snr(original,changed-original);
