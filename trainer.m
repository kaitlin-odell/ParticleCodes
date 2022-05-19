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
% plotRhoInitial(h,d,x0)


%% Outer Time loop for particle updates
for i = 1:outer_iter
    t = t+tau;
    x_evi = evi_im(x0, tau, env_name);
    
    %% Computes the free energy and Jn for approximate and exact solutions
    %[~,fn(i),jn(i)] = Jn(x_evi,x0,env_name,tau,t);
    %fne(i) = exactfh(t);
    
    
    %% Plots the last approximate and exact sol at the end time
    if i==outer_iter
        % Numerical solution as d increases need to increase z1,z2..etc
        rho = @(x) arrayfun(@(z1,z2) (exp(-norm(x - [z1,z2],2)^2/(2*h^2))/((2*pi*h^2)^(d/2))),x_evi(:,1),x_evi(:,2));

        % Evaluate rho at points on a grid to find numerical solution
        x = linspace(-10,10,500);
        [X,Y] = meshgrid(x,x);
        XY = [reshape(X,[1,(500)^2]); reshape(Y,[1, (500)^2])]';
        rho_x = zeros(500^2,1);
        for j = 1:500^2
            rho_x(j) = sum(rho(XY(j,:)))/n_particles;
        end

        %Calculate true solution for plot reference plotting
        [~,~,~,rho_star] = heat(XY,t);
        
        % Reshape for plotting
        rho_x = reshape(rho_x, [500,500]);
        rho_star = reshape(rho_star,[500,500]);
        plotRho(X,Y,rho_star,rho_x)
        
        % Calculate numerical error
        err = rhoError(XY,rho_x);
        
   end
    x0 = x_evi;
end

end