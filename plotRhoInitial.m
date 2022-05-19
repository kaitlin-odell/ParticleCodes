function plotRhoInitial(h,d,x0)

rho = @(x) arrayfun(@(z1,z2) (exp(-norm(x - [z1,z2],2)^2/(2*h^2))/((2*pi*h^2)^(d/2))),x0(:,1),x0(:,2));
x = linspace(-10,10,500);
[X,Y] = meshgrid(x,x);
XY = [reshape(X,[1,(500)^2]); reshape(Y,[1, (500)^2])]';
rho_x = zeros(500^2,1); % numerical solution
for j = 1:500^2
    rho_x(j) = sum(rho(XY(j,:)))/n_particles;
end
[~,~,~,rho_star] = heat(XY,t); % Exact solution

% Reshape for plotting
rho_x = reshape(rho_x, [500,500]);
rho_star = reshape(rho_star,[500,500]);

%% Plot true solution IC
hold on;
figure(1)
contourf(X,Y,rho_star)

figure(2);
plot3(X,Y,rho_star)
xlabel('x')
ylabel('y')
zlabel('solution')

%% Plot numerical solution IC 
figure(3)
hold on;
contourf(X,Y,rho_x)
scatter(x0(:,1),x0(:,2),'*r')

figure(4);
plot3(X,Y,rho_x)
xlabel('x')
ylabel('y')
zlabel('solution')