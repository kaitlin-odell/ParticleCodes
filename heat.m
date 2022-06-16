function [logp, grad_logp,h,rho] = heat(x,T)
[n,d] = size(x);
h = 0.66;

if d == 1
    rho = exp((-x.^2)/((4*T)))./((4*pi*T)^(1/2)); %%This is exact solution in 1D
elseif d == 2
    rho = exp((-x(:,1).^2-x(:,2).^2)/(4*T))./((4*pi*T)); %%This is exact solution in 2D
elseif d == 3
    rho = exp((-x(:,1).^2-x(:,2).^2-x(:,3).^2)/(4*T))./((4*pi*T)^(3/2)); %%This is exact solution in 2D
end

logp = 0; %This is V(x)

grad_logp = zeros(n,d); %This is - grad V(x)

end