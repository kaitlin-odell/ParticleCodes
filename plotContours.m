function plotContours(X,rho_x)
%%%Plot contours of 2D heat equation at the final time T
%%% Numerical Solution Contour at y = -1
hold on;
figure(1)
plot(X(475,:),rho_x(475,:))

%%% Numerical Solution Contour at y = 0
hold on;
figure(2)
plot(X(500,:),rho_x(500,:))

%%% Numerical Solution Contour at y = 1
hold on;
figure(3)
plot(X(525,:),rho_x(525,:))

end