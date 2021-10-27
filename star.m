function [logp, grad_logp,h] = star(skewness, K, x)
[n, d] = size(x);
h = .1;

theta = 2*pi/K;

U = [cos(theta), -sin(theta); sin(theta), cos(theta)];

mu = zeros(K,d);
sigma = zeros(K,d,d);
inv_sigma = zeros(K,d,d);

mu(1,:) = 1.5*[1,0];
sigma(1,:,:) = diag([1, 1/skewness]);
inv_sigma(1,:,:) = diag([1, skewness]);

for i = 2:K
    mu(i,:) = mu(i-1,:)*U;
    sigma(i,:,:) = U'*(reshape(sigma(i-1,:,:),size(U))*U);
    inv_sigma(i,:,:) = U'*(reshape(inv_sigma(i-1,:,:),size(U))*U);
end

Fx = zeros(n,1);
Jx = zeros(n,2);

for i = 1:K
    pdfi = mvnpdf(x,mu(i,:), reshape(sigma(i,:,:), [2,2]));
    Fx = Fx + pdfi;
    Jx = Jx + pdfi.*((mu(i,:)- x)*reshape(inv_sigma(i,:,:),[2,2]));
end

logp = log(Fx/K);

grad_logp = Jx./Fx;

end