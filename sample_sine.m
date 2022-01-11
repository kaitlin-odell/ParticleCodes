function y = sample_sine(M)

x = linspace(-pi/2,pi/2,100);
k = linspace(-.2,.2,100);

for i =1:100
    z(i,:) = sin(x) + k(i);
end

y = zeros(M,1);
for j = 1:M
    r_i = randi(100,1);
    r_j = randi(100,1);
    y(j) = z(r_i,r_j);
end

end