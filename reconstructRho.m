function rho = reconstructRho(x_evi,N)
%%%%%%%%%%%%%%%%%%%%%%
% Input:
%    -- x_evi: approximated values from rho

% Output:
%    --rho: reconstructed approximate distribution
%%%%%%%%%%%%%%%%%%%%%%

rho =@(x) 0;
for i = 1:N
    rho = @(x) rho(x) + dirac(x - x_evi(i,:))/N;
end

end