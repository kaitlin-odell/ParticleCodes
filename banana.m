function [logp, grad_logp,h] = banana(x)
h = .05;
x1 = x(:,1);
x2 = x(:,2);

logp = -x1.^2/2 - (1/2)*(10*x2 + 3*x1.^2 - 3).^2; %This is V(x)
%logp = (-x1.^2 - x2.^2)/2;

grad1 = -x1 - 6*x1.*(10*x2 + 3*x1.^2 - 3);
grad2 = -100*x2 - 30*x1.^2 + 30;

grad_logp = [grad1, grad2]; %This is - grad V(x)

end