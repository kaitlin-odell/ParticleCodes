function [logp, grad_logp,h] = star(skewness, K, x)
[n, d] = size(x);
h = .1;

theta = 2*pi/K;

U = [cos(theta), sin(theta); -sin(theta), cos(theta)];

mu = zeros(K,d);
sigma = zeros(K,d,d);
inv_sigma = zeros(K,d,d);

mu(1,:) = 1.5*[1,0];
sigma(1,:,:) = diag([1, 1/skewness]);
inv_sigma(1,:,:) = diag([1, skewness]);

for i = 2:K
    mu(i,:) = U*mu(i-1,:);
    sigma(i,:,:) = U*(sigma(i-1,:,:)*U');
    inv_sigma(i,:,:) = U*(inv_sigma(i-1,:,:)*U');
end

Fx = zeros(n);
Jx = zeros(n);

for i = 1:n
    pdfi = mvnpdf(x, mu(i,:), sigma(i,:,:));
    Fx = Fx + pdfi;
    Jx = Jx + inv_sigma(i,:,:)*pdfi;
end

logp = log(Fx/K);

grad_logp = Jx./Fx;

end