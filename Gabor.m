clear all; close all;
[X,Y]=meshgrid([-5:0.1:5]);
%plot the grid
figure
imagesc(X)
colorbar
figure
imagesc(Y)
colorbar

%hyperparameters
theta=-pi/4;
f0=0.3;
gamma=0.4;
eta=0.8;
%calculataion
x2=X*cos(theta)+Y*sin(theta);
y2=-X*sin(theta)+Y*cos(theta);
g=(f0/(pi*gamma*eta))*exp(-(f0^2*x2.^2/gamma^2)-(f0^2*y2.^2/eta^2)).*exp(1i*2*pi*f0*x2);
%plot gabor
figure
imagesc(real(g))
colorbar
figure
imagesc(imag(g))
colorbar
figure
surf(X,Y,real(g),'EdgeColor','black')
figure
surf(X,Y,imag(g),'EdgeColor','black')
