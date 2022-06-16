function  err = rhoError(XY,dx,rho_x,rho_star)
[n_particles,d] = size(XY);

if d == 1
    %%% Calculate 1D error for numerical solution using trapezoidal rule
    intTrue = 0;
    intNum = 0;
    for j =1:(n_particles-1)
        intNum = intNum + ((rho_x(j)+rho_x(j+1))/2)*dx;
        intTrue = intTrue + ((rho_star(j)+rho_star(j+1))/2)*dx;
    end
    err = abs(intTrue-intNum)/intTrue;
    
elseif d == 2
    %%% Calculate 2D error for numerical solution using trapezoidal rule
    intTrue = 0;
    intNum = 0;
    for j =1:(n_particles-1)
        intNum = intNum + ((rho_x(j)+rho_x(j+1))/2)*(dx^2);
        intTrue = intTrue + ((rho_star(j)+rho_star(j+1))/2)*(dx^2);
    end
    err = abs(intTrue-intNum)/intTrue;
    
elseif d == 3
    %%% Calculate 3D error for numerical solution using trapezoidal rule
    intTrue = 0;
    intNum = 0;
    for j =1:(n_particles-1)
        intNum = intNum + ((rho_x(j)+rho_x(j+1))/2)*(dx^3);
        intTrue = intTrue + ((rho_star(j)+rho_star(j+1))/2)*(dx^3);
    end
    err = abs(intTrue-intNum)/intTrue;
end

end