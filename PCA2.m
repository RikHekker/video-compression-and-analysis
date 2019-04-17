clear all; close all;
lena = imread('lena','pgm');
peppers= imread('peppers','pgm');

%fourier transform the images
flena = fft2(double(lena));
fpeppers = fft2(double(peppers));

%plot the magnitude and phase of both pictures
figure
imshow(log(1+abs(flena)),[])
figure
imshow(angle(flena),[])
figure
imshow(log(1+abs(fpeppers)),[])
figure
imshow(angle(fpeppers),[])

%make new images whit the magintude of one and pase of the other
f1 = abs(flena).*exp(1i*angle(fpeppers));
f2 = abs(fpeppers).*exp(1i*angle(flena));

%get the new images back in image space
im1 = ifft2(f1);
im2 = ifft2(f2);

%plot the new images
figure
imshow(abs(im1), [])
figure
imshow(abs(im2), [])


%begin pca
for i=1:1001
    point=randi([1,512-7],1,2);
    patch(:,:,i)=double(lena(point(1):point(1)+7,point(2):point(2)+7));
    matrix(i,:)=reshape(patch(:,:,i),1,[]);
end

%dc center
dc=mean2(matrix);
matrix=matrix-dc;
%normalize
std=std2(matrix);
matrix=matrix./std;

%plot the patches
for i=1:10
    figure
    patch2=mat2gray(patch(:,:,i)-dc./std);
    imshow(patch2)
end


matrix=cov(matrix);
[vector,value]=eig(matrix);
[d,ind] = sort(diag(value), 'descend');
value_sort = value(ind,ind);
vector_sort = vector(:,ind);

view=zeros(64,64);
n=1;
j=1;
for i=1:64
    components(:,:,i)=reshape(vector_sort(:,i),8,8);
    view(j:j+7,n:n+7)=components(:,:,i) ; 
    if n==57
        j=j+7;
        n=1;
    else
        n=n+7;
    end

end


imshow(view)
