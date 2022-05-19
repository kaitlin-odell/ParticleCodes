function [logp, grad_logp,h,rho] = heat(x,T)
[n,d] = size(x);
% x1 = x(:,1);
% x2 = x(:,2);
h = 0.653;

if d==1
    rho = exp((-x.^2)/(sqrt(4*T)))./((4*pi*T)^(d/2)); %%This is exact solution in 1D
elseif d==2
    rho = exp((-x(:,1).^2-x(:,2).^2)/(4*T))./((4*pi*T)^(d/2)); %%This is exact solution in 2D
end

logp = 0; %This is V(x)

grad_logp = zeros(n,d); %This is - grad V(x)

end