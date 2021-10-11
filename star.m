function [logp, grad_logp, Hessian_logp, inv_avg_Hessian] = star(a,b,prior_var,y_var,y,x)
[n, d] = size(x);
x1 = x(:,1);
x2 = x(:,1);

expFx = sqrt(a - x1) + b*sqrt(x2 - x1.^2) + 1e-10;
Fx = log(expFx);

Jx1 = 2*(x1 - a) + 4*b*x1.*(x1.^2 -x2);
Jx2 = 2*b*(x2 -x1.^2);

J = [Jx1, Jx2];

Jx = J./expFx;

logp = -dot(x,x)/(2*prior_var) - (Fx - y).^2/(2*y_var);

z = Fx-y;

grad_logp = -x./prior_var - Jx.*((Fx - y)./y_var);

Hessian_logp = eye(d)./prior_var + Jx'*Jx./y_var;

inv_avg_Hessian = inv(Hessian_logp);
end