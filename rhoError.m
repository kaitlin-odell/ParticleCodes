function  err = rhoError(XY,rho_x)
[n_particles,d] = size(XY);

if d == 1
    %%% Calculate 1D error for numerical solution using trapezoidal rule
    intTrue = 1;
    intNum = 0;
    for j =1:(n_particles-1)
        intNum = intNum + (abs(rho_x(j)+rho_x(j+1))/2)*(XY(j+1,1)-XY(j,1));
    end
    err = abs(intTrue-intNum)/intTrue;
    
elseif d == 2
    %%% Calculate 2D error for numerical solution using trapezoidal rule
    intTrue = 1;
    intNum = 0;
    for j =1:(n_particles-1)
        intNum = intNum + (abs(rho_x(j)+rho_x(j+1))/2)*(XY(j+1,1)-XY(j,1))*(XY(j+1,2)-XY(j,2));
    end
    err = abs(intTrue-intNum)/intTrue;
    
elseif d == 3
    %%% Calculate 3D error for numerical solution using trapezoidal rule
    intTrue = 1;
    intNum = 0;
    for j =1:(n_particles-1)
        intNum = intNum + (abs(rho_x(j)+rho_x(j+1))/2)*(XY(j+1,1)-XY(j,1))*(XY(j+1,2)-XY(j,2))*(XY(j+1,3)-XY(j,3));
    end
    err = abs(intTrue-intNum)/intTrue;
end

end