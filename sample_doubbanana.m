function k = sample_doubbanana(M)

x = linspace(-3,3,2*M);
y = linspace(-1,1,2*M);

k = zeros(M,2);
z = -2*((1/4)-2)^2 + log(exp(-8)+exp(-9/2));
for i = 1:2*M
    p = -2*(x(i)^2+y(i)^2 - 3)^2 + log(exp(2*(x(i)-2)^2) + exp(2*(y(i)-2)^2));
    if p > z
        k(i,:) = [x(i),y(i)];
    end
    if size(k,1) == M
        break
    end
end

end