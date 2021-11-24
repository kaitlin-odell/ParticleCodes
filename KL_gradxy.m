function Akxy = KL_gradxy(x, x_init, tau, env_name)
%%%%%%%%%%%%%%%%%%%%%%
% Input:
%    -- x: particles, n*d matrix, where n is the number of particles and d is the dimension of x 
%    -- x_init: initial particles, n*d matrix, where n is the number of
%    particles and d is the dimension of x
%    -- tau: step size in implicit euler.
%    -- env_name: name of environment to calculate logp, grad_logp, and give proper h.

% Output:
%    --Akxy: n*d matrix, Gradient of J_n(x)
%%%%%%%%%%%%%%%%%%%%%%
[n,d] = size(x);

if strcmp(env_name,'star')
    [~, grad_logp,h] = star(100, 5,x);  %star gaussian mixture example  
elseif strcmp(env_name, 'sine')
    [~, grad_logp,h] = sine(1, 0.003,x);  %unimodal sine shape example
elseif strcmp(env_name, 'double_banana')
    [~, grad_logp,h] = double_banana(0.0, 100.0, 1.0, 0.09, log(30),x);  %bimodal double banana example
elseif strcmp(env_name,'banana')
    [~, grad_logp,h] = banana(x);
elseif strcmp(env_name,'wave')
    [~, grad_logp,h] = wave(x);
end

%%%%%%%%%%%%%% Main part %%%%%%%%%%

dif = reshape(x,n,1,d) - reshape(x,1,n,d);

kxy = exp(-sum(dif.^2, 3)/(2*h^2))/((2*pi*h^2)^(d/2));
kh = kxy/h^2;
sumkxy = sum(kxy,2);

gradK = -dif.*(kxy/h^2);

dxkxy = squeeze(sum(gradK,2));

khs = kh./sumkxy;
obj1 = khs*x - sum(khs,2).*x;
obj2 = dxkxy./sumkxy;

Akxy = (x - x_init)/tau + obj2 + obj1  - grad_logp;  % - (-obj2 - obj1 - grad_logp'); %Grad of J_n(x)
end