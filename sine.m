function [logp, grad_logp,h] = sine(prior_var,y_var,x)
[n,d] = size(x);
h = .2;
x1 = x(:,1);
x2 = x(:,2);

Fx = (x2 + sin(x1)).^2;

Jx1 = 2*(x2 + sin(x1)).*cos(x1);
Jx2 = 2*(x2 + sin(x1));

Jx = [Jx1, Jx2];

logp = -squeeze(sum(x.*x, 2))/(2*prior_var) - Fx.^2./(2*y_var);

q = Jx.*Fx./y_var;
r = -x./prior_var;

grad_logp = r - q;

%Hessian_logp = eye(d)./prior_var + Jx'*Jx./y_var;

%inv_avg_Hessian = inv(Hessian_logp);

end