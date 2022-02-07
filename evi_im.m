function  theta = evi_im(theta0, tau, env_name, master_stepsize,auto_corr, method)

%%%%%%%%
% Energetic Variational Inference w/ Implicit Euler

% input:
%   -- theta0: initialization of particles, n * d matrix (n is the number of particles, d is the dimension)
%   -- env_name: name of distribution environment
%   -- max_iter: maximum iterations
%   -- master_stepsize: the general learning rate for adagrad
%   -- h/bandwidth: bandwidth for rbf kernel. Using median trick as default
%   -- auto_corr: momentum term
%   -- method: use adagrad or GDBB to select the best \epsilon

% output:
%   -- theta: a set of particles that approximates p(x)
%%%%%%%%

if nargin < 4 
    master_stepsize = 1e-2; 
end

if nargin < 5
    auto_corr = 0.9; 
end

if nargin < 6 
    method = 'gdbb'; 
end

switch method
    
    case 'adagrad'
        %% AdaGrad with momentum
        theta = theta0;
        
        fudge_factor = 1e-6;
        historial_grad = 0;
        
        for iter = 1:5000
            grad = KL_gradxy(theta, theta0, tau, dlog_p, h);   %\Phi(theta)
            if historial_grad == 0
                historial_grad = historial_grad + grad.^2;
            else
                historial_grad = auto_corr * historial_grad + (1 - auto_corr) * grad.^2;
            end
            adj_grad = grad ./ (fudge_factor + sqrt(historial_grad));
            theta = theta + master_stepsize * adj_grad; % update
        end
        
    case 'gdbb'
        %Gradient Descent with Brazilian-Borwein Stepsize to make gradient smaller
        
        theta = theta0;
        m = size(theta,1)*size(theta,2);
        
        for iter = 1:5000
            grad = KL_gradxy(theta, theta0, tau, env_name);   %\Phi(theta)
            grad_now = reshape(grad, [1,m]);
            
            p = sqrt(dot(grad_now,grad_now));
            
            if  p < 1e-9
                break
            end
            
            step_1 = 1e-7;
            %compute Barzilain-Borwein(BB) Stepsize
            if iter > 1
                y_k = grad_now - grad_old;
                s_k = reshape(theta, [1,m]) - reshape(theta_old, [1,m]);
                step_1 = dot(s_k, s_k) / dot(s_k, y_k);
            end
            
            grad_old = grad_now;
            theta_old = theta;
            theta = theta - step_1*grad;
                
        end
end
end