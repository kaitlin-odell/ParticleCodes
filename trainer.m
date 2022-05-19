function [x_evi, err, rho_star, rho_x, fn,jn,fne] = trainer(env_name, n_particles,outer_iter,tau)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Sample code to reproduce our distribution particle results
% Input:
%    -- env_name: name of environment to calculate logp, grad_logp, and give proper h.
%    -- n_particles: number of particles to be approximated
%    -- outer_iter: number of iterations for the outer loop

% Output:
%    --x_evi: n*d matrix, approximated particles
%    --err: outer_iter vector, error at the last iteration
%    --fn: approximated free energy at each iteration
%    --fne: exact free energy at each iteration
%    --jn: approximated Jn at each iteration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
d = 2; % dimension of problem
t = 1/4; % start time of the algorithm
h = 0.653; 
N = n_particles*d; %Total dimension of ODE system
%tplot = [5000, 10000, 15000, 20000, 25000, 30000];
%tplot = 1e9;
%x0 = randn(n_particles,d);

%% Initializes particles via initially equally weighted from grad descent paper%%
x0 = zeros(n_particles,1);
for i = -(n_particles/2):(n_particles/2)
    x0(i+(n_particles/2)+1) = erfinv((2*i-1)/(2*n_particles));
end

[X,Y] = meshgrid(x0,x0);
XY = [reshape(X,[1,(n_particles+1)^2]); reshape(Y,[1, (n_particles+1)^2])];

x0 = XY';

n_particles = size(x0,1);

%% Plot IC
% rho = @(x) arrayfun(@(z1,z2) (exp(-norm(x - [z1,z2],2)^2/(2*h^2))/((2*pi*h^2)^(d/2))),x0(:,1),x0(:,2));
% x = linspace(-10,10,500);
% [X,Y] = meshgrid(x,x);
% XY = [reshape(X,[1,(500)^2]); reshape(Y,[1, (500)^2])]';
% rho_x = zeros(500^2,1); % numerical solution
% for j = 1:500^2
%     rho_x(j) = sum(rho(XY(j,:)))/n_particles;
% end
% [~,~,~,rho_star] = heat(XY,t); % Exact solution
% % % Reshape for plotting
% rho_x = reshape(rho_x, [500,500]);
% rho_star = reshape(rho_star,[500,500]);
% hold on;
% figure(1)
% contourf(X,Y,rho_star)
% figure(2)
% hold on;
% contourf(X,Y,rho_x)
% scatter(x0(:,1),x0(:,2),'*r')


%% Outer Time loop for particle updates
for i = 1:outer_iter
    t = t+tau;
    x_evi = evi_im(x0, tau, env_name);
    
    %% Computes the free energy and Jn for approximate and exact solutions
    %[~,fn(i),jn(i)] = Jn(x_evi,x0,env_name,tau,t);
    %fne(i) = exactfh(t);
    
    
    %% Plots the last approximate and exact sol at the end time
    if i==outer_iter
        rho = @(x) arrayfun(@(z1,z2) (exp(-norm(x - [z1,z2],2)^2/(2*h^2))/((2*pi*h^2)^(d/2))),x_evi(:,1),x_evi(:,2));
%         rho1 = @(x) exp(-norm(x - x_evi(1,:),2)^2/(2*h^2))/((2*pi*h^2)^(d/2)) ...
%             + exp(-norm(x - x_evi(2,:),2)^2/(2*h^2))/((2*pi*h^2)^(d/2)) ...
%             + exp(-norm(x - x_evi(3,:),2)^2/(2*h^2))/((2*pi*h^2)^(d/2)) ...
%             + exp(-norm(x - x_evi(4,:),2)^2/(2*h^2))/((2*pi*h^2)^(d/2)) ...
%             + exp(-norm(x - x_evi(5,:),2)^2/(2*h^2))/((2*pi*h^2)^(d/2)) ...
%             + exp(-norm(x - x_evi(6,:),2)^2/(2*h^2))/((2*pi*h^2)^(d/2)) ...
%             + exp(-norm(x - x_evi(7,:),2)^2/(2*h^2))/((2*pi*h^2)^(d/2)) ...
%             + exp(-norm(x - x_evi(8,:),2)^2/(2*h^2))/((2*pi*h^2)^(d/2)) ...
%             + exp(-norm(x - x_evi(9,:),2)^2/(2*h^2))/((2*pi*h^2)^(d/2));
        x = linspace(-10,10,500);
        [X,Y] = meshgrid(x,x);
        XY = [reshape(X,[1,(500)^2]); reshape(Y,[1, (500)^2])]';
        rho_x = zeros(500^2,1);
        for j = 1:500^2
            rho_x(j) = sum(rho(XY(j,:)))/n_particles;
        end

        [~,~,~,rho_star] = heat(XY,t);
        
        % Reshape for plotting
        rho_x = reshape(rho_x, [500,500]);
        rho_star = reshape(rho_star,[500,500]);
        
%         int1 = 0;
%         int2 = 0;
%         for j =1:(1000^2-1)
%             int1 = int1 + (abs(rho_x(j)+rho_x(j+1))/2)*(XY(j+1,1)-XY(j,1))*(XY(j+1,2)-XY(j,2));
%             int2 = int2 + (abs(rho_star(j)+rho_star(j+1))/2)*(XY(j+1,1)-XY(j,1))*(XY(j+1,2)-XY(j,2));
%         end
%         err = abs(int1-int2)/int2;
        err = 0;

        hold on;
        figure(3)
        contourf(X,Y,rho_star)
        figure(4)
        hold on;
        contourf(X,Y,rho_x)
        scatter(x_evi(:,1),x_evi(:,2),'*r')
        figure(5);
        plot3(X,Y,rho_star)
        xlabel('x')
        ylabel('y')
        zlabel('solution')
        figure(6);
        plot3(X,Y,rho_x)
        xlabel('x')
        ylabel('y')
        zlabel('solution')
%         plot3(x(:,1),x(:,2),rho_star,'k-')
%         plot3(x(:,1),x(:,2),rho_x,'r--')
%         tp = (ones(10000,1)*t)-(1/4);
%         plot3(x', tp, rho_star, 'r-')
%         plot3(x', tp, rho_x, 'b--')
        
   end
    x0 = x_evi;
end

end