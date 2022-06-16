function plotPythonData()
%%Loads in data from Python
load('evi.mat')
load('heat.mat')

%%Gets last particle evolution
x_evi = evolves(100,:,:);
x_evi = squeeze(x_evi);
n_particles = size(x_evi,1);

%%Reconstructs the numerical solution
h = 0.66;
rho = reconstructRho(x_evi,h);
XY = [reshape(X,[1,(1000)^2]); reshape(Y,[1, (1000)^2])]';
for j = 1:1000^2
    rho_x(j) = sum(rho(XY(j,:)))/n_particles;
end
rho_x = reshape(rho_x,[1000,1000]);

%%%Plot 3D Numerical Solution
% figure(4);
% plot3(X,Y,rho_x)
% figure(5);
% contourf(X,Y,rho_x)
% plot(x_evi(:,1),x_evi(:,2),'*')

%%%Plot contours
plotContours(X,rho_x)

end