function rho = reconstructRho(x_evi,h)
%%%%%%%%%%%%%%%%%%%%%%
% Input:
%    -- x_evi: approximated values from rho
%    -- h: smoothing factor for gaussian kernel

% Output:
%    --rho: reconstructed approximate distribution
%%%%%%%%%%%%%%%%%%%%%%
[~,d] = size(x_evi);

%%Using the gaussian kernel instead of dirac distributions
if d == 1
    rho = @(x) arrayfun(@(z1) (exp(-norm(x - z1,2)^2/(2*h^2))/((2*pi*h^2)^(d/2))),x_evi(:,1));
elseif d == 2
    rho = @(x) arrayfun(@(z1,z2) (exp(-norm(x - [z1,z2],2)^2/(2*h^2))/((2*pi*h^2)^(d/2))),x_evi(:,1),x_evi(:,2));
elseif d == 3
    rho = @(x) arrayfun(@(z1,z2,z3) (exp(-norm(x - [z1,z2,z3],2)^2/(2*h^2))/((2*pi*h^2)^(d/2))),x_evi(:,1),x_evi(:,2),x_evi(:,3));
end
end