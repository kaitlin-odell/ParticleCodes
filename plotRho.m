function plotRho(x,rho_star,rho_x,x_evi)
%%%Plot 2D heat equation at the final time T
%%% Plot True Solution
hold on;
figure(1)
% plot(x,rho_star)
% xlabel('x')
% ylabel('solution')

%%% Plot Numerical
hold on;
plot(x,rho_x)
xlabel('x')
ylabel('solution')

end