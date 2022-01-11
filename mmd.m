function  MMD = mmd(x_evi,y,N,M)
%%%%%%%%%%%%%%%%%%%%%%
% Input:
%    -- x_evi: particles, N*d matrix, where N is the number of particles and d is the dimension of x 
%    -- y: particles from the target distribution, M*d matrix, where M is the number of
%    particles and d is the dimension of y
%    -- N: number of approximated particles
%    -- M: number of particles from target distribution

% Output:
%    --MMD: MMD^2 value
%%%%%%%%%%%%%%%%%%%%%%


for i = 1:N
    for j = 1:N
        kx = (x_evi(i).*x_evi(j)/3 + 1)^3;
    end 
end
kx = kx/N^2;

for i = 1:M
    for j= 1:M
        ky = (y(i).*y(j)/3 + 1)^3;
    end
end

ky = ky/M^2;

for i = 1:N
    for j = 1:M
        kxy = (x_evi(i).*y(j)/3 + 1)^3;
    end
end
kxy = kxy*2/(N*M);

MMD = kx + ky - kxy;
end