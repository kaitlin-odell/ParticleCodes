function [logp, grad_logp] = banana(x)

x1 = x(:,1);
x2 = x(:,2);

logp = -x1.^2/200 - 1/2*(x2 + .03*x1.^2 - 3).^2; %This is V(x)

grad1 = -x1/100 - .06*x1.*(x2 + .03*x1.^2-3);
grad2 = -x2 - .03*x1.^2 +3;

grad_logp = [grad1, grad2]'; %This is - grad V(x)

end