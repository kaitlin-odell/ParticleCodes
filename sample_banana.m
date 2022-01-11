function k = sample_banana(M)

x = linspace(-3,3,2*M);
y = linspace(-1,1/2,2*M);

k = zeros(M,2);
z = -9/2;
for i = 1:2*M
    p = -1/2*x(i)^2 - 1/2*(10*y(i) +3*x(i)^2-3)^2;
    if p > z
        k(i,:) = [x(i),y(i)];
    end
    
    if size(k,1) == M
        break
    end
end

end