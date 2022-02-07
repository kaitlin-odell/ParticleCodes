function rho = reconstructRho(x_evi,N)
%%%%%%%%%%%%%%%%%%%%%%
% Input:
%    -- x_evi: approximated values from rho

% Output:
%    --rho: reconstructed approximate distribution
%%%%%%%%%%%%%%%%%%%%%%

% rho =@(x,y) 0;
% for i = 1:N
%     rho = @(x,y) rho(x,y) + dirac(x - x_evi(i,1))*dirac(y - x_evi(i,2))/N;
% end
h = .05;
d = 2;

%%Using the gaussian kernel instead of dirac distributions
rho = @(x) exp(-norm(x - x_evi,2)^2/(2*N*h^2))/((2*pi*h^2)^(d/2));

end