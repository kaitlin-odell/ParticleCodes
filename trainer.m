function [x_evi,jn] = trainer(env_name, n_particles,outer_iter)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Sample code to reproduce our distribution particle results
% Input:
%    -- env_name: name of environment to calculate logp, grad_logp, and give proper h.
%    -- n_particles: number of particles to be approximated
%    -- outer_iter: number of iterations for the outer loop

% Output:
%    --x_evi: n*d matrix, approximated particles
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
d = 2; % dimension of problem
tau = 1e-2; %step for implicit euler 
x0 = randn(n_particles,d);%Initialize x0 
N = n_particles *d; %Total dimension of ODE system

for i = 1:outer_iter
    x_evi = evi_im(x0, tau, env_name);
    
%     if i > 1
%         jn(i) = Jn(x_evi,x0, env_name,tau);
%     else 
%         jn(i) = 0;
%     end
    
    x0 = x_evi;
end

end