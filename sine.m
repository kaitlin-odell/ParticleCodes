function [logp, grad_logp, Hessian_logp, inv_avg_Hessian] = sine(prior_var,y_var,x)
[n, d] = size(x);
x1 = x(:,1);
x2 = x(:,1);

Fx = sqrt(x2 + sin(x1));

Jx1 = 2*(x2 + sin(x1)).*cos(x1);
Jx2 = 2*(x2 + sin(x1));

Jx = [Jx1, Jx2]';

logp = -dot(x,x)/(2*prior_var) - Fx.^2./(2*y_var);

grad_logp = -x./prior_var - Jx.*(Fx./y_var);

Hessian_logp = eye(d)./prior_var + Jx'*Jx./y_var;

inv_avg_Hessian = inv(Hessian_logp);

end