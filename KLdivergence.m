function kldiv = KLdivergence(rho,rho_star)
%%%%%%%%%%%%%%%%%%%%%%
% Input:
%    -- rho: approximated distribution
%    -- rho_star: target distribution

% Output:
%    --KLDiv: The Kullback-Leibler divergence measuring the distance from
%    rho to rho_star
%%%%%%%%%%%%%%%%%%%%%%
n = 1000; %number of subintervals in the x direction
m = 1000; %number of subintervals in the y direction

%%%Use Trapezoid Method to estimate integral
dx = (10)/n;
dy = (10)/m;

int = 0;
for i = 1:n
    for j = 1:m
        if rho([-5 + i*dx, -5 + j*dy]) == 0
            continue
        end
        int = int + rho([-5 + i*dx, -5 + j*dy])*log(((rho([-5 + i*dx, -5 + j*dy]))./(rho_star(-5 + i*dx, -5 + j*dy))))*dx*dy;
    end
end

kldiv = sum(int);

end