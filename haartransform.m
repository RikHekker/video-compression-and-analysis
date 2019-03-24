clear all; close all;
lena=double(imread('lena.pgm'));

n=8;
K=2^n;
stepsize=1;

N=8;
h(1,:)=1/sqrt(N)*ones(1,N);

for k=1:7
    p=floor(log2(k));
    q=k-2^p+1;
    for x=0:N-1
        if (q-1)/2^p <= x/N <(q-0.5)/2^p
            h(k+1,x+1)=2^(p/2)/sqrt(N);
        elseif (q-0.5)/2^p <= x/N <q/2^p
            h(k+1,x+1)=-2^(p/2)/sqrt(N);
        else
            h(k+1,x+1)=0;
        end
    end
end

for j=1:N:512
    j
    for k=1:N:512
        block=lena(j:j+7,k:k+7);
        block=h*block;
        %quantizer
        for i=1:numel(block) %loop over all the elements in the lena matrix
            qindex=idivide(block(i),int32(stepsize)); %quantize
            quantized(i)=(qindex+0.5)*stepsize; %get new values
        end
        quantized=double(reshape(quantized,[N,N]));%shape it back into the original form

        newblock=inv(h)*quantized;
        new(j:j+7,k:k+7)=newblock;
    end
end
test=new;
%show the new picture
new=mat2gray(new);
figure
imshow(new);
