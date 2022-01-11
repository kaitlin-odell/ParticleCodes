function jn = Jn(x1, x2, env_name,tau)
[n,d] = size(x1);
if strcmp(env_name,'star')
    [logp1, ~,h] = star(100, 5,x1);  %star gaussian mixture example  
elseif strcmp(env_name, 'sine')
    [logp1, ~,h] = sine(1, 0.003,x1);  %unimodal sine shape example
elseif strcmp(env_name, 'double_banana')
    [logp1, ~,h] = double_banana(0.0, 100.0, 1.0, 0.09, log(30),x1);  %bimodal double banana example
elseif strcmp(env_name,'banana')
    [logp1, ~,h] = banana(x1);
elseif strcmp(env_name,'wave')
    [logp1, ~,h] = wave(x1);
end

if strcmp(env_name,'star')
    [logp2, ~,h] = star(100, 5,x2);  %star gaussian mixture example  
elseif strcmp(env_name, 'sine')
    [logp2, ~,h] = sine(1, 0.003,x2);  %unimodal sine shape example
elseif strcmp(env_name, 'double_banana')
    [logp2, ~,h] = double_banana(0.0, 100.0, 1.0, 0.09, log(30),x2);  %bimodal double banana example
elseif strcmp(env_name,'banana')
    [logp2, ~,h] = banana(x2);
elseif strcmp(env_name,'wave')
    [logp2, ~,h] = wave(x2);
end

dif1 = reshape(x1,n,1,d) - reshape(x1,1,n,d);
kxy1 = exp(-sum(dif1.^2, 3)/(2*h^2))/((2*pi*h^2)^(d/2))/n;
sumkxy1 = sum(kxy1,2);
Fx1 = (sum(log(sumkxy1)) - sum(logp1))/n;

dif2 = reshape(x2,n,1,d) - reshape(x2,1,n,d);
kxy2 = exp(-sum(dif2.^2, 3)/(2*h^2))/((2*pi*h^2)^(d/2))/n;
sumkxy2 = sum(kxy2,2);
Fx2 = (sum(log(sumkxy2)) - sum(logp2))/n;

obj=0;
for i = 1:n
   obj = obj + (norm(x1(i,:)-x2(i,:),2)^2)/(2*tau);
end
obj = obj/n;

jn = Fx1 - Fx2 + obj;

end