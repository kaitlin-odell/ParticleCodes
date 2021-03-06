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
elseif strcmp(env_name,'heat')
    [~, grad_logp,h] = heat(x,0);
elseif strcmp(env_name,'linearfp')
    [~, grad_logp,h] = linearfp(x);
end

%%%%%%%%%%%%%% Main part %%%%%%%%%%
dif = reshape(x,n,1,d) - reshape(x,1,n,d);

kxy = exp(-sum(dif.^2, 3)/(2*h^2))/((2*pi*h^2)^(d/2));
sumkxy = sum(kxy,2);

gradK = -dif.*kxy/(h^2);

dxkxy = squeeze(sum(gradK,2));

% a = zeros([n,n,d]);
% for i =1:n
%     for j = 1:n
%         for k = 1:d
%             a(i,j,k) = gradK(i,j,k)/sumkxy(i);
%         end
%     end
% end
% obj1 = squeeze(sum(a, 2));
if d == 1
    obj1 = squeeze(sum(gradK./sumkxy,1))';
elseif d == 2
    obj1 = squeeze(sum(gradK./sumkxy,1));
end
obj2 = dxkxy./sumkxy;

Akxy = (x - x_init)/tau + obj2 - obj1  - grad_logp;  %Grad of J_n(x)
end