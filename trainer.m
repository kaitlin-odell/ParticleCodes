function [x_evi] = trainer(env_name, n_particles,outer_iter)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sample code to reproduce our distribution particle results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
d = 2; % dimension of problem
tau = 1e-2; %time step for implicit 
x0 = randn(n_particles,d);%Initialize x0 
%x = [.1, .2; .5, .2; .3, .1; .6, .9; .9, .2; .32, .45; .18, .84; .23, .84; .55, .81; .71, .13];
N = n_particles *d; %Total dimension of ODE system

for i = 1:outer_iter
    x_evi = evi_im(x0, tau, env_name);
    x0 = x_evi;
%    scatter(x_evi(:,1),x_evi(:,2),'*')
end

end