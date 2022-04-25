function [x_evi,err,fn,fne,jn] = trainer(env_name, n_particles,outer_iter,tau)
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
d = 1; % dimension of problem
t = 1/4; % start time of the algorithm
h = 0.66; 
N = n_particles*d; %Total dimension of ODE system
tplot = [5000, 10000, 15000, 20000, 25000, 30000];
%tplot = 1e9;
%x0 = randn(n_particles,d);

%% Initializes particles via initially equally weighted from grad descent paper%%
x0 = zeros(n_particles,1);
for i = -(n_particles/2):(n_particles/2)
    x0(i+(n_particles/2)+1) = erfinv((2*i-1)/(2*n_particles));
end

%% Plot IC
rho = @(x) arrayfun(@(z) (exp(-norm(x - z,2)^2/(2*h^2))/((2*pi*h^2)^(d/2))),x0);
x = linspace(-100,100,10000);
rho_x = zeros(10000,1); % Numerical
for j = 1:10000
    rho_x(j) = sum(rho(x(j)))/n_particles;
end
[~,~,~,rho_star] = heat(x,t); % Exact solution
tp = (ones(10000,1)*t)-(1/4);
hold on;
plot3(x', tp, rho_star, 'r-')
plot3(x', tp, rho_x, 'b--')

%% Outer Time loop for particle updates
for i = 1:outer_iter
    t = t+tau;
    x_evi = evi_im(x0, tau, env_name);
    
    %% Computes the free energy and Jn for approximate and exact solutions
    [~,fn(i),jn(i)] = Jn(x_evi,x0,env_name,tau,t);
    fne(i) = exactfh(t);
    
    
    %% Plots the last approximate and exact sol at the end time
    if any(i==tplot)
        rho = @(x) arrayfun(@(z) (exp(-norm(x - z,2)^2/(2*h^2))/((2*pi*h^2)^(d/2))),x_evi);
        x = linspace(-100,100,10000);
        rho_x = zeros(10000,1);
        for j = 1:10000
            rho_x(j) = sum(rho(x(j)))/n_particles;
        end
        [~,~,~,rho_star] = heat(x,t);
        
        int1 = 0;
        int2 = 0;
        for j =1:9999
            int1 = int1 + (abs(rho_x(j)-rho_x(j+1))/2)*(x(j+1)-x(j));
            int2 = int2 + (abs(rho_star(j)-rho_star(j+1))/2)*(x(j+1)-x(j));
        end
        err = abs(int1-int2)/int2;

        hold on;
%         plot(x',rho_star,'r-')
%         plot(x,rho_x,'b--')
        tp = (ones(10000,1)*t)-(1/4);
        plot3(x', tp, rho_star, 'r-')
        plot3(x', tp, rho_x, 'b--')
        
   end
    x0 = x_evi;
end

end