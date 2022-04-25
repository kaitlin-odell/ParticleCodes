function [logp, grad_logp,h,rho] = heat(x,T)
[n,d] = size(x);
h = .66;

rho = exp(-x.^2/(4*T))./sqrt(4*pi*T); %%This is exact solution

logp = 0; %This is V(x)

grad_logp = zeros(n,d); %This is - grad V(x)

end