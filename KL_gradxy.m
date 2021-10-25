function Akxy = KL_gradxy(x, x_init, tau, env_name, h)
%%%%%%%%%%%%%%%%%%%%%%
% Input:
%    -- x: particles, n*d matrix, where n is the number of particles and d is the dimension of x 
%    -- h: bandwidth.

% Output:
%    --Akxy: n*d matrix, Gradient of J_n(x)
%%%%%%%%%%%%%%%%%%%%%%
[n,d] = size(x);

if strcmp(env_name,'star')
    [~, grad_logp, h] = star(100, 5,x);  %star gaussian mixture example  
elseif strcmp(env_name, 'sine')
    [~, grad_logp,h] = sine(1, 0.003,x);  %unimodal sine shape example
elseif strcmp(env_name, 'double_banana')
    [~, grad_logp,h] = double_banana(0.0, 100.0, 1.0, 0.09, log(30),x);  %bimodal double banana example
elseif strcmp(env_name,'banana')
    [~, grad_logp,h] = banana(x);
end

%%%%%%%%%%%%%% Main part %%%%%%%%%%
% XY = x*x';
% x2= sum(x.^2, 2);
% X2e = repmat(x2, 1, n);
% 
% H = (X2e + X2e' - 2*XY); % calculate pairwise distance
% Kxy = exp(-H/(2*h^2))/((2*pi*h*h)^(d/2));   % calculate kernel
% 
% sumKxy = sum(Kxy,2);
% dxkxy= -Kxy*x;
% for i = 1:d
%     dxkxy(:,i)=dxkxy(:,i) + x(:,i).*sumKxy;
% end
% dxkxy = dxkxy/h^2;
% 
% obj1= -Kxy*x;
% for i = 1:d
%     obj1(:,i)= obj1(:,i + x(:,i)./sumKxy;
% end
% obj1 = obj1/h^2;
% obj2 = dxkxy./sumKxy;

dif = zeros([n,n,d]);
for i = 1:n
    for j = 1:n
        for k = 1:d
            dif(i,j,k) = x(i,k) - x(j,k);
        end
    end
end

kxy = exp(-sum(dif.^2, 3)/(2*h^2))/((2*pi*h*h)^(d/2));
sumkxy = sum(kxy,2);
gradK = zeros([n,n,d]);
for i = 1:n
    for j = 1:n
        for k = 1:d
            gradK(i,j,k) = -dif(i,j,k)*kxy(i, j)/h^2;
        end
    end
end

dxkxy = squeeze(sum(gradK,2));
a = zeros([n,n,d]);
for i =1:n
    for j = 1:n
        for k = 1:d
            a(j,i,k) = gradK(i,j,k)/sumkxy(i);
        end
    end
end
obj1 = squeeze(sum(a, 2));
obj2 = dxkxy./sumkxy;

Akxy = (x - x_init)/tau + obj2 + obj1  - grad_logp;  % - (-obj2 - obj1 - grad_logp'); %Grad of J_n(x)
end