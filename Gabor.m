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
f0=0.2;
gamma=0.4;
eta=0.4;
%calculataion
x2=Y*cos(theta)+X*sin(theta);
y2=-Y*sin(theta)+X*cos(theta);
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

%filter bank
k=4; %amount of orientations

gtotal=zeros(101,101);
htotal=zeros(101,101);
eta=(2*k/pi^2)*sqrt(-log(1/sqrt(2)));
gamma=eta;
theta=0;
for i=0:k-1
    f0=i*eta*2;
%     phi=exp(-(pi^2/f0^2)*(gamma^2*(x2-f0).^2+eta^2*y2.^2));
    dtheta=4*atan(eta*0.5/f0);
    theta=i*dtheta;
    v0=f0*sin(theta);
    u0=f0*cos(theta);
    x2=Y*cos(theta)+X*sin(theta);
    y2=-Y*sin(theta)+X*cos(theta);
    g=(f0/(pi*gamma*eta))*exp(-(f0^2*x2.^2/gamma^2)-(f0^2*y2.^2/eta^2)).*exp(1i*2*pi*f0*x2);
    gtotal=gtotal+g;
    h=2*pi*gamma*eta*exp(-2*pi^2*((x2-u0).^2*gamma^2+(y2-v0).^2*eta^2));
    htotal=htotal+h;
end
figure
imagesc(real(gtotal))
colorbar
figure
imagesc(imag(gtotal))
colorbar
figure
imagesc(htotal)
colorbar
