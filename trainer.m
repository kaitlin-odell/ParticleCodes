function [x_evi] = trainer(env_name, n_particles,outer_iter)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sample code to reproduce our distribution particle results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
d = 2; % dimension of problem
tau = 1e-2; %time step for implicit 
x = randn(n_particles,d);
N = n_particles *d; %Total dimension of ODE system


% our implicit evi algorithm %
x0 = x; %Initialize x0
max_iter = 100; %maximum number of iterations for evi
% Searching best master_stepsize using a development set
master_stepsize = 0.05;  


for i = 1:outer_iter
    x_evi = evi_im(x0, tau, env_name, max_iter, master_stepsize);
    x0 = x_evi;
%    scatter(x_evi(:,1),x_evi(:,2),'*')
end

end