function plotRho2D(X,Y,rho_star,rho_x,x_evi)
%%%Plot 2D heat equation at the final time T
%%% Plot True Solution in contour and 3D
hold on;
figure(1)
contourf(X,Y,rho_star)
colorbar

figure(2);
plot3(X,Y,rho_star)
xlabel('x')
ylabel('y')
zlabel('solution')

%%% Plot Numerical solution in contour and 3D
figure(3)
hold on;
contourf(X,Y,rho_x)
scatter(x_evi(:,1),x_evi(:,2),'*r')
colorbar

figure(4);
plot3(X,Y,rho_x)
xlabel('x')
ylabel('y')
zlabel('solution')

end