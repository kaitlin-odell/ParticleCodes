function [logp, grad_logp,h] = wave(x)
[n,d] = size(x);
h = .1;
x1 = x(:,1);
x2 = x(:,2);

logp = -.5*(x2 - sin(pi*x1/2)).^2/16;

grad1 = (x2-sin(pi*x1/2)).*cos(pi*x1/2)*(pi/.32);
grad2 = -(x2-sin(pi*x1/2))/16;
grad_logp = [grad1, grad2];

%Hessian_logp = eye(d)./prior_var + Jx'*Jx./y_var;

%inv_avg_Hessian = inv(Hessian_logp);

end