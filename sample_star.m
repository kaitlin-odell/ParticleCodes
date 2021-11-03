function y = sample_star(skewness, K, M)
d=2;
y = zeros(M,2);
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
i=1;
k = 1;
while i <=M
    y(i,:) = mvnrnd(mu(k,:),reshape(sigma(k,:,:),[2,2]));
    
    if k/5 ==1
        k = 1;
    else
        k = k+1;
    end
    i = i+1;
end
end