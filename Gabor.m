clear all; close all;

%% meshgrid
[X,Y]=meshgrid([-5:0.1:5]);
%plot the grid
figure
imagesc(X)
colorbar
figure
imagesc(Y)
colorbar

%% filters
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

%% filter bank
%hyperparameters
[X,Y]=meshgrid([-5:0.01:5]);
k=4; %amount of orientations
f=[1,1.5,2.25];
eta=(2*k/pi^2)*sqrt(-log(1/sqrt(2)));
gamma=2*eta;
l=0; %counter for the subplots
figure
for j=1:3 %sizes
    theta=0;
    f0=f(j);
    for i=1:k %orientations
        theta=(i-1)*0.25*pi;
        v0=f0*sin(theta);
        u0=f0*cos(theta);
        x2=Y*cos(theta)+X*sin(theta);
        y2=-Y*sin(theta)+X*cos(theta);
        %spatial domain
        g=(f0/(pi*gamma*eta))*exp(-(f0^2*x2.^2/gamma^2)-(f0^2*y2.^2/eta^2)).*exp(1i*2*pi*f0*x2);
        l=l+1;
        subplot(3,4,l)
        imagesc(real(g))
        colorbar
        %spectral domain
        h=exp(-(pi^2/f0^2)*(gamma^2*(x2-f0).^2+eta^2*y2.^2));
        halfpower=max(max(h))/sqrt(2);
        %halfpower profiels
        for m=1:numel(h)
            if h(m)>=halfpower
                h(m)=1;
            else
                h(m)=0;
            end
        end
        h_power(l,:,:)=h; % save them for easier plotting
    end
end

figure
for l=1:12
    hold on
    contour(reshape(h_power(l,:,:),1001,1001),[1,1]) %reshape to get 1,1001,1001 to 1001,1001
end


