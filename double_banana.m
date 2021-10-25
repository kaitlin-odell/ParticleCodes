function [logp, grad_logp,h] = double_banana(a,b,prior_var,y_var,y,x)
%[n, d] = size(x);
h = .05;
x1 = x(:,1);
x2 = x(:,2);

expFx = (a - x1).^2 + b*(x2 - x1.^2).^2 + 1e-10;
Fx = log(expFx);

Jx1 = 2*(x1 - a) + 4*b*x1.*(x1.^2 -x2);
Jx2 = 2*b*(x2 -x1.^2);

J = [Jx1, Jx2];

Jx = J./expFx;

logp = -squeeze(sum(x.*x, 2))/(2*prior_var) - (Fx - y).^2/(2*y_var);

grad_logp = -x./prior_var - Jx.*((Fx - y)./y_var);

%Hessian_logp = eye(d)./prior_var + Jx'*Jx./y_var;

%inv_avg_Hessian = inv(Hessian_logp);

end