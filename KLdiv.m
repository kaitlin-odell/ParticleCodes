clear;
%Pick one toy environment to play
    %Different name corresponds to different V(x) in the Fokker-Plank equation
    %The definition of V(x) can be found in environment.py
env_name = 'double_banana';
%env_name = 'banana';
%env_name = 'sine';
%env_name = 'star';
%env_name = 'wave';

n_particles = 100;  %number of particles (can be adjusted as desired)
dim = 2;            %dimension of the problem
outer_iter = 100;    %number of outer iterations (can be adjusted as desired)

%%Compute the target distribution
%%For Star distribution
% K=5;
% skewness = 100;
% theta = 2*pi/K;
% U = [cos(theta), -sin(theta); sin(theta), cos(theta)];
% 
% mu = zeros(K,dim);
% sigma = zeros(K,dim,dim);
% inv_sigma = zeros(K,dim,dim);
% 
% mu(1,:) = 1.5*[1,0];
% sigma(1,:,:) = diag([1, 1/skewness]);
% inv_sigma(1,:,:) = diag([1, skewness]);
% 
% for i = 2:K
%     mu(i,:) = mu(i-1,:)*U;
%     sigma(i,:,:) = U'*(reshape(sigma(i-1,:,:),size(U))*U);
%     inv_sigma(i,:,:) = U'*(reshape(inv_sigma(i-1,:,:),size(U))*U);
% end
% 
% pdf1 = @(x) mvnpdf(x,mu(1,:), reshape(sigma(1,:,:), [2,2]));
% pdf2 = @(x) mvnpdf(x,mu(2,:), reshape(sigma(2,:,:), [2,2]));
% pdf3 = @(x) mvnpdf(x,mu(3,:), reshape(sigma(3,:,:), [2,2]));
% pdf4 = @(x) mvnpdf(x,mu(4,:), reshape(sigma(4,:,:), [2,2]));
% pdf5 = @(x) mvnpdf(x,mu(5,:), reshape(sigma(5,:,:), [2,2]));
% rho_star = @(x) pdf1(x) + pdf2(x) + pdf3(x) + pdf4(x) + pdf5(x);

%%For sine distribution
%rho_star = @(x,y) exp(-1/2*((y - sin(pi*x/2)/.4)^2));

%%For banana distribution
%rho_star = @(x,y) exp(-x^2/2 - (10*y + 3*x^2 - 3)^2/2);

%%For double banana distribution
rho_star = @(x,y) exp(-2*((x^2 + y^2) -3)^2 + log(exp(-2*(x-2)^2) + exp(-2*(y-2)^2)));

%%calculates the approximated particles%%
x_evi = trainer(env_name, n_particles, outer_iter);

%%Compute points in the un-normalized target distribution for trapezodial
%%integratation
% M = 100;
% y = sample_star(100,5,M);

%%Reconstructs approximate distribution from approximated particles
rho = reconstructRho(x_evi,n_particles);

%%Calculates the KL Divergence
KL = KLdivergence(rho, rho_star);